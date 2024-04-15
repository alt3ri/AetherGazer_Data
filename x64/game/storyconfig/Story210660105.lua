return {
	Play1106605001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106605001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106605002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

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
				local var_4_5 = arg_1_1.bgs_.ST12

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
					if iter_4_0 ~= "ST12" then
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
			local var_4_23 = 0.533333333333333

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_26 = 0.633333333333333
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")
			end

			local var_4_30 = 0
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.85

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(1106605001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 34
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1106605002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1106605003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.925

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

				local var_10_2 = arg_7_1:GetWordFromCfg(1106605002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 37
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
	Play1106605003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1106605003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1106605004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.125

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

				local var_14_2 = arg_11_1:GetWordFromCfg(1106605003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 45
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
	Play1106605004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1106605004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1106605005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.7

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

				local var_18_2 = arg_15_1:GetWordFromCfg(1106605004)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 28
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
	Play1106605005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1106605005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1106605006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.75

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_2 = arg_19_1:GetWordFromCfg(1106605005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 30
				local var_22_5 = utf8.len(var_22_3)
				local var_22_6 = var_22_4 <= 0 and var_22_1 or var_22_1 * (var_22_5 / var_22_4)

				if var_22_6 > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_7 and arg_19_1.time_ < var_22_0 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 1106605006
		arg_23_1.duration_ = 9

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play1106605007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "ST01"

			if arg_23_1.bgs_[var_26_0] == nil then
				local var_26_1 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_26_0)
				var_26_1.name = var_26_0
				var_26_1.transform.parent = arg_23_1.stage_.transform
				var_26_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_[var_26_0] = var_26_1
			end

			local var_26_2 = 2

			if var_26_2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				local var_26_3 = manager.ui.mainCamera.transform.localPosition
				local var_26_4 = Vector3.New(0, 0, 10) + Vector3.New(var_26_3.x, var_26_3.y, 0)
				local var_26_5 = arg_23_1.bgs_.ST01

				var_26_5.transform.localPosition = var_26_4
				var_26_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_6 = var_26_5:GetComponent("SpriteRenderer")

				if var_26_6 and var_26_6.sprite then
					local var_26_7 = (var_26_5.transform.localPosition - var_26_3).z
					local var_26_8 = manager.ui.mainCameraCom_
					local var_26_9 = 2 * var_26_7 * Mathf.Tan(var_26_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_26_10 = var_26_9 * var_26_8.aspect
					local var_26_11 = var_26_6.sprite.bounds.size.x
					local var_26_12 = var_26_6.sprite.bounds.size.y
					local var_26_13 = var_26_10 / var_26_11
					local var_26_14 = var_26_9 / var_26_12
					local var_26_15 = var_26_14 < var_26_13 and var_26_13 or var_26_14

					var_26_5.transform.localScale = Vector3.New(var_26_15, var_26_15, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "ST01" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_17 = 2

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 then
				local var_26_18 = (arg_23_1.time_ - var_26_16) / var_26_17
				local var_26_19 = Color.New(0, 0, 0)

				var_26_19.a = Mathf.Lerp(0, 1, var_26_18)
				arg_23_1.mask_.color = var_26_19
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 then
				local var_26_20 = Color.New(0, 0, 0)

				var_26_20.a = 1
				arg_23_1.mask_.color = var_26_20
			end

			local var_26_21 = 2

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_22 = 2

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_22 then
				local var_26_23 = (arg_23_1.time_ - var_26_21) / var_26_22
				local var_26_24 = Color.New(0, 0, 0)

				var_26_24.a = Mathf.Lerp(1, 0, var_26_23)
				arg_23_1.mask_.color = var_26_24
			end

			if arg_23_1.time_ >= var_26_21 + var_26_22 and arg_23_1.time_ < var_26_21 + var_26_22 + arg_26_0 then
				local var_26_25 = Color.New(0, 0, 0)
				local var_26_26 = 0

				arg_23_1.mask_.enabled = false
				var_26_25.a = var_26_26
				arg_23_1.mask_.color = var_26_25
			end

			local var_26_27 = manager.ui.mainCamera.transform
			local var_26_28 = 4

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				arg_23_1.var_.shakeOldPos = var_26_27.localPosition
			end

			local var_26_29 = 0.433333333333333

			if var_26_28 <= arg_23_1.time_ and arg_23_1.time_ < var_26_28 + var_26_29 then
				local var_26_30 = (arg_23_1.time_ - var_26_28) / 0.198
				local var_26_31, var_26_32 = math.modf(var_26_30)

				var_26_27.localPosition = Vector3.New(var_26_32 * 0.13, var_26_32 * 0.13, var_26_32 * 0.13) + arg_23_1.var_.shakeOldPos
			end

			if arg_23_1.time_ >= var_26_28 + var_26_29 and arg_23_1.time_ < var_26_28 + var_26_29 + arg_26_0 then
				var_26_27.localPosition = arg_23_1.var_.shakeOldPos
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_33 = 4
			local var_26_34 = 0.075

			if var_26_33 < arg_23_1.time_ and arg_23_1.time_ <= var_26_33 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				local var_26_35 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_35:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_36 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_37 = arg_23_1:GetWordFromCfg(1106605006)
				local var_26_38 = arg_23_1:FormatText(var_26_37.content)

				arg_23_1.text_.text = var_26_38

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_39 = 3
				local var_26_40 = utf8.len(var_26_38)
				local var_26_41 = var_26_39 <= 0 and var_26_34 or var_26_34 * (var_26_40 / var_26_39)

				if var_26_41 > 0 and var_26_34 < var_26_41 then
					arg_23_1.talkMaxDuration = var_26_41
					var_26_33 = var_26_33 + 0.3

					if var_26_41 + var_26_33 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_41 + var_26_33
					end
				end

				arg_23_1.text_.text = var_26_38
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_42 = var_26_33 + 0.3
			local var_26_43 = math.max(var_26_34, arg_23_1.talkMaxDuration)

			if var_26_42 <= arg_23_1.time_ and arg_23_1.time_ < var_26_42 + var_26_43 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_42) / var_26_43

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_42 + var_26_43 and arg_23_1.time_ < var_26_42 + var_26_43 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106605007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1106605008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1066ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(Asset.Load("Char/" .. var_32_0), arg_29_1.stage_.transform)

				var_32_1.name = var_32_0
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_[var_32_0] = var_32_1

				local var_32_2 = var_32_1:GetComponentInChildren(typeof(CharacterEffect))

				var_32_2.enabled = true

				local var_32_3 = GameObjectTools.GetOrAddComponent(var_32_1, typeof(DynamicBoneHelper))

				if var_32_3 then
					var_32_3:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_2.transform, false)

				arg_29_1.var_[var_32_0 .. "Animator"] = var_32_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
				arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_4 = arg_29_1.actors_["1066ui_story"].transform
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.var_.moveOldPos1066ui_story = var_32_4.localPosition
			end

			local var_32_6 = 0.001

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6
				local var_32_8 = Vector3.New(0, -0.77, -6.1)

				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1066ui_story, var_32_8, var_32_7)

				local var_32_9 = manager.ui.mainCamera.transform.position - var_32_4.position

				var_32_4.forward = Vector3.New(var_32_9.x, var_32_9.y, var_32_9.z)

				local var_32_10 = var_32_4.localEulerAngles

				var_32_10.z = 0
				var_32_10.x = 0
				var_32_4.localEulerAngles = var_32_10
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_32_11 = manager.ui.mainCamera.transform.position - var_32_4.position

				var_32_4.forward = Vector3.New(var_32_11.x, var_32_11.y, var_32_11.z)

				local var_32_12 = var_32_4.localEulerAngles

				var_32_12.z = 0
				var_32_12.x = 0
				var_32_4.localEulerAngles = var_32_12
			end

			local var_32_13 = arg_29_1.actors_["1066ui_story"]
			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.0166666666666667

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_15 then
				local var_32_16 = (arg_29_1.time_ - var_32_14) / var_32_15

				if arg_29_1.var_.characterEffect1066ui_story then
					local var_32_17 = Mathf.Lerp(0, 0.5, var_32_16)

					arg_29_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1066ui_story.fillRatio = var_32_17
				end
			end

			if arg_29_1.time_ >= var_32_14 + var_32_15 and arg_29_1.time_ < var_32_14 + var_32_15 + arg_32_0 and arg_29_1.var_.characterEffect1066ui_story then
				local var_32_18 = 0.5

				arg_29_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1066ui_story.fillRatio = var_32_18
			end

			local var_32_19 = 0

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			local var_32_20 = 0
			local var_32_21 = 1.175

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_22 = arg_29_1:GetWordFromCfg(1106605007)
				local var_32_23 = arg_29_1:FormatText(var_32_22.content)

				arg_29_1.text_.text = var_32_23

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_24 = 47
				local var_32_25 = utf8.len(var_32_23)
				local var_32_26 = var_32_24 <= 0 and var_32_21 or var_32_21 * (var_32_25 / var_32_24)

				if var_32_26 > 0 and var_32_21 < var_32_26 then
					arg_29_1.talkMaxDuration = var_32_26

					if var_32_26 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_26 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_23
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_27 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_27 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_27

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_27 and arg_29_1.time_ < var_32_20 + var_32_27 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106605008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106605009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.425

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(1106605008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 17
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106605009
		arg_37_1.duration_ = 3.433

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1106605010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1066ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1066ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -0.77, -6.1)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1066ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1066ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1066ui_story then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_40_15 = 0
			local var_40_16 = 0.225

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[32].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(1106605009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 9
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605009", "story_v_side_new_1106605.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605009", "story_v_side_new_1106605.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_side_new_1106605", "1106605009", "story_v_side_new_1106605.awb")

						arg_37_1:RecordAudio("1106605009", var_40_24)
						arg_37_1:RecordAudio("1106605009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605009", "story_v_side_new_1106605.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605009", "story_v_side_new_1106605.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106605010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1106605011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1066ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1066ui_story then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1066ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and arg_41_1.var_.characterEffect1066ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1066ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.175

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(1106605010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 7
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106605011
		arg_45_1.duration_ = 3.066

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106605012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1066ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1066ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -0.77, -6.1)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1066ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1066ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1066ui_story then
					arg_45_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and arg_45_1.var_.characterEffect1066ui_story then
				arg_45_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action452")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_48_15 = 0
			local var_48_16 = 0.25

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[32].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(1106605011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 10
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605011", "story_v_side_new_1106605.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605011", "story_v_side_new_1106605.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_side_new_1106605", "1106605011", "story_v_side_new_1106605.awb")

						arg_45_1:RecordAudio("1106605011", var_48_24)
						arg_45_1:RecordAudio("1106605011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605011", "story_v_side_new_1106605.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605011", "story_v_side_new_1106605.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106605012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1106605013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1066ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1066ui_story then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1066ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and arg_49_1.var_.characterEffect1066ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1066ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.075

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[7].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(1106605012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 3
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106605013
		arg_53_1.duration_ = 7.366

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106605014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1066ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1066ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, -0.77, -6.1)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1066ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1066ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1066ui_story then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action428")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_56_15 = 0
			local var_56_16 = 0.875

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[32].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(1106605013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 35
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605013", "story_v_side_new_1106605.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605013", "story_v_side_new_1106605.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_side_new_1106605", "1106605013", "story_v_side_new_1106605.awb")

						arg_53_1:RecordAudio("1106605013", var_56_24)
						arg_53_1:RecordAudio("1106605013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605013", "story_v_side_new_1106605.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605013", "story_v_side_new_1106605.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106605014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1106605015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1066ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and arg_57_1.var_.characterEffect1066ui_story == nil then
				arg_57_1.var_.characterEffect1066ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1066ui_story then
					local var_60_4 = Mathf.Lerp(0, 0.5, var_60_3)

					arg_57_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1066ui_story.fillRatio = var_60_4
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and arg_57_1.var_.characterEffect1066ui_story then
				local var_60_5 = 0.5

				arg_57_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1066ui_story.fillRatio = var_60_5
			end

			local var_60_6 = 0
			local var_60_7 = 0.9

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(1106605014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 36
				local var_60_11 = utf8.len(var_60_9)
				local var_60_12 = var_60_10 <= 0 and var_60_7 or var_60_7 * (var_60_11 / var_60_10)

				if var_60_12 > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_13 and arg_57_1.time_ < var_60_6 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106605015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1106605016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.475

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(1106605015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 19
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106605016
		arg_65_1.duration_ = 3.6

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1106605017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1066ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1066ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -0.77, -6.1)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1066ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1066ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and arg_65_1.var_.characterEffect1066ui_story == nil then
				arg_65_1.var_.characterEffect1066ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1066ui_story then
					arg_65_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and arg_65_1.var_.characterEffect1066ui_story then
				arg_65_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action8_2")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_15 = 0
			local var_68_16 = 0.4

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[32].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(1106605016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 16
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605016", "story_v_side_new_1106605.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605016", "story_v_side_new_1106605.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_side_new_1106605", "1106605016", "story_v_side_new_1106605.awb")

						arg_65_1:RecordAudio("1106605016", var_68_24)
						arg_65_1:RecordAudio("1106605016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605016", "story_v_side_new_1106605.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605016", "story_v_side_new_1106605.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106605017
		arg_69_1.duration_ = 0.999999999999

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"

			SetActive(arg_69_1.choicesGo_, true)

			for iter_70_0, iter_70_1 in ipairs(arg_69_1.choices_) do
				local var_70_0 = iter_70_0 <= 1

				SetActive(iter_70_1.go, var_70_0)
			end

			arg_69_1.choices_[1].txt.text = arg_69_1:FormatText(StoryChoiceCfg[537].name)
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106605018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1066ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and arg_69_1.var_.characterEffect1066ui_story == nil then
				arg_69_1.var_.characterEffect1066ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1066ui_story then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1066ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and arg_69_1.var_.characterEffect1066ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1066ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_7 = 0.5

			if arg_69_1.time_ >= var_72_6 + var_72_7 and arg_69_1.time_ < var_72_6 + var_72_7 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106605018
		arg_73_1.duration_ = 3.3

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1106605019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1066ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1066ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -0.77, -6.1)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1066ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1066ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and arg_73_1.var_.characterEffect1066ui_story == nil then
				arg_73_1.var_.characterEffect1066ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1066ui_story then
					arg_73_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and arg_73_1.var_.characterEffect1066ui_story then
				arg_73_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_14 = 0
			local var_76_15 = 0.4

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_16 = arg_73_1:FormatText(StoryNameCfg[32].name)

				arg_73_1.leftNameTxt_.text = var_76_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(1106605018)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 16
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_15 or var_76_15 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_15 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_14
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605018", "story_v_side_new_1106605.awb") ~= 0 then
					local var_76_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605018", "story_v_side_new_1106605.awb") / 1000

					if var_76_22 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_14
					end

					if var_76_17.prefab_name ~= "" and arg_73_1.actors_[var_76_17.prefab_name] ~= nil then
						local var_76_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_17.prefab_name].transform, "story_v_side_new_1106605", "1106605018", "story_v_side_new_1106605.awb")

						arg_73_1:RecordAudio("1106605018", var_76_23)
						arg_73_1:RecordAudio("1106605018", var_76_23)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605018", "story_v_side_new_1106605.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605018", "story_v_side_new_1106605.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_24 = math.max(var_76_15, arg_73_1.talkMaxDuration)

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_24 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_14) / var_76_24

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_14 + var_76_24 and arg_73_1.time_ < var_76_14 + var_76_24 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106605019
		arg_77_1.duration_ = 0.999999999999

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"

			SetActive(arg_77_1.choicesGo_, true)

			for iter_78_0, iter_78_1 in ipairs(arg_77_1.choices_) do
				local var_78_0 = iter_78_0 <= 1

				SetActive(iter_78_1.go, var_78_0)
			end

			arg_77_1.choices_[1].txt.text = arg_77_1:FormatText(StoryChoiceCfg[538].name)
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106605020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1066ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and arg_77_1.var_.characterEffect1066ui_story == nil then
				arg_77_1.var_.characterEffect1066ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1066ui_story then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1066ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and arg_77_1.var_.characterEffect1066ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1066ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_7 = 0.5

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106605020
		arg_81_1.duration_ = 12.833

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1106605021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1066ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1066ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, -0.77, -6.1)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1066ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1066ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and arg_81_1.var_.characterEffect1066ui_story == nil then
				arg_81_1.var_.characterEffect1066ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1066ui_story then
					arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and arg_81_1.var_.characterEffect1066ui_story then
				arg_81_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_15 = 0
			local var_84_16 = 1.475

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[32].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(1106605020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 59
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605020", "story_v_side_new_1106605.awb") ~= 0 then
					local var_84_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605020", "story_v_side_new_1106605.awb") / 1000

					if var_84_23 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_23 + var_84_15
					end

					if var_84_18.prefab_name ~= "" and arg_81_1.actors_[var_84_18.prefab_name] ~= nil then
						local var_84_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_18.prefab_name].transform, "story_v_side_new_1106605", "1106605020", "story_v_side_new_1106605.awb")

						arg_81_1:RecordAudio("1106605020", var_84_24)
						arg_81_1:RecordAudio("1106605020", var_84_24)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605020", "story_v_side_new_1106605.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605020", "story_v_side_new_1106605.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_25 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_25 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_25

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_25 and arg_81_1.time_ < var_84_15 + var_84_25 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106605021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1106605022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1066ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and arg_85_1.var_.characterEffect1066ui_story == nil then
				arg_85_1.var_.characterEffect1066ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1066ui_story then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1066ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and arg_85_1.var_.characterEffect1066ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1066ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.15

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(1106605021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 6
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106605022
		arg_89_1.duration_ = 2.033

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1106605023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1066ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1066ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.77, -6.1)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1066ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1066ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and arg_89_1.var_.characterEffect1066ui_story == nil then
				arg_89_1.var_.characterEffect1066ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1066ui_story then
					arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and arg_89_1.var_.characterEffect1066ui_story then
				arg_89_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_15 = 0
			local var_92_16 = 0.225

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[32].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(1106605022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 9
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605022", "story_v_side_new_1106605.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605022", "story_v_side_new_1106605.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_side_new_1106605", "1106605022", "story_v_side_new_1106605.awb")

						arg_89_1:RecordAudio("1106605022", var_92_24)
						arg_89_1:RecordAudio("1106605022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605022", "story_v_side_new_1106605.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605022", "story_v_side_new_1106605.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106605023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106605024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1066ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and arg_93_1.var_.characterEffect1066ui_story == nil then
				arg_93_1.var_.characterEffect1066ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1066ui_story then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1066ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and arg_93_1.var_.characterEffect1066ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1066ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.625

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(1106605023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 25
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106605024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1106605025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action443")
			end

			local var_100_1 = 0
			local var_100_2 = 0.525

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(1106605024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 21
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_2 or var_100_2 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_2 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_8 and arg_97_1.time_ < var_100_1 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106605025
		arg_101_1.duration_ = 7.933

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106605026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1066ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1066ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.77, -6.1)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1066ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1066ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and arg_101_1.var_.characterEffect1066ui_story == nil then
				arg_101_1.var_.characterEffect1066ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1066ui_story then
					arg_101_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and arg_101_1.var_.characterEffect1066ui_story then
				arg_101_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_104_14 = 0
			local var_104_15 = 0.8

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_16 = arg_101_1:FormatText(StoryNameCfg[32].name)

				arg_101_1.leftNameTxt_.text = var_104_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(1106605025)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 32
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_15 or var_104_15 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_15 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_14
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605025", "story_v_side_new_1106605.awb") ~= 0 then
					local var_104_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605025", "story_v_side_new_1106605.awb") / 1000

					if var_104_22 + var_104_14 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_14
					end

					if var_104_17.prefab_name ~= "" and arg_101_1.actors_[var_104_17.prefab_name] ~= nil then
						local var_104_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_17.prefab_name].transform, "story_v_side_new_1106605", "1106605025", "story_v_side_new_1106605.awb")

						arg_101_1:RecordAudio("1106605025", var_104_23)
						arg_101_1:RecordAudio("1106605025", var_104_23)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605025", "story_v_side_new_1106605.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605025", "story_v_side_new_1106605.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_24 = math.max(var_104_15, arg_101_1.talkMaxDuration)

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_24 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_14) / var_104_24

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_14 + var_104_24 and arg_101_1.time_ < var_104_14 + var_104_24 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106605026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1106605027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1066ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and arg_105_1.var_.characterEffect1066ui_story == nil then
				arg_105_1.var_.characterEffect1066ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1066ui_story then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1066ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and arg_105_1.var_.characterEffect1066ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1066ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 0.425

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:GetWordFromCfg(1106605026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 17
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1106605027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1106605028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_2")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_2 = 0
			local var_112_3 = 1.375

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(1106605027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 55
				local var_112_7 = utf8.len(var_112_5)
				local var_112_8 = var_112_6 <= 0 and var_112_3 or var_112_3 * (var_112_7 / var_112_6)

				if var_112_8 > 0 and var_112_3 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_9 and arg_109_1.time_ < var_112_2 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1106605028
		arg_113_1.duration_ = 4.7

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1106605029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1066ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1066ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -0.77, -6.1)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1066ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1066ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and arg_113_1.var_.characterEffect1066ui_story == nil then
				arg_113_1.var_.characterEffect1066ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1066ui_story then
					arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and arg_113_1.var_.characterEffect1066ui_story then
				arg_113_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_116_14 = 0
			local var_116_15 = 0.525

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_16 = arg_113_1:FormatText(StoryNameCfg[32].name)

				arg_113_1.leftNameTxt_.text = var_116_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:GetWordFromCfg(1106605028)
				local var_116_18 = arg_113_1:FormatText(var_116_17.content)

				arg_113_1.text_.text = var_116_18

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 21
				local var_116_20 = utf8.len(var_116_18)
				local var_116_21 = var_116_19 <= 0 and var_116_15 or var_116_15 * (var_116_20 / var_116_19)

				if var_116_21 > 0 and var_116_15 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21

					if var_116_21 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_18
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605028", "story_v_side_new_1106605.awb") ~= 0 then
					local var_116_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605028", "story_v_side_new_1106605.awb") / 1000

					if var_116_22 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_14
					end

					if var_116_17.prefab_name ~= "" and arg_113_1.actors_[var_116_17.prefab_name] ~= nil then
						local var_116_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_17.prefab_name].transform, "story_v_side_new_1106605", "1106605028", "story_v_side_new_1106605.awb")

						arg_113_1:RecordAudio("1106605028", var_116_23)
						arg_113_1:RecordAudio("1106605028", var_116_23)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605028", "story_v_side_new_1106605.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605028", "story_v_side_new_1106605.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_24 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_24

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_24 and arg_113_1.time_ < var_116_14 + var_116_24 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1106605029
		arg_117_1.duration_ = 3.066

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1106605030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1066ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1066ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -0.77, -6.1)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1066ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1066ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and arg_117_1.var_.characterEffect1066ui_story == nil then
				arg_117_1.var_.characterEffect1066ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1066ui_story then
					arg_117_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and arg_117_1.var_.characterEffect1066ui_story then
				arg_117_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_15 = 0
			local var_120_16 = 0.35

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[32].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(1106605029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 14
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605029", "story_v_side_new_1106605.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605029", "story_v_side_new_1106605.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_side_new_1106605", "1106605029", "story_v_side_new_1106605.awb")

						arg_117_1:RecordAudio("1106605029", var_120_24)
						arg_117_1:RecordAudio("1106605029", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605029", "story_v_side_new_1106605.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605029", "story_v_side_new_1106605.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1106605030
		arg_121_1.duration_ = 9

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1106605031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = "ST15"

			if arg_121_1.bgs_[var_124_0] == nil then
				local var_124_1 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_124_0)
				var_124_1.name = var_124_0
				var_124_1.transform.parent = arg_121_1.stage_.transform
				var_124_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_[var_124_0] = var_124_1
			end

			local var_124_2 = 2

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				local var_124_3 = manager.ui.mainCamera.transform.localPosition
				local var_124_4 = Vector3.New(0, 0, 10) + Vector3.New(var_124_3.x, var_124_3.y, 0)
				local var_124_5 = arg_121_1.bgs_.ST15

				var_124_5.transform.localPosition = var_124_4
				var_124_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_6 = var_124_5:GetComponent("SpriteRenderer")

				if var_124_6 and var_124_6.sprite then
					local var_124_7 = (var_124_5.transform.localPosition - var_124_3).z
					local var_124_8 = manager.ui.mainCameraCom_
					local var_124_9 = 2 * var_124_7 * Mathf.Tan(var_124_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_10 = var_124_9 * var_124_8.aspect
					local var_124_11 = var_124_6.sprite.bounds.size.x
					local var_124_12 = var_124_6.sprite.bounds.size.y
					local var_124_13 = var_124_10 / var_124_11
					local var_124_14 = var_124_9 / var_124_12
					local var_124_15 = var_124_14 < var_124_13 and var_124_13 or var_124_14

					var_124_5.transform.localScale = Vector3.New(var_124_15, var_124_15, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST15" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_17 = 2

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17
				local var_124_19 = Color.New(0, 0, 0)

				var_124_19.a = Mathf.Lerp(0, 1, var_124_18)
				arg_121_1.mask_.color = var_124_19
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				local var_124_20 = Color.New(0, 0, 0)

				var_124_20.a = 1
				arg_121_1.mask_.color = var_124_20
			end

			local var_124_21 = 2

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_22 = 2

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_22 then
				local var_124_23 = (arg_121_1.time_ - var_124_21) / var_124_22
				local var_124_24 = Color.New(0, 0, 0)

				var_124_24.a = Mathf.Lerp(1, 0, var_124_23)
				arg_121_1.mask_.color = var_124_24
			end

			if arg_121_1.time_ >= var_124_21 + var_124_22 and arg_121_1.time_ < var_124_21 + var_124_22 + arg_124_0 then
				local var_124_25 = Color.New(0, 0, 0)
				local var_124_26 = 0

				arg_121_1.mask_.enabled = false
				var_124_25.a = var_124_26
				arg_121_1.mask_.color = var_124_25
			end

			local var_124_27 = arg_121_1.actors_["1066ui_story"].transform
			local var_124_28 = 2

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1.var_.moveOldPos1066ui_story = var_124_27.localPosition
			end

			local var_124_29 = 0.001

			if var_124_28 <= arg_121_1.time_ and arg_121_1.time_ < var_124_28 + var_124_29 then
				local var_124_30 = (arg_121_1.time_ - var_124_28) / var_124_29
				local var_124_31 = Vector3.New(0, 100, 0)

				var_124_27.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1066ui_story, var_124_31, var_124_30)

				local var_124_32 = manager.ui.mainCamera.transform.position - var_124_27.position

				var_124_27.forward = Vector3.New(var_124_32.x, var_124_32.y, var_124_32.z)

				local var_124_33 = var_124_27.localEulerAngles

				var_124_33.z = 0
				var_124_33.x = 0
				var_124_27.localEulerAngles = var_124_33
			end

			if arg_121_1.time_ >= var_124_28 + var_124_29 and arg_121_1.time_ < var_124_28 + var_124_29 + arg_124_0 then
				var_124_27.localPosition = Vector3.New(0, 100, 0)

				local var_124_34 = manager.ui.mainCamera.transform.position - var_124_27.position

				var_124_27.forward = Vector3.New(var_124_34.x, var_124_34.y, var_124_34.z)

				local var_124_35 = var_124_27.localEulerAngles

				var_124_35.z = 0
				var_124_35.x = 0
				var_124_27.localEulerAngles = var_124_35
			end

			local var_124_36 = 0
			local var_124_37 = 1

			if var_124_36 < arg_121_1.time_ and arg_121_1.time_ <= var_124_36 + arg_124_0 then
				local var_124_38 = "play"
				local var_124_39 = "effect"

				arg_121_1:AudioAction(var_124_38, var_124_39, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_40 = 4
			local var_124_41 = 1.425

			if var_124_40 < arg_121_1.time_ and arg_121_1.time_ <= var_124_40 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				local var_124_42 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_42:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_43 = arg_121_1:GetWordFromCfg(1106605030)
				local var_124_44 = arg_121_1:FormatText(var_124_43.content)

				arg_121_1.text_.text = var_124_44

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_45 = 57
				local var_124_46 = utf8.len(var_124_44)
				local var_124_47 = var_124_45 <= 0 and var_124_41 or var_124_41 * (var_124_46 / var_124_45)

				if var_124_47 > 0 and var_124_41 < var_124_47 then
					arg_121_1.talkMaxDuration = var_124_47
					var_124_40 = var_124_40 + 0.3

					if var_124_47 + var_124_40 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_47 + var_124_40
					end
				end

				arg_121_1.text_.text = var_124_44
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_48 = var_124_40 + 0.3
			local var_124_49 = math.max(var_124_41, arg_121_1.talkMaxDuration)

			if var_124_48 <= arg_121_1.time_ and arg_121_1.time_ < var_124_48 + var_124_49 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_48) / var_124_49

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_48 + var_124_49 and arg_121_1.time_ < var_124_48 + var_124_49 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1106605031
		arg_127_1.duration_ = 4.2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1106605032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "106603ui_story"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(Asset.Load("Char/" .. var_130_0), arg_127_1.stage_.transform)

				var_130_1.name = var_130_0
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_[var_130_0] = var_130_1

				local var_130_2 = var_130_1:GetComponentInChildren(typeof(CharacterEffect))

				var_130_2.enabled = true

				local var_130_3 = GameObjectTools.GetOrAddComponent(var_130_1, typeof(DynamicBoneHelper))

				if var_130_3 then
					var_130_3:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_2.transform, false)

				arg_127_1.var_[var_130_0 .. "Animator"] = var_130_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_[var_130_0 .. "Animator"].applyRootMotion = true
				arg_127_1.var_[var_130_0 .. "LipSync"] = var_130_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_4 = arg_127_1.actors_["106603ui_story"].transform
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.var_.moveOldPos106603ui_story = var_130_4.localPosition
			end

			local var_130_6 = 0.001

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = (arg_127_1.time_ - var_130_5) / var_130_6
				local var_130_8 = Vector3.New(0, -0.77, -6.25)

				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos106603ui_story, var_130_8, var_130_7)

				local var_130_9 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_9.x, var_130_9.y, var_130_9.z)

				local var_130_10 = var_130_4.localEulerAngles

				var_130_10.z = 0
				var_130_10.x = 0
				var_130_4.localEulerAngles = var_130_10
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_130_11 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_11.x, var_130_11.y, var_130_11.z)

				local var_130_12 = var_130_4.localEulerAngles

				var_130_12.z = 0
				var_130_12.x = 0
				var_130_4.localEulerAngles = var_130_12
			end

			local var_130_13 = arg_127_1.actors_["106603ui_story"]
			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 and arg_127_1.var_.characterEffect106603ui_story == nil then
				arg_127_1.var_.characterEffect106603ui_story = var_130_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_15 = 0.200000002980232

			if var_130_14 <= arg_127_1.time_ and arg_127_1.time_ < var_130_14 + var_130_15 then
				local var_130_16 = (arg_127_1.time_ - var_130_14) / var_130_15

				if arg_127_1.var_.characterEffect106603ui_story then
					arg_127_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_14 + var_130_15 and arg_127_1.time_ < var_130_14 + var_130_15 + arg_130_0 and arg_127_1.var_.characterEffect106603ui_story then
				arg_127_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_130_17 = 0

			if var_130_17 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_1")
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_130_19 = 0
			local var_130_20 = 0.3

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_21 = arg_127_1:FormatText(StoryNameCfg[32].name)

				arg_127_1.leftNameTxt_.text = var_130_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_22 = arg_127_1:GetWordFromCfg(1106605031)
				local var_130_23 = arg_127_1:FormatText(var_130_22.content)

				arg_127_1.text_.text = var_130_23

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_24 = 12
				local var_130_25 = utf8.len(var_130_23)
				local var_130_26 = var_130_24 <= 0 and var_130_20 or var_130_20 * (var_130_25 / var_130_24)

				if var_130_26 > 0 and var_130_20 < var_130_26 then
					arg_127_1.talkMaxDuration = var_130_26

					if var_130_26 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_26 + var_130_19
					end
				end

				arg_127_1.text_.text = var_130_23
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605031", "story_v_side_new_1106605.awb") ~= 0 then
					local var_130_27 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605031", "story_v_side_new_1106605.awb") / 1000

					if var_130_27 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_19
					end

					if var_130_22.prefab_name ~= "" and arg_127_1.actors_[var_130_22.prefab_name] ~= nil then
						local var_130_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_22.prefab_name].transform, "story_v_side_new_1106605", "1106605031", "story_v_side_new_1106605.awb")

						arg_127_1:RecordAudio("1106605031", var_130_28)
						arg_127_1:RecordAudio("1106605031", var_130_28)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605031", "story_v_side_new_1106605.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605031", "story_v_side_new_1106605.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_20, arg_127_1.talkMaxDuration)

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_29 and arg_127_1.time_ < var_130_19 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1106605032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1106605033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["106603ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and arg_131_1.var_.characterEffect106603ui_story == nil then
				arg_131_1.var_.characterEffect106603ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect106603ui_story then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_131_1.var_.characterEffect106603ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and arg_131_1.var_.characterEffect106603ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_131_1.var_.characterEffect106603ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.425

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_9 = arg_131_1:GetWordFromCfg(1106605032)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 17
				local var_134_12 = utf8.len(var_134_10)
				local var_134_13 = var_134_11 <= 0 and var_134_7 or var_134_7 * (var_134_12 / var_134_11)

				if var_134_13 > 0 and var_134_7 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1106605033
		arg_135_1.duration_ = 5.4

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1106605034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["106603ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos106603ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -0.77, -6.25)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos106603ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["106603ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and arg_135_1.var_.characterEffect106603ui_story == nil then
				arg_135_1.var_.characterEffect106603ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect106603ui_story then
					arg_135_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and arg_135_1.var_.characterEffect106603ui_story then
				arg_135_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_138_13 = 0
			local var_138_14 = 0.625

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_15 = arg_135_1:FormatText(StoryNameCfg[32].name)

				arg_135_1.leftNameTxt_.text = var_138_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_16 = arg_135_1:GetWordFromCfg(1106605033)
				local var_138_17 = arg_135_1:FormatText(var_138_16.content)

				arg_135_1.text_.text = var_138_17

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_18 = 25
				local var_138_19 = utf8.len(var_138_17)
				local var_138_20 = var_138_18 <= 0 and var_138_14 or var_138_14 * (var_138_19 / var_138_18)

				if var_138_20 > 0 and var_138_14 < var_138_20 then
					arg_135_1.talkMaxDuration = var_138_20

					if var_138_20 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_20 + var_138_13
					end
				end

				arg_135_1.text_.text = var_138_17
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605033", "story_v_side_new_1106605.awb") ~= 0 then
					local var_138_21 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605033", "story_v_side_new_1106605.awb") / 1000

					if var_138_21 + var_138_13 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_21 + var_138_13
					end

					if var_138_16.prefab_name ~= "" and arg_135_1.actors_[var_138_16.prefab_name] ~= nil then
						local var_138_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_16.prefab_name].transform, "story_v_side_new_1106605", "1106605033", "story_v_side_new_1106605.awb")

						arg_135_1:RecordAudio("1106605033", var_138_22)
						arg_135_1:RecordAudio("1106605033", var_138_22)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605033", "story_v_side_new_1106605.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605033", "story_v_side_new_1106605.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_23 = math.max(var_138_14, arg_135_1.talkMaxDuration)

			if var_138_13 <= arg_135_1.time_ and arg_135_1.time_ < var_138_13 + var_138_23 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_13) / var_138_23

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_13 + var_138_23 and arg_135_1.time_ < var_138_13 + var_138_23 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1106605034
		arg_139_1.duration_ = 3.4

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1106605035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.375

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[32].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(1106605034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 15
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605034", "story_v_side_new_1106605.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605034", "story_v_side_new_1106605.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_side_new_1106605", "1106605034", "story_v_side_new_1106605.awb")

						arg_139_1:RecordAudio("1106605034", var_142_9)
						arg_139_1:RecordAudio("1106605034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605034", "story_v_side_new_1106605.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605034", "story_v_side_new_1106605.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1106605035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1106605036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["106603ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and arg_143_1.var_.characterEffect106603ui_story == nil then
				arg_143_1.var_.characterEffect106603ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect106603ui_story then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_143_1.var_.characterEffect106603ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and arg_143_1.var_.characterEffect106603ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_143_1.var_.characterEffect106603ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.125

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(1106605035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 5
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1106605036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1106605037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.3

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(1106605036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 52
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1106605037
		arg_151_1.duration_ = 1.999999999999

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1106605038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["106603ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos106603ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(0, -0.77, -6.25)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos106603ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["106603ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and arg_151_1.var_.characterEffect106603ui_story == nil then
				arg_151_1.var_.characterEffect106603ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect106603ui_story then
					arg_151_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and arg_151_1.var_.characterEffect106603ui_story then
				arg_151_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action435")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_154_15 = 0
			local var_154_16 = 0.075

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_17 = arg_151_1:FormatText(StoryNameCfg[32].name)

				arg_151_1.leftNameTxt_.text = var_154_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_18 = arg_151_1:GetWordFromCfg(1106605037)
				local var_154_19 = arg_151_1:FormatText(var_154_18.content)

				arg_151_1.text_.text = var_154_19

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_20 = 3
				local var_154_21 = utf8.len(var_154_19)
				local var_154_22 = var_154_20 <= 0 and var_154_16 or var_154_16 * (var_154_21 / var_154_20)

				if var_154_22 > 0 and var_154_16 < var_154_22 then
					arg_151_1.talkMaxDuration = var_154_22

					if var_154_22 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_22 + var_154_15
					end
				end

				arg_151_1.text_.text = var_154_19
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605037", "story_v_side_new_1106605.awb") ~= 0 then
					local var_154_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605037", "story_v_side_new_1106605.awb") / 1000

					if var_154_23 + var_154_15 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_23 + var_154_15
					end

					if var_154_18.prefab_name ~= "" and arg_151_1.actors_[var_154_18.prefab_name] ~= nil then
						local var_154_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_18.prefab_name].transform, "story_v_side_new_1106605", "1106605037", "story_v_side_new_1106605.awb")

						arg_151_1:RecordAudio("1106605037", var_154_24)
						arg_151_1:RecordAudio("1106605037", var_154_24)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605037", "story_v_side_new_1106605.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605037", "story_v_side_new_1106605.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_25 = math.max(var_154_16, arg_151_1.talkMaxDuration)

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_25 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_15) / var_154_25

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_15 + var_154_25 and arg_151_1.time_ < var_154_15 + var_154_25 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1106605038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1106605039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["106603ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and arg_155_1.var_.characterEffect106603ui_story == nil then
				arg_155_1.var_.characterEffect106603ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect106603ui_story then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_155_1.var_.characterEffect106603ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and arg_155_1.var_.characterEffect106603ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_155_1.var_.characterEffect106603ui_story.fillRatio = var_158_5
			end

			local var_158_6 = 0
			local var_158_7 = 0.45

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(1106605038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 18
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1106605039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1106605040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["106603ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos106603ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.77, -6.25)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos106603ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = 0

			if var_162_9 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action454")
			end

			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_162_11 = 0
			local var_162_12 = 0.65

			if var_162_11 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(1106605039)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 26
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_12 or var_162_12 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_12 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_11 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_11
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_12, arg_159_1.talkMaxDuration)

			if var_162_11 <= arg_159_1.time_ and arg_159_1.time_ < var_162_11 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_11) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_11 + var_162_18 and arg_159_1.time_ < var_162_11 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1106605040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1106605041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_2")
			end

			local var_166_1 = 0
			local var_166_2 = 0.1

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_3 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(1106605040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 4
				local var_166_7 = utf8.len(var_166_5)
				local var_166_8 = var_166_6 <= 0 and var_166_2 or var_166_2 * (var_166_7 / var_166_6)

				if var_166_8 > 0 and var_166_2 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_9 and arg_163_1.time_ < var_166_1 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1106605041
		arg_167_1.duration_ = 4.433

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1106605042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["106603ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos106603ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, -0.77, -6.25)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos106603ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = arg_167_1.actors_["106603ui_story"]
			local var_170_10 = 0

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 and arg_167_1.var_.characterEffect106603ui_story == nil then
				arg_167_1.var_.characterEffect106603ui_story = var_170_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_10) / var_170_11

				if arg_167_1.var_.characterEffect106603ui_story then
					arg_167_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_10 + var_170_11 and arg_167_1.time_ < var_170_10 + var_170_11 + arg_170_0 and arg_167_1.var_.characterEffect106603ui_story then
				arg_167_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_170_13 = 0

			if var_170_13 < arg_167_1.time_ and arg_167_1.time_ <= var_170_13 + arg_170_0 then
				arg_167_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_170_14 = 0
			local var_170_15 = 0.475

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_16 = arg_167_1:FormatText(StoryNameCfg[32].name)

				arg_167_1.leftNameTxt_.text = var_170_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_17 = arg_167_1:GetWordFromCfg(1106605041)
				local var_170_18 = arg_167_1:FormatText(var_170_17.content)

				arg_167_1.text_.text = var_170_18

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_19 = 19
				local var_170_20 = utf8.len(var_170_18)
				local var_170_21 = var_170_19 <= 0 and var_170_15 or var_170_15 * (var_170_20 / var_170_19)

				if var_170_21 > 0 and var_170_15 < var_170_21 then
					arg_167_1.talkMaxDuration = var_170_21

					if var_170_21 + var_170_14 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_21 + var_170_14
					end
				end

				arg_167_1.text_.text = var_170_18
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605041", "story_v_side_new_1106605.awb") ~= 0 then
					local var_170_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605041", "story_v_side_new_1106605.awb") / 1000

					if var_170_22 + var_170_14 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_22 + var_170_14
					end

					if var_170_17.prefab_name ~= "" and arg_167_1.actors_[var_170_17.prefab_name] ~= nil then
						local var_170_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_17.prefab_name].transform, "story_v_side_new_1106605", "1106605041", "story_v_side_new_1106605.awb")

						arg_167_1:RecordAudio("1106605041", var_170_23)
						arg_167_1:RecordAudio("1106605041", var_170_23)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605041", "story_v_side_new_1106605.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605041", "story_v_side_new_1106605.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_24 = math.max(var_170_15, arg_167_1.talkMaxDuration)

			if var_170_14 <= arg_167_1.time_ and arg_167_1.time_ < var_170_14 + var_170_24 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_14) / var_170_24

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_14 + var_170_24 and arg_167_1.time_ < var_170_14 + var_170_24 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1106605042
		arg_171_1.duration_ = 0.999999999999

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"

			SetActive(arg_171_1.choicesGo_, true)

			for iter_172_0, iter_172_1 in ipairs(arg_171_1.choices_) do
				local var_172_0 = iter_172_0 <= 2

				SetActive(iter_172_1.go, var_172_0)
			end

			arg_171_1.choices_[1].txt.text = arg_171_1:FormatText(StoryChoiceCfg[539].name)
			arg_171_1.choices_[2].txt.text = arg_171_1:FormatText(StoryChoiceCfg[540].name)
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1106605043(arg_171_1)
			end

			if arg_173_0 == 2 then
				arg_171_0:Play1106605043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_1 = 0.5

			if arg_171_1.time_ >= var_174_0 + var_174_1 and arg_171_1.time_ < var_174_0 + var_174_1 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_2 = arg_171_1.actors_["106603ui_story"]
			local var_174_3 = 0

			if var_174_3 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 and arg_171_1.var_.characterEffect106603ui_story == nil then
				arg_171_1.var_.characterEffect106603ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_3) / var_174_4

				if arg_171_1.var_.characterEffect106603ui_story then
					local var_174_6 = Mathf.Lerp(0, 0.5, var_174_5)

					arg_171_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_171_1.var_.characterEffect106603ui_story.fillRatio = var_174_6
				end
			end

			if arg_171_1.time_ >= var_174_3 + var_174_4 and arg_171_1.time_ < var_174_3 + var_174_4 + arg_174_0 and arg_171_1.var_.characterEffect106603ui_story then
				local var_174_7 = 0.5

				arg_171_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_171_1.var_.characterEffect106603ui_story.fillRatio = var_174_7
			end
		end
	end,
	Play1106605043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1106605043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1106605044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["106603ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos106603ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos106603ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = 0
			local var_178_10 = 1.05

			if var_178_9 < arg_175_1.time_ and arg_175_1.time_ <= var_178_9 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_11 = arg_175_1:GetWordFromCfg(1106605043)
				local var_178_12 = arg_175_1:FormatText(var_178_11.content)

				arg_175_1.text_.text = var_178_12

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 42
				local var_178_14 = utf8.len(var_178_12)
				local var_178_15 = var_178_13 <= 0 and var_178_10 or var_178_10 * (var_178_14 / var_178_13)

				if var_178_15 > 0 and var_178_10 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_9 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_9
					end
				end

				arg_175_1.text_.text = var_178_12
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_10, arg_175_1.talkMaxDuration)

			if var_178_9 <= arg_175_1.time_ and arg_175_1.time_ < var_178_9 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_9) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_9 + var_178_16 and arg_175_1.time_ < var_178_9 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1106605044
		arg_179_1.duration_ = 5.766

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1106605045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["106603ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos106603ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0, -0.77, -6.25)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos106603ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["106603ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and arg_179_1.var_.characterEffect106603ui_story == nil then
				arg_179_1.var_.characterEffect106603ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect106603ui_story then
					arg_179_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and arg_179_1.var_.characterEffect106603ui_story then
				arg_179_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_182_13 = 0

			if var_182_13 < arg_179_1.time_ and arg_179_1.time_ <= var_182_13 + arg_182_0 then
				arg_179_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_182_14 = 0

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 then
				arg_179_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_15 = 0
			local var_182_16 = 0.65

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_17 = arg_179_1:FormatText(StoryNameCfg[32].name)

				arg_179_1.leftNameTxt_.text = var_182_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_18 = arg_179_1:GetWordFromCfg(1106605044)
				local var_182_19 = arg_179_1:FormatText(var_182_18.content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_20 = 26
				local var_182_21 = utf8.len(var_182_19)
				local var_182_22 = var_182_20 <= 0 and var_182_16 or var_182_16 * (var_182_21 / var_182_20)

				if var_182_22 > 0 and var_182_16 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22

					if var_182_22 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605044", "story_v_side_new_1106605.awb") ~= 0 then
					local var_182_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605044", "story_v_side_new_1106605.awb") / 1000

					if var_182_23 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_23 + var_182_15
					end

					if var_182_18.prefab_name ~= "" and arg_179_1.actors_[var_182_18.prefab_name] ~= nil then
						local var_182_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_18.prefab_name].transform, "story_v_side_new_1106605", "1106605044", "story_v_side_new_1106605.awb")

						arg_179_1:RecordAudio("1106605044", var_182_24)
						arg_179_1:RecordAudio("1106605044", var_182_24)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605044", "story_v_side_new_1106605.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605044", "story_v_side_new_1106605.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_25 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_25 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_25

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_25 and arg_179_1.time_ < var_182_15 + var_182_25 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1106605045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1106605046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["106603ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and arg_183_1.var_.characterEffect106603ui_story == nil then
				arg_183_1.var_.characterEffect106603ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect106603ui_story then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_183_1.var_.characterEffect106603ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and arg_183_1.var_.characterEffect106603ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_183_1.var_.characterEffect106603ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 0.2

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_9 = arg_183_1:GetWordFromCfg(1106605045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 8
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1106605046
		arg_187_1.duration_ = 6.633

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1106605047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["106603ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos106603ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -0.77, -6.25)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos106603ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["106603ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and arg_187_1.var_.characterEffect106603ui_story == nil then
				arg_187_1.var_.characterEffect106603ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect106603ui_story then
					arg_187_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and arg_187_1.var_.characterEffect106603ui_story then
				arg_187_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action456")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_190_15 = 0

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			local var_190_16 = 3

			if arg_187_1.time_ >= var_190_15 + var_190_16 and arg_187_1.time_ < var_190_15 + var_190_16 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_17 = 0
			local var_190_18 = 0.75

			if var_190_17 < arg_187_1.time_ and arg_187_1.time_ <= var_190_17 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_19 = arg_187_1:FormatText(StoryNameCfg[32].name)

				arg_187_1.leftNameTxt_.text = var_190_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_20 = arg_187_1:GetWordFromCfg(1106605046)
				local var_190_21 = arg_187_1:FormatText(var_190_20.content)

				arg_187_1.text_.text = var_190_21

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_22 = 30
				local var_190_23 = utf8.len(var_190_21)
				local var_190_24 = var_190_22 <= 0 and var_190_18 or var_190_18 * (var_190_23 / var_190_22)

				if var_190_24 > 0 and var_190_18 < var_190_24 then
					arg_187_1.talkMaxDuration = var_190_24

					if var_190_24 + var_190_17 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_24 + var_190_17
					end
				end

				arg_187_1.text_.text = var_190_21
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605046", "story_v_side_new_1106605.awb") ~= 0 then
					local var_190_25 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605046", "story_v_side_new_1106605.awb") / 1000

					if var_190_25 + var_190_17 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_25 + var_190_17
					end

					if var_190_20.prefab_name ~= "" and arg_187_1.actors_[var_190_20.prefab_name] ~= nil then
						local var_190_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_20.prefab_name].transform, "story_v_side_new_1106605", "1106605046", "story_v_side_new_1106605.awb")

						arg_187_1:RecordAudio("1106605046", var_190_26)
						arg_187_1:RecordAudio("1106605046", var_190_26)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605046", "story_v_side_new_1106605.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605046", "story_v_side_new_1106605.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_27 = math.max(var_190_18, arg_187_1.talkMaxDuration)

			if var_190_17 <= arg_187_1.time_ and arg_187_1.time_ < var_190_17 + var_190_27 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_17) / var_190_27

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_17 + var_190_27 and arg_187_1.time_ < var_190_17 + var_190_27 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1106605047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1106605048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["106603ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and arg_191_1.var_.characterEffect106603ui_story == nil then
				arg_191_1.var_.characterEffect106603ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect106603ui_story then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_191_1.var_.characterEffect106603ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and arg_191_1.var_.characterEffect106603ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_191_1.var_.characterEffect106603ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.1

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:GetWordFromCfg(1106605047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 4
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1106605048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1106605049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["106603ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos106603ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos106603ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = 0
			local var_198_10 = 0.975

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_11 = arg_195_1:GetWordFromCfg(1106605048)
				local var_198_12 = arg_195_1:FormatText(var_198_11.content)

				arg_195_1.text_.text = var_198_12

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 39
				local var_198_14 = utf8.len(var_198_12)
				local var_198_15 = var_198_13 <= 0 and var_198_10 or var_198_10 * (var_198_14 / var_198_13)

				if var_198_15 > 0 and var_198_10 < var_198_15 then
					arg_195_1.talkMaxDuration = var_198_15

					if var_198_15 + var_198_9 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_15 + var_198_9
					end
				end

				arg_195_1.text_.text = var_198_12
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_10, arg_195_1.talkMaxDuration)

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_9) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_9 + var_198_16 and arg_195_1.time_ < var_198_9 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1106605049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1106605050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.575

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(1106605049)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 63
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1106605050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1106605051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.375

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(1106605050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 15
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
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1106605051
		arg_207_1.duration_ = 4.033

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1106605052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["106603ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos106603ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(0, -0.77, -6.25)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos106603ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["106603ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and arg_207_1.var_.characterEffect106603ui_story == nil then
				arg_207_1.var_.characterEffect106603ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect106603ui_story then
					arg_207_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and arg_207_1.var_.characterEffect106603ui_story then
				arg_207_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_210_13 = 0
			local var_210_14 = 0.475

			if var_210_13 < arg_207_1.time_ and arg_207_1.time_ <= var_210_13 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_15 = arg_207_1:FormatText(StoryNameCfg[32].name)

				arg_207_1.leftNameTxt_.text = var_210_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_16 = arg_207_1:GetWordFromCfg(1106605051)
				local var_210_17 = arg_207_1:FormatText(var_210_16.content)

				arg_207_1.text_.text = var_210_17

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_18 = 19
				local var_210_19 = utf8.len(var_210_17)
				local var_210_20 = var_210_18 <= 0 and var_210_14 or var_210_14 * (var_210_19 / var_210_18)

				if var_210_20 > 0 and var_210_14 < var_210_20 then
					arg_207_1.talkMaxDuration = var_210_20

					if var_210_20 + var_210_13 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_20 + var_210_13
					end
				end

				arg_207_1.text_.text = var_210_17
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605051", "story_v_side_new_1106605.awb") ~= 0 then
					local var_210_21 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605051", "story_v_side_new_1106605.awb") / 1000

					if var_210_21 + var_210_13 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_13
					end

					if var_210_16.prefab_name ~= "" and arg_207_1.actors_[var_210_16.prefab_name] ~= nil then
						local var_210_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_16.prefab_name].transform, "story_v_side_new_1106605", "1106605051", "story_v_side_new_1106605.awb")

						arg_207_1:RecordAudio("1106605051", var_210_22)
						arg_207_1:RecordAudio("1106605051", var_210_22)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605051", "story_v_side_new_1106605.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605051", "story_v_side_new_1106605.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_23 = math.max(var_210_14, arg_207_1.talkMaxDuration)

			if var_210_13 <= arg_207_1.time_ and arg_207_1.time_ < var_210_13 + var_210_23 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_13) / var_210_23

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_13 + var_210_23 and arg_207_1.time_ < var_210_13 + var_210_23 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1106605052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1106605053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["106603ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and arg_211_1.var_.characterEffect106603ui_story == nil then
				arg_211_1.var_.characterEffect106603ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect106603ui_story then
					local var_214_4 = Mathf.Lerp(0, 0.5, var_214_3)

					arg_211_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_211_1.var_.characterEffect106603ui_story.fillRatio = var_214_4
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and arg_211_1.var_.characterEffect106603ui_story then
				local var_214_5 = 0.5

				arg_211_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_211_1.var_.characterEffect106603ui_story.fillRatio = var_214_5
			end

			local var_214_6 = 0
			local var_214_7 = 0.65

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_8 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:GetWordFromCfg(1106605052)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 26
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_7 or var_214_7 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_7 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1106605053
		arg_215_1.duration_ = 2.766

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1106605054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["106603ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and arg_215_1.var_.characterEffect106603ui_story == nil then
				arg_215_1.var_.characterEffect106603ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect106603ui_story then
					arg_215_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and arg_215_1.var_.characterEffect106603ui_story then
				arg_215_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_2")
			end

			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_218_6 = 0
			local var_218_7 = 0.325

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[32].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_9 = arg_215_1:GetWordFromCfg(1106605053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 13
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605053", "story_v_side_new_1106605.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605053", "story_v_side_new_1106605.awb") / 1000

					if var_218_14 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_6
					end

					if var_218_9.prefab_name ~= "" and arg_215_1.actors_[var_218_9.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_9.prefab_name].transform, "story_v_side_new_1106605", "1106605053", "story_v_side_new_1106605.awb")

						arg_215_1:RecordAudio("1106605053", var_218_15)
						arg_215_1:RecordAudio("1106605053", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605053", "story_v_side_new_1106605.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605053", "story_v_side_new_1106605.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_16 and arg_215_1.time_ < var_218_6 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1106605054
		arg_219_1.duration_ = 4.8

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1106605055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["106603ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos106603ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -0.77, -6.25)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos106603ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_11 = 0
			local var_222_12 = 0.55

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_13 = arg_219_1:FormatText(StoryNameCfg[32].name)

				arg_219_1.leftNameTxt_.text = var_222_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:GetWordFromCfg(1106605054)
				local var_222_15 = arg_219_1:FormatText(var_222_14.content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_16 = 22
				local var_222_17 = utf8.len(var_222_15)
				local var_222_18 = var_222_16 <= 0 and var_222_12 or var_222_12 * (var_222_17 / var_222_16)

				if var_222_18 > 0 and var_222_12 < var_222_18 then
					arg_219_1.talkMaxDuration = var_222_18

					if var_222_18 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_11
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605054", "story_v_side_new_1106605.awb") ~= 0 then
					local var_222_19 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605054", "story_v_side_new_1106605.awb") / 1000

					if var_222_19 + var_222_11 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_11
					end

					if var_222_14.prefab_name ~= "" and arg_219_1.actors_[var_222_14.prefab_name] ~= nil then
						local var_222_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_14.prefab_name].transform, "story_v_side_new_1106605", "1106605054", "story_v_side_new_1106605.awb")

						arg_219_1:RecordAudio("1106605054", var_222_20)
						arg_219_1:RecordAudio("1106605054", var_222_20)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605054", "story_v_side_new_1106605.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605054", "story_v_side_new_1106605.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_21 = math.max(var_222_12, arg_219_1.talkMaxDuration)

			if var_222_11 <= arg_219_1.time_ and arg_219_1.time_ < var_222_11 + var_222_21 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_11) / var_222_21

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_11 + var_222_21 and arg_219_1.time_ < var_222_11 + var_222_21 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1106605055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1106605056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["106603ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and arg_223_1.var_.characterEffect106603ui_story == nil then
				arg_223_1.var_.characterEffect106603ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect106603ui_story then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_223_1.var_.characterEffect106603ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and arg_223_1.var_.characterEffect106603ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_223_1.var_.characterEffect106603ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.075

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_9 = arg_223_1:GetWordFromCfg(1106605055)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 3
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1106605056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1106605057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.8

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(1106605056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 32
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1106605057
		arg_231_1.duration_ = 4.1

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1106605058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["106603ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and arg_231_1.var_.characterEffect106603ui_story == nil then
				arg_231_1.var_.characterEffect106603ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect106603ui_story then
					arg_231_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and arg_231_1.var_.characterEffect106603ui_story then
				arg_231_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_234_4 = 0
			local var_234_5 = 0.475

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_6 = arg_231_1:FormatText(StoryNameCfg[32].name)

				arg_231_1.leftNameTxt_.text = var_234_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(1106605057)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 19
				local var_234_10 = utf8.len(var_234_8)
				local var_234_11 = var_234_9 <= 0 and var_234_5 or var_234_5 * (var_234_10 / var_234_9)

				if var_234_11 > 0 and var_234_5 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605057", "story_v_side_new_1106605.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605057", "story_v_side_new_1106605.awb") / 1000

					if var_234_12 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_4
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_side_new_1106605", "1106605057", "story_v_side_new_1106605.awb")

						arg_231_1:RecordAudio("1106605057", var_234_13)
						arg_231_1:RecordAudio("1106605057", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605057", "story_v_side_new_1106605.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605057", "story_v_side_new_1106605.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_14 and arg_231_1.time_ < var_234_4 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1106605058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1106605059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["106603ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and arg_235_1.var_.characterEffect106603ui_story == nil then
				arg_235_1.var_.characterEffect106603ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect106603ui_story then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_235_1.var_.characterEffect106603ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and arg_235_1.var_.characterEffect106603ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_235_1.var_.characterEffect106603ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.675

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_9 = arg_235_1:GetWordFromCfg(1106605058)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 27
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1106605059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1106605060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.6

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[7].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(1106605059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 24
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
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_8 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_8 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_8

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_8 and arg_239_1.time_ < var_242_0 + var_242_8 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1106605060
		arg_243_1.duration_ = 8.333

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1106605061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["106603ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos106603ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, -0.77, -6.25)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos106603ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["106603ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and arg_243_1.var_.characterEffect106603ui_story == nil then
				arg_243_1.var_.characterEffect106603ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect106603ui_story then
					arg_243_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and arg_243_1.var_.characterEffect106603ui_story then
				arg_243_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_246_13 = 0

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action454")
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_246_15 = 0
			local var_246_16 = 0.875

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[32].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(1106605060)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 35
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605060", "story_v_side_new_1106605.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605060", "story_v_side_new_1106605.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_side_new_1106605", "1106605060", "story_v_side_new_1106605.awb")

						arg_243_1:RecordAudio("1106605060", var_246_24)
						arg_243_1:RecordAudio("1106605060", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605060", "story_v_side_new_1106605.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605060", "story_v_side_new_1106605.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1106605061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1106605062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["106603ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos106603ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, 100, 0)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos106603ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, 100, 0)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = 0
			local var_250_10 = 0.975

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_11 = arg_247_1:GetWordFromCfg(1106605061)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 39
				local var_250_14 = utf8.len(var_250_12)
				local var_250_15 = var_250_13 <= 0 and var_250_10 or var_250_10 * (var_250_14 / var_250_13)

				if var_250_15 > 0 and var_250_10 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_9 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_9
					end
				end

				arg_247_1.text_.text = var_250_12
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_10, arg_247_1.talkMaxDuration)

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_9) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_9 + var_250_16 and arg_247_1.time_ < var_250_9 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1106605062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1106605063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.775

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_3 = arg_251_1:GetWordFromCfg(1106605062)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 31
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1106605063
		arg_255_1.duration_ = 9.833

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1106605064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["106603ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos106603ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, -0.77, -6.25)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos106603ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["106603ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and arg_255_1.var_.characterEffect106603ui_story == nil then
				arg_255_1.var_.characterEffect106603ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect106603ui_story then
					arg_255_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and arg_255_1.var_.characterEffect106603ui_story then
				arg_255_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_258_13 = 0

			if var_258_13 < arg_255_1.time_ and arg_255_1.time_ <= var_258_13 + arg_258_0 then
				arg_255_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action448")
			end

			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_258_15 = 0
			local var_258_16 = 1.2

			if var_258_15 < arg_255_1.time_ and arg_255_1.time_ <= var_258_15 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_17 = arg_255_1:FormatText(StoryNameCfg[32].name)

				arg_255_1.leftNameTxt_.text = var_258_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_18 = arg_255_1:GetWordFromCfg(1106605063)
				local var_258_19 = arg_255_1:FormatText(var_258_18.content)

				arg_255_1.text_.text = var_258_19

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_20 = 48
				local var_258_21 = utf8.len(var_258_19)
				local var_258_22 = var_258_20 <= 0 and var_258_16 or var_258_16 * (var_258_21 / var_258_20)

				if var_258_22 > 0 and var_258_16 < var_258_22 then
					arg_255_1.talkMaxDuration = var_258_22

					if var_258_22 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_22 + var_258_15
					end
				end

				arg_255_1.text_.text = var_258_19
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605063", "story_v_side_new_1106605.awb") ~= 0 then
					local var_258_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605063", "story_v_side_new_1106605.awb") / 1000

					if var_258_23 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_23 + var_258_15
					end

					if var_258_18.prefab_name ~= "" and arg_255_1.actors_[var_258_18.prefab_name] ~= nil then
						local var_258_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_18.prefab_name].transform, "story_v_side_new_1106605", "1106605063", "story_v_side_new_1106605.awb")

						arg_255_1:RecordAudio("1106605063", var_258_24)
						arg_255_1:RecordAudio("1106605063", var_258_24)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605063", "story_v_side_new_1106605.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605063", "story_v_side_new_1106605.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_25 = math.max(var_258_16, arg_255_1.talkMaxDuration)

			if var_258_15 <= arg_255_1.time_ and arg_255_1.time_ < var_258_15 + var_258_25 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_15) / var_258_25

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_15 + var_258_25 and arg_255_1.time_ < var_258_15 + var_258_25 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1106605064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1106605065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["106603ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and arg_259_1.var_.characterEffect106603ui_story == nil then
				arg_259_1.var_.characterEffect106603ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect106603ui_story then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_259_1.var_.characterEffect106603ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and arg_259_1.var_.characterEffect106603ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_259_1.var_.characterEffect106603ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.75

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:GetWordFromCfg(1106605064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 30
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1106605065
		arg_263_1.duration_ = 2.133

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1106605066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["106603ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos106603ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -0.77, -6.25)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos106603ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["106603ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and arg_263_1.var_.characterEffect106603ui_story == nil then
				arg_263_1.var_.characterEffect106603ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect106603ui_story then
					arg_263_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and arg_263_1.var_.characterEffect106603ui_story then
				arg_263_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action483")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_266_15 = 0
			local var_266_16 = 0.225

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[32].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(1106605065)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 9
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605065", "story_v_side_new_1106605.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605065", "story_v_side_new_1106605.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_side_new_1106605", "1106605065", "story_v_side_new_1106605.awb")

						arg_263_1:RecordAudio("1106605065", var_266_24)
						arg_263_1:RecordAudio("1106605065", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605065", "story_v_side_new_1106605.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605065", "story_v_side_new_1106605.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1106605066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1106605067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["106603ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos106603ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0, 100, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos106603ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, 100, 0)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = 0
			local var_270_10 = 0.975

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_11 = arg_267_1:GetWordFromCfg(1106605066)
				local var_270_12 = arg_267_1:FormatText(var_270_11.content)

				arg_267_1.text_.text = var_270_12

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_13 = 39
				local var_270_14 = utf8.len(var_270_12)
				local var_270_15 = var_270_13 <= 0 and var_270_10 or var_270_10 * (var_270_14 / var_270_13)

				if var_270_15 > 0 and var_270_10 < var_270_15 then
					arg_267_1.talkMaxDuration = var_270_15

					if var_270_15 + var_270_9 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_15 + var_270_9
					end
				end

				arg_267_1.text_.text = var_270_12
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_16 = math.max(var_270_10, arg_267_1.talkMaxDuration)

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_16 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_9) / var_270_16

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_9 + var_270_16 and arg_267_1.time_ < var_270_9 + var_270_16 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1106605067
		arg_271_1.duration_ = 1.999999999999

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1106605068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["106603ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos106603ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(0, -0.77, -6.25)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos106603ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["106603ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and arg_271_1.var_.characterEffect106603ui_story == nil then
				arg_271_1.var_.characterEffect106603ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect106603ui_story then
					arg_271_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and arg_271_1.var_.characterEffect106603ui_story then
				arg_271_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_274_13 = 0

			if var_274_13 < arg_271_1.time_ and arg_271_1.time_ <= var_274_13 + arg_274_0 then
				arg_271_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_2")
			end

			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				arg_271_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_274_15 = 0
			local var_274_16 = 0.1

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[32].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(1106605067)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 4
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605067", "story_v_side_new_1106605.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605067", "story_v_side_new_1106605.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_side_new_1106605", "1106605067", "story_v_side_new_1106605.awb")

						arg_271_1:RecordAudio("1106605067", var_274_24)
						arg_271_1:RecordAudio("1106605067", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605067", "story_v_side_new_1106605.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605067", "story_v_side_new_1106605.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1106605068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1106605069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["106603ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and arg_275_1.var_.characterEffect106603ui_story == nil then
				arg_275_1.var_.characterEffect106603ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect106603ui_story then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_275_1.var_.characterEffect106603ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and arg_275_1.var_.characterEffect106603ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_275_1.var_.characterEffect106603ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.65

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_9 = arg_275_1:GetWordFromCfg(1106605068)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 26
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1106605069
		arg_279_1.duration_ = 4.5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1106605070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["106603ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and arg_279_1.var_.characterEffect106603ui_story == nil then
				arg_279_1.var_.characterEffect106603ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect106603ui_story then
					arg_279_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and arg_279_1.var_.characterEffect106603ui_story then
				arg_279_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_282_4 = 0

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_282_5 = 0
			local var_282_6 = 0.45

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_7 = arg_279_1:FormatText(StoryNameCfg[32].name)

				arg_279_1.leftNameTxt_.text = var_282_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_8 = arg_279_1:GetWordFromCfg(1106605069)
				local var_282_9 = arg_279_1:FormatText(var_282_8.content)

				arg_279_1.text_.text = var_282_9

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 18
				local var_282_11 = utf8.len(var_282_9)
				local var_282_12 = var_282_10 <= 0 and var_282_6 or var_282_6 * (var_282_11 / var_282_10)

				if var_282_12 > 0 and var_282_6 < var_282_12 then
					arg_279_1.talkMaxDuration = var_282_12

					if var_282_12 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_12 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_9
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605069", "story_v_side_new_1106605.awb") ~= 0 then
					local var_282_13 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605069", "story_v_side_new_1106605.awb") / 1000

					if var_282_13 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_5
					end

					if var_282_8.prefab_name ~= "" and arg_279_1.actors_[var_282_8.prefab_name] ~= nil then
						local var_282_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_8.prefab_name].transform, "story_v_side_new_1106605", "1106605069", "story_v_side_new_1106605.awb")

						arg_279_1:RecordAudio("1106605069", var_282_14)
						arg_279_1:RecordAudio("1106605069", var_282_14)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605069", "story_v_side_new_1106605.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605069", "story_v_side_new_1106605.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_15 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_15 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_15

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_15 and arg_279_1.time_ < var_282_5 + var_282_15 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1106605070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1106605071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["106603ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos106603ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, 100, 0)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos106603ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, 100, 0)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = 0
			local var_286_10 = 0.7

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_11 = arg_283_1:GetWordFromCfg(1106605070)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 28
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_10 or var_286_10 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_10 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_9 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_9
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_10, arg_283_1.talkMaxDuration)

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_9) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_9 + var_286_16 and arg_283_1.time_ < var_286_9 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1106605071
		arg_287_1.duration_ = 0.999999999999

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"

			SetActive(arg_287_1.choicesGo_, true)

			for iter_288_0, iter_288_1 in ipairs(arg_287_1.choices_) do
				local var_288_0 = iter_288_0 <= 2

				SetActive(iter_288_1.go, var_288_0)
			end

			arg_287_1.choices_[1].txt.text = arg_287_1:FormatText(StoryChoiceCfg[541].name)
			arg_287_1.choices_[2].txt.text = arg_287_1:FormatText(StoryChoiceCfg[542].name)
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				PlayerAction.UseStoryTrigger(1066013, 210660105, 1106605071, 1)
				arg_287_0:Play1106605072(arg_287_1)
			end

			if arg_289_0 == 2 then
				arg_287_0:Play1106605074(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			local var_290_1 = 0.5

			if arg_287_1.time_ >= var_290_0 + var_290_1 and arg_287_1.time_ < var_290_0 + var_290_1 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1106605072
		arg_291_1.duration_ = 1.999999999999

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1106605073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["106603ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos106603ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0, -0.77, -6.25)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos106603ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["106603ui_story"]
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 and arg_291_1.var_.characterEffect106603ui_story == nil then
				arg_291_1.var_.characterEffect106603ui_story = var_294_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_11 = 0.200000002980232

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11

				if arg_291_1.var_.characterEffect106603ui_story then
					arg_291_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 and arg_291_1.var_.characterEffect106603ui_story then
				arg_291_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_294_13 = 0

			if var_294_13 < arg_291_1.time_ and arg_291_1.time_ <= var_294_13 + arg_294_0 then
				arg_291_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_294_14 = 0

			if var_294_14 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 then
				arg_291_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_294_15 = 0
			local var_294_16 = 0.15

			if var_294_15 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_17 = arg_291_1:FormatText(StoryNameCfg[32].name)

				arg_291_1.leftNameTxt_.text = var_294_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_18 = arg_291_1:GetWordFromCfg(1106605072)
				local var_294_19 = arg_291_1:FormatText(var_294_18.content)

				arg_291_1.text_.text = var_294_19

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_20 = 6
				local var_294_21 = utf8.len(var_294_19)
				local var_294_22 = var_294_20 <= 0 and var_294_16 or var_294_16 * (var_294_21 / var_294_20)

				if var_294_22 > 0 and var_294_16 < var_294_22 then
					arg_291_1.talkMaxDuration = var_294_22

					if var_294_22 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_22 + var_294_15
					end
				end

				arg_291_1.text_.text = var_294_19
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605072", "story_v_side_new_1106605.awb") ~= 0 then
					local var_294_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605072", "story_v_side_new_1106605.awb") / 1000

					if var_294_23 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_15
					end

					if var_294_18.prefab_name ~= "" and arg_291_1.actors_[var_294_18.prefab_name] ~= nil then
						local var_294_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_18.prefab_name].transform, "story_v_side_new_1106605", "1106605072", "story_v_side_new_1106605.awb")

						arg_291_1:RecordAudio("1106605072", var_294_24)
						arg_291_1:RecordAudio("1106605072", var_294_24)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605072", "story_v_side_new_1106605.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605072", "story_v_side_new_1106605.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_25 = math.max(var_294_16, arg_291_1.talkMaxDuration)

			if var_294_15 <= arg_291_1.time_ and arg_291_1.time_ < var_294_15 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_15) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_15 + var_294_25 and arg_291_1.time_ < var_294_15 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1106605073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1106605076(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["106603ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and arg_295_1.var_.characterEffect106603ui_story == nil then
				arg_295_1.var_.characterEffect106603ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect106603ui_story then
					local var_298_4 = Mathf.Lerp(0, 0.5, var_298_3)

					arg_295_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_295_1.var_.characterEffect106603ui_story.fillRatio = var_298_4
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and arg_295_1.var_.characterEffect106603ui_story then
				local var_298_5 = 0.5

				arg_295_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_295_1.var_.characterEffect106603ui_story.fillRatio = var_298_5
			end

			local var_298_6 = 0
			local var_298_7 = 1.05

			if var_298_6 < arg_295_1.time_ and arg_295_1.time_ <= var_298_6 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_8 = arg_295_1:GetWordFromCfg(1106605073)
				local var_298_9 = arg_295_1:FormatText(var_298_8.content)

				arg_295_1.text_.text = var_298_9

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 42
				local var_298_11 = utf8.len(var_298_9)
				local var_298_12 = var_298_10 <= 0 and var_298_7 or var_298_7 * (var_298_11 / var_298_10)

				if var_298_12 > 0 and var_298_7 < var_298_12 then
					arg_295_1.talkMaxDuration = var_298_12

					if var_298_12 + var_298_6 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_6
					end
				end

				arg_295_1.text_.text = var_298_9
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_7, arg_295_1.talkMaxDuration)

			if var_298_6 <= arg_295_1.time_ and arg_295_1.time_ < var_298_6 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_6) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_6 + var_298_13 and arg_295_1.time_ < var_298_6 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605076 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1106605076
		arg_299_1.duration_ = 4.866

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1106605077(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["106603ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and arg_299_1.var_.characterEffect106603ui_story == nil then
				arg_299_1.var_.characterEffect106603ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect106603ui_story then
					arg_299_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and arg_299_1.var_.characterEffect106603ui_story then
				arg_299_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_302_4 = 0

			if var_302_4 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action423")
			end

			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_302_6 = 0
			local var_302_7 = 0.6

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_8 = arg_299_1:FormatText(StoryNameCfg[32].name)

				arg_299_1.leftNameTxt_.text = var_302_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_9 = arg_299_1:GetWordFromCfg(1106605076)
				local var_302_10 = arg_299_1:FormatText(var_302_9.content)

				arg_299_1.text_.text = var_302_10

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 24
				local var_302_12 = utf8.len(var_302_10)
				local var_302_13 = var_302_11 <= 0 and var_302_7 or var_302_7 * (var_302_12 / var_302_11)

				if var_302_13 > 0 and var_302_7 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_10
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605076", "story_v_side_new_1106605.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605076", "story_v_side_new_1106605.awb") / 1000

					if var_302_14 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_6
					end

					if var_302_9.prefab_name ~= "" and arg_299_1.actors_[var_302_9.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_9.prefab_name].transform, "story_v_side_new_1106605", "1106605076", "story_v_side_new_1106605.awb")

						arg_299_1:RecordAudio("1106605076", var_302_15)
						arg_299_1:RecordAudio("1106605076", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605076", "story_v_side_new_1106605.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605076", "story_v_side_new_1106605.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_16 and arg_299_1.time_ < var_302_6 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605077 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1106605077
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1106605078(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["106603ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and arg_303_1.var_.characterEffect106603ui_story == nil then
				arg_303_1.var_.characterEffect106603ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect106603ui_story then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_303_1.var_.characterEffect106603ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and arg_303_1.var_.characterEffect106603ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_303_1.var_.characterEffect106603ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.525

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_9 = arg_303_1:GetWordFromCfg(1106605077)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 21
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_7 or var_306_7 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_7 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605078 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1106605078
		arg_307_1.duration_ = 2.3

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1106605079(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["106603ui_story"].transform
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.var_.moveOldPos106603ui_story = var_310_0.localPosition
			end

			local var_310_2 = 0.001

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2
				local var_310_4 = Vector3.New(0, -0.77, -6.25)

				var_310_0.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos106603ui_story, var_310_4, var_310_3)

				local var_310_5 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_5.x, var_310_5.y, var_310_5.z)

				local var_310_6 = var_310_0.localEulerAngles

				var_310_6.z = 0
				var_310_6.x = 0
				var_310_0.localEulerAngles = var_310_6
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 then
				var_310_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_310_7 = manager.ui.mainCamera.transform.position - var_310_0.position

				var_310_0.forward = Vector3.New(var_310_7.x, var_310_7.y, var_310_7.z)

				local var_310_8 = var_310_0.localEulerAngles

				var_310_8.z = 0
				var_310_8.x = 0
				var_310_0.localEulerAngles = var_310_8
			end

			local var_310_9 = arg_307_1.actors_["106603ui_story"]
			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 and arg_307_1.var_.characterEffect106603ui_story == nil then
				arg_307_1.var_.characterEffect106603ui_story = var_310_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_11 = 0.200000002980232

			if var_310_10 <= arg_307_1.time_ and arg_307_1.time_ < var_310_10 + var_310_11 then
				local var_310_12 = (arg_307_1.time_ - var_310_10) / var_310_11

				if arg_307_1.var_.characterEffect106603ui_story then
					arg_307_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_10 + var_310_11 and arg_307_1.time_ < var_310_10 + var_310_11 + arg_310_0 and arg_307_1.var_.characterEffect106603ui_story then
				arg_307_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_310_13 = 0

			if var_310_13 < arg_307_1.time_ and arg_307_1.time_ <= var_310_13 + arg_310_0 then
				arg_307_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_2")
			end

			local var_310_14 = 0

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				arg_307_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_310_15 = 0
			local var_310_16 = 0.25

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_17 = arg_307_1:FormatText(StoryNameCfg[32].name)

				arg_307_1.leftNameTxt_.text = var_310_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_18 = arg_307_1:GetWordFromCfg(1106605078)
				local var_310_19 = arg_307_1:FormatText(var_310_18.content)

				arg_307_1.text_.text = var_310_19

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_20 = 10
				local var_310_21 = utf8.len(var_310_19)
				local var_310_22 = var_310_20 <= 0 and var_310_16 or var_310_16 * (var_310_21 / var_310_20)

				if var_310_22 > 0 and var_310_16 < var_310_22 then
					arg_307_1.talkMaxDuration = var_310_22

					if var_310_22 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_22 + var_310_15
					end
				end

				arg_307_1.text_.text = var_310_19
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605078", "story_v_side_new_1106605.awb") ~= 0 then
					local var_310_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605078", "story_v_side_new_1106605.awb") / 1000

					if var_310_23 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_15
					end

					if var_310_18.prefab_name ~= "" and arg_307_1.actors_[var_310_18.prefab_name] ~= nil then
						local var_310_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_18.prefab_name].transform, "story_v_side_new_1106605", "1106605078", "story_v_side_new_1106605.awb")

						arg_307_1:RecordAudio("1106605078", var_310_24)
						arg_307_1:RecordAudio("1106605078", var_310_24)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605078", "story_v_side_new_1106605.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605078", "story_v_side_new_1106605.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_25 = math.max(var_310_16, arg_307_1.talkMaxDuration)

			if var_310_15 <= arg_307_1.time_ and arg_307_1.time_ < var_310_15 + var_310_25 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_15) / var_310_25

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_15 + var_310_25 and arg_307_1.time_ < var_310_15 + var_310_25 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605079 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1106605079
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1106605080(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["106603ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos106603ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, 100, 0)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos106603ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, 100, 0)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = 0
			local var_314_10 = 1.75

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_11 = arg_311_1:GetWordFromCfg(1106605079)
				local var_314_12 = arg_311_1:FormatText(var_314_11.content)

				arg_311_1.text_.text = var_314_12

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 70
				local var_314_14 = utf8.len(var_314_12)
				local var_314_15 = var_314_13 <= 0 and var_314_10 or var_314_10 * (var_314_14 / var_314_13)

				if var_314_15 > 0 and var_314_10 < var_314_15 then
					arg_311_1.talkMaxDuration = var_314_15

					if var_314_15 + var_314_9 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_15 + var_314_9
					end
				end

				arg_311_1.text_.text = var_314_12
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_10, arg_311_1.talkMaxDuration)

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_9) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_9 + var_314_16 and arg_311_1.time_ < var_314_9 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605080 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1106605080
		arg_315_1.duration_ = 0.999999999999

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"

			SetActive(arg_315_1.choicesGo_, true)

			for iter_316_0, iter_316_1 in ipairs(arg_315_1.choices_) do
				local var_316_0 = iter_316_0 <= 2

				SetActive(iter_316_1.go, var_316_0)
			end

			arg_315_1.choices_[1].txt.text = arg_315_1:FormatText(StoryChoiceCfg[543].name)
			arg_315_1.choices_[2].txt.text = arg_315_1:FormatText(StoryChoiceCfg[544].name)
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1106605081(arg_315_1)
			end

			if arg_317_0 == 2 then
				arg_315_0:Play1106605082(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			local var_318_1 = 0.5

			if arg_315_1.time_ >= var_318_0 + var_318_1 and arg_315_1.time_ < var_318_0 + var_318_1 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605081 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1106605081
		arg_319_1.duration_ = 3.4

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1106605083(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["106603ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos106603ui_story = var_322_0.localPosition
			end

			local var_322_2 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2
				local var_322_4 = Vector3.New(0, -0.77, -6.25)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos106603ui_story, var_322_4, var_322_3)

				local var_322_5 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_5.x, var_322_5.y, var_322_5.z)

				local var_322_6 = var_322_0.localEulerAngles

				var_322_6.z = 0
				var_322_6.x = 0
				var_322_0.localEulerAngles = var_322_6
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_322_7 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_7.x, var_322_7.y, var_322_7.z)

				local var_322_8 = var_322_0.localEulerAngles

				var_322_8.z = 0
				var_322_8.x = 0
				var_322_0.localEulerAngles = var_322_8
			end

			local var_322_9 = arg_319_1.actors_["106603ui_story"]
			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 and arg_319_1.var_.characterEffect106603ui_story == nil then
				arg_319_1.var_.characterEffect106603ui_story = var_322_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_11 = 0.200000002980232

			if var_322_10 <= arg_319_1.time_ and arg_319_1.time_ < var_322_10 + var_322_11 then
				local var_322_12 = (arg_319_1.time_ - var_322_10) / var_322_11

				if arg_319_1.var_.characterEffect106603ui_story then
					arg_319_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_10 + var_322_11 and arg_319_1.time_ < var_322_10 + var_322_11 + arg_322_0 and arg_319_1.var_.characterEffect106603ui_story then
				arg_319_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_322_13 = 0

			if var_322_13 < arg_319_1.time_ and arg_319_1.time_ <= var_322_13 + arg_322_0 then
				arg_319_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_1")
			end

			local var_322_14 = 0

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				arg_319_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_322_15 = 0

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			local var_322_16 = 2.36666666666667

			if arg_319_1.time_ >= var_322_15 + var_322_16 and arg_319_1.time_ < var_322_15 + var_322_16 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end

			local var_322_17 = 0
			local var_322_18 = 0.4

			if var_322_17 < arg_319_1.time_ and arg_319_1.time_ <= var_322_17 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_19 = arg_319_1:FormatText(StoryNameCfg[32].name)

				arg_319_1.leftNameTxt_.text = var_322_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_20 = arg_319_1:GetWordFromCfg(1106605081)
				local var_322_21 = arg_319_1:FormatText(var_322_20.content)

				arg_319_1.text_.text = var_322_21

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_22 = 16
				local var_322_23 = utf8.len(var_322_21)
				local var_322_24 = var_322_22 <= 0 and var_322_18 or var_322_18 * (var_322_23 / var_322_22)

				if var_322_24 > 0 and var_322_18 < var_322_24 then
					arg_319_1.talkMaxDuration = var_322_24

					if var_322_24 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_17
					end
				end

				arg_319_1.text_.text = var_322_21
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605081", "story_v_side_new_1106605.awb") ~= 0 then
					local var_322_25 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605081", "story_v_side_new_1106605.awb") / 1000

					if var_322_25 + var_322_17 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_25 + var_322_17
					end

					if var_322_20.prefab_name ~= "" and arg_319_1.actors_[var_322_20.prefab_name] ~= nil then
						local var_322_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_20.prefab_name].transform, "story_v_side_new_1106605", "1106605081", "story_v_side_new_1106605.awb")

						arg_319_1:RecordAudio("1106605081", var_322_26)
						arg_319_1:RecordAudio("1106605081", var_322_26)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605081", "story_v_side_new_1106605.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605081", "story_v_side_new_1106605.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_27 = math.max(var_322_18, arg_319_1.talkMaxDuration)

			if var_322_17 <= arg_319_1.time_ and arg_319_1.time_ < var_322_17 + var_322_27 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_17) / var_322_27

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_17 + var_322_27 and arg_319_1.time_ < var_322_17 + var_322_27 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605083 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1106605083
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1106605084(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["106603ui_story"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos106603ui_story = var_326_0.localPosition
			end

			local var_326_2 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2
				local var_326_4 = Vector3.New(0, 100, 0)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos106603ui_story, var_326_4, var_326_3)

				local var_326_5 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_5.x, var_326_5.y, var_326_5.z)

				local var_326_6 = var_326_0.localEulerAngles

				var_326_6.z = 0
				var_326_6.x = 0
				var_326_0.localEulerAngles = var_326_6
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(0, 100, 0)

				local var_326_7 = manager.ui.mainCamera.transform.position - var_326_0.position

				var_326_0.forward = Vector3.New(var_326_7.x, var_326_7.y, var_326_7.z)

				local var_326_8 = var_326_0.localEulerAngles

				var_326_8.z = 0
				var_326_8.x = 0
				var_326_0.localEulerAngles = var_326_8
			end

			local var_326_9 = 0
			local var_326_10 = 1.4

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_11 = arg_323_1:GetWordFromCfg(1106605083)
				local var_326_12 = arg_323_1:FormatText(var_326_11.content)

				arg_323_1.text_.text = var_326_12

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 56
				local var_326_14 = utf8.len(var_326_12)
				local var_326_15 = var_326_13 <= 0 and var_326_10 or var_326_10 * (var_326_14 / var_326_13)

				if var_326_15 > 0 and var_326_10 < var_326_15 then
					arg_323_1.talkMaxDuration = var_326_15

					if var_326_15 + var_326_9 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_15 + var_326_9
					end
				end

				arg_323_1.text_.text = var_326_12
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_10, arg_323_1.talkMaxDuration)

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_9) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_9 + var_326_16 and arg_323_1.time_ < var_326_9 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605084 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1106605084
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1106605085(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.875

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:GetWordFromCfg(1106605084)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 35
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_8 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_8 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_8

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_8 and arg_327_1.time_ < var_330_0 + var_330_8 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605085 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1106605085
		arg_331_1.duration_ = 1.999999999999

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1106605086(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["106603ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos106603ui_story = var_334_0.localPosition
			end

			local var_334_2 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2
				local var_334_4 = Vector3.New(0, -0.77, -6.25)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos106603ui_story, var_334_4, var_334_3)

				local var_334_5 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_5.x, var_334_5.y, var_334_5.z)

				local var_334_6 = var_334_0.localEulerAngles

				var_334_6.z = 0
				var_334_6.x = 0
				var_334_0.localEulerAngles = var_334_6
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_334_7 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_7.x, var_334_7.y, var_334_7.z)

				local var_334_8 = var_334_0.localEulerAngles

				var_334_8.z = 0
				var_334_8.x = 0
				var_334_0.localEulerAngles = var_334_8
			end

			local var_334_9 = arg_331_1.actors_["106603ui_story"]
			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 and arg_331_1.var_.characterEffect106603ui_story == nil then
				arg_331_1.var_.characterEffect106603ui_story = var_334_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_11 = 0.200000002980232

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_11 then
				local var_334_12 = (arg_331_1.time_ - var_334_10) / var_334_11

				if arg_331_1.var_.characterEffect106603ui_story then
					arg_331_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_10 + var_334_11 and arg_331_1.time_ < var_334_10 + var_334_11 + arg_334_0 and arg_331_1.var_.characterEffect106603ui_story then
				arg_331_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_334_13 = 0

			if var_334_13 < arg_331_1.time_ and arg_331_1.time_ <= var_334_13 + arg_334_0 then
				arg_331_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_2")
			end

			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_334_15 = 0
			local var_334_16 = 0.2

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[32].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(1106605085)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 8
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605085", "story_v_side_new_1106605.awb") ~= 0 then
					local var_334_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605085", "story_v_side_new_1106605.awb") / 1000

					if var_334_23 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_15
					end

					if var_334_18.prefab_name ~= "" and arg_331_1.actors_[var_334_18.prefab_name] ~= nil then
						local var_334_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_18.prefab_name].transform, "story_v_side_new_1106605", "1106605085", "story_v_side_new_1106605.awb")

						arg_331_1:RecordAudio("1106605085", var_334_24)
						arg_331_1:RecordAudio("1106605085", var_334_24)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605085", "story_v_side_new_1106605.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605085", "story_v_side_new_1106605.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_25 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_25 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_25

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_25 and arg_331_1.time_ < var_334_15 + var_334_25 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605086 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1106605086
		arg_335_1.duration_ = 9

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1106605087(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 2

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				local var_338_1 = manager.ui.mainCamera.transform.localPosition
				local var_338_2 = Vector3.New(0, 0, 10) + Vector3.New(var_338_1.x, var_338_1.y, 0)
				local var_338_3 = arg_335_1.bgs_.ST15

				var_338_3.transform.localPosition = var_338_2
				var_338_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_338_4 = var_338_3:GetComponent("SpriteRenderer")

				if var_338_4 and var_338_4.sprite then
					local var_338_5 = (var_338_3.transform.localPosition - var_338_1).z
					local var_338_6 = manager.ui.mainCameraCom_
					local var_338_7 = 2 * var_338_5 * Mathf.Tan(var_338_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_338_8 = var_338_7 * var_338_6.aspect
					local var_338_9 = var_338_4.sprite.bounds.size.x
					local var_338_10 = var_338_4.sprite.bounds.size.y
					local var_338_11 = var_338_8 / var_338_9
					local var_338_12 = var_338_7 / var_338_10
					local var_338_13 = var_338_12 < var_338_11 and var_338_11 or var_338_12

					var_338_3.transform.localScale = Vector3.New(var_338_13, var_338_13, 0)
				end

				for iter_338_0, iter_338_1 in pairs(arg_335_1.bgs_) do
					if iter_338_0 ~= "ST15" then
						iter_338_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_338_14 = arg_335_1.actors_["106603ui_story"].transform
			local var_338_15 = 2

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.var_.moveOldPos106603ui_story = var_338_14.localPosition
			end

			local var_338_16 = 0.001

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_16 then
				local var_338_17 = (arg_335_1.time_ - var_338_15) / var_338_16
				local var_338_18 = Vector3.New(0, 100, 0)

				var_338_14.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos106603ui_story, var_338_18, var_338_17)

				local var_338_19 = manager.ui.mainCamera.transform.position - var_338_14.position

				var_338_14.forward = Vector3.New(var_338_19.x, var_338_19.y, var_338_19.z)

				local var_338_20 = var_338_14.localEulerAngles

				var_338_20.z = 0
				var_338_20.x = 0
				var_338_14.localEulerAngles = var_338_20
			end

			if arg_335_1.time_ >= var_338_15 + var_338_16 and arg_335_1.time_ < var_338_15 + var_338_16 + arg_338_0 then
				var_338_14.localPosition = Vector3.New(0, 100, 0)

				local var_338_21 = manager.ui.mainCamera.transform.position - var_338_14.position

				var_338_14.forward = Vector3.New(var_338_21.x, var_338_21.y, var_338_21.z)

				local var_338_22 = var_338_14.localEulerAngles

				var_338_22.z = 0
				var_338_22.x = 0
				var_338_14.localEulerAngles = var_338_22
			end

			local var_338_23 = 0

			if var_338_23 < arg_335_1.time_ and arg_335_1.time_ <= var_338_23 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_24 = 2

			if var_338_23 <= arg_335_1.time_ and arg_335_1.time_ < var_338_23 + var_338_24 then
				local var_338_25 = (arg_335_1.time_ - var_338_23) / var_338_24
				local var_338_26 = Color.New(0, 0, 0)

				var_338_26.a = Mathf.Lerp(0, 1, var_338_25)
				arg_335_1.mask_.color = var_338_26
			end

			if arg_335_1.time_ >= var_338_23 + var_338_24 and arg_335_1.time_ < var_338_23 + var_338_24 + arg_338_0 then
				local var_338_27 = Color.New(0, 0, 0)

				var_338_27.a = 1
				arg_335_1.mask_.color = var_338_27
			end

			local var_338_28 = 2

			if var_338_28 < arg_335_1.time_ and arg_335_1.time_ <= var_338_28 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_29 = 2

			if var_338_28 <= arg_335_1.time_ and arg_335_1.time_ < var_338_28 + var_338_29 then
				local var_338_30 = (arg_335_1.time_ - var_338_28) / var_338_29
				local var_338_31 = Color.New(0, 0, 0)

				var_338_31.a = Mathf.Lerp(1, 0, var_338_30)
				arg_335_1.mask_.color = var_338_31
			end

			if arg_335_1.time_ >= var_338_28 + var_338_29 and arg_335_1.time_ < var_338_28 + var_338_29 + arg_338_0 then
				local var_338_32 = Color.New(0, 0, 0)
				local var_338_33 = 0

				arg_335_1.mask_.enabled = false
				var_338_32.a = var_338_33
				arg_335_1.mask_.color = var_338_32
			end

			if arg_335_1.frameCnt_ <= 1 then
				arg_335_1.dialog_:SetActive(false)
			end

			local var_338_34 = 4
			local var_338_35 = 1.375

			if var_338_34 < arg_335_1.time_ and arg_335_1.time_ <= var_338_34 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				arg_335_1.dialog_:SetActive(true)

				local var_338_36 = LeanTween.value(arg_335_1.dialog_, 0, 1, 0.3)

				var_338_36:setOnUpdate(LuaHelper.FloatAction(function(arg_339_0)
					arg_335_1.dialogCg_.alpha = arg_339_0
				end))
				var_338_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_335_1.dialog_)
					var_338_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_335_1.duration_ = arg_335_1.duration_ + 0.3

				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_37 = arg_335_1:GetWordFromCfg(1106605086)
				local var_338_38 = arg_335_1:FormatText(var_338_37.content)

				arg_335_1.text_.text = var_338_38

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_39 = 55
				local var_338_40 = utf8.len(var_338_38)
				local var_338_41 = var_338_39 <= 0 and var_338_35 or var_338_35 * (var_338_40 / var_338_39)

				if var_338_41 > 0 and var_338_35 < var_338_41 then
					arg_335_1.talkMaxDuration = var_338_41
					var_338_34 = var_338_34 + 0.3

					if var_338_41 + var_338_34 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_41 + var_338_34
					end
				end

				arg_335_1.text_.text = var_338_38
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_42 = var_338_34 + 0.3
			local var_338_43 = math.max(var_338_35, arg_335_1.talkMaxDuration)

			if var_338_42 <= arg_335_1.time_ and arg_335_1.time_ < var_338_42 + var_338_43 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_42) / var_338_43

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_42 + var_338_43 and arg_335_1.time_ < var_338_42 + var_338_43 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605087 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1106605087
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1106605088(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.3

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:GetWordFromCfg(1106605087)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 12
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_8 and arg_341_1.time_ < var_344_0 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605088 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1106605088
		arg_345_1.duration_ = 1.999999999999

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1106605089(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["106603ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos106603ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0, -0.77, -6.25)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos106603ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["106603ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and arg_345_1.var_.characterEffect106603ui_story == nil then
				arg_345_1.var_.characterEffect106603ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect106603ui_story then
					arg_345_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and arg_345_1.var_.characterEffect106603ui_story then
				arg_345_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_348_15 = 0
			local var_348_16 = 0.175

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[32].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(1106605088)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 7
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605088", "story_v_side_new_1106605.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605088", "story_v_side_new_1106605.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_side_new_1106605", "1106605088", "story_v_side_new_1106605.awb")

						arg_345_1:RecordAudio("1106605088", var_348_24)
						arg_345_1:RecordAudio("1106605088", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605088", "story_v_side_new_1106605.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605088", "story_v_side_new_1106605.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605089 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1106605089
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1106605090(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["106603ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and arg_349_1.var_.characterEffect106603ui_story == nil then
				arg_349_1.var_.characterEffect106603ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect106603ui_story then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_349_1.var_.characterEffect106603ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and arg_349_1.var_.characterEffect106603ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_349_1.var_.characterEffect106603ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.05

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:GetWordFromCfg(1106605089)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 2
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605090 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1106605090
		arg_353_1.duration_ = 2.9

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1106605091(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["106603ui_story"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos106603ui_story = var_356_0.localPosition
			end

			local var_356_2 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2
				local var_356_4 = Vector3.New(0, -0.77, -6.25)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos106603ui_story, var_356_4, var_356_3)

				local var_356_5 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_5.x, var_356_5.y, var_356_5.z)

				local var_356_6 = var_356_0.localEulerAngles

				var_356_6.z = 0
				var_356_6.x = 0
				var_356_0.localEulerAngles = var_356_6
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_356_7 = manager.ui.mainCamera.transform.position - var_356_0.position

				var_356_0.forward = Vector3.New(var_356_7.x, var_356_7.y, var_356_7.z)

				local var_356_8 = var_356_0.localEulerAngles

				var_356_8.z = 0
				var_356_8.x = 0
				var_356_0.localEulerAngles = var_356_8
			end

			local var_356_9 = arg_353_1.actors_["106603ui_story"]
			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 and arg_353_1.var_.characterEffect106603ui_story == nil then
				arg_353_1.var_.characterEffect106603ui_story = var_356_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_11 = 0.200000002980232

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_11 then
				local var_356_12 = (arg_353_1.time_ - var_356_10) / var_356_11

				if arg_353_1.var_.characterEffect106603ui_story then
					arg_353_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_10 + var_356_11 and arg_353_1.time_ < var_356_10 + var_356_11 + arg_356_0 and arg_353_1.var_.characterEffect106603ui_story then
				arg_353_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_356_13 = 0

			if var_356_13 < arg_353_1.time_ and arg_353_1.time_ <= var_356_13 + arg_356_0 then
				arg_353_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action423")
			end

			local var_356_14 = 0

			if var_356_14 < arg_353_1.time_ and arg_353_1.time_ <= var_356_14 + arg_356_0 then
				arg_353_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_356_15 = 0
			local var_356_16 = 0.3

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_17 = arg_353_1:FormatText(StoryNameCfg[32].name)

				arg_353_1.leftNameTxt_.text = var_356_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:GetWordFromCfg(1106605090)
				local var_356_19 = arg_353_1:FormatText(var_356_18.content)

				arg_353_1.text_.text = var_356_19

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 12
				local var_356_21 = utf8.len(var_356_19)
				local var_356_22 = var_356_20 <= 0 and var_356_16 or var_356_16 * (var_356_21 / var_356_20)

				if var_356_22 > 0 and var_356_16 < var_356_22 then
					arg_353_1.talkMaxDuration = var_356_22

					if var_356_22 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_22 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_19
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605090", "story_v_side_new_1106605.awb") ~= 0 then
					local var_356_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605090", "story_v_side_new_1106605.awb") / 1000

					if var_356_23 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_15
					end

					if var_356_18.prefab_name ~= "" and arg_353_1.actors_[var_356_18.prefab_name] ~= nil then
						local var_356_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_18.prefab_name].transform, "story_v_side_new_1106605", "1106605090", "story_v_side_new_1106605.awb")

						arg_353_1:RecordAudio("1106605090", var_356_24)
						arg_353_1:RecordAudio("1106605090", var_356_24)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605090", "story_v_side_new_1106605.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605090", "story_v_side_new_1106605.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_25 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_25 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_25

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_25 and arg_353_1.time_ < var_356_15 + var_356_25 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605091 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1106605091
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1106605092(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["106603ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and arg_357_1.var_.characterEffect106603ui_story == nil then
				arg_357_1.var_.characterEffect106603ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect106603ui_story then
					local var_360_4 = Mathf.Lerp(0, 0.5, var_360_3)

					arg_357_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_357_1.var_.characterEffect106603ui_story.fillRatio = var_360_4
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and arg_357_1.var_.characterEffect106603ui_story then
				local var_360_5 = 0.5

				arg_357_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_357_1.var_.characterEffect106603ui_story.fillRatio = var_360_5
			end

			local var_360_6 = 0
			local var_360_7 = 0.475

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_8 = arg_357_1:GetWordFromCfg(1106605091)
				local var_360_9 = arg_357_1:FormatText(var_360_8.content)

				arg_357_1.text_.text = var_360_9

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 19
				local var_360_11 = utf8.len(var_360_9)
				local var_360_12 = var_360_10 <= 0 and var_360_7 or var_360_7 * (var_360_11 / var_360_10)

				if var_360_12 > 0 and var_360_7 < var_360_12 then
					arg_357_1.talkMaxDuration = var_360_12

					if var_360_12 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_9
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_13 and arg_357_1.time_ < var_360_6 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605092 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1106605092
		arg_361_1.duration_ = 4.366

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1106605093(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["106603ui_story"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and arg_361_1.var_.characterEffect106603ui_story == nil then
				arg_361_1.var_.characterEffect106603ui_story = var_364_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_2 = 0.200000002980232

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.characterEffect106603ui_story then
					arg_361_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and arg_361_1.var_.characterEffect106603ui_story then
				arg_361_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_364_4 = 0
			local var_364_5 = 0.475

			if var_364_4 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_6 = arg_361_1:FormatText(StoryNameCfg[32].name)

				arg_361_1.leftNameTxt_.text = var_364_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:GetWordFromCfg(1106605092)
				local var_364_8 = arg_361_1:FormatText(var_364_7.content)

				arg_361_1.text_.text = var_364_8

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 19
				local var_364_10 = utf8.len(var_364_8)
				local var_364_11 = var_364_9 <= 0 and var_364_5 or var_364_5 * (var_364_10 / var_364_9)

				if var_364_11 > 0 and var_364_5 < var_364_11 then
					arg_361_1.talkMaxDuration = var_364_11

					if var_364_11 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_11 + var_364_4
					end
				end

				arg_361_1.text_.text = var_364_8
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605092", "story_v_side_new_1106605.awb") ~= 0 then
					local var_364_12 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605092", "story_v_side_new_1106605.awb") / 1000

					if var_364_12 + var_364_4 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_12 + var_364_4
					end

					if var_364_7.prefab_name ~= "" and arg_361_1.actors_[var_364_7.prefab_name] ~= nil then
						local var_364_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_7.prefab_name].transform, "story_v_side_new_1106605", "1106605092", "story_v_side_new_1106605.awb")

						arg_361_1:RecordAudio("1106605092", var_364_13)
						arg_361_1:RecordAudio("1106605092", var_364_13)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605092", "story_v_side_new_1106605.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605092", "story_v_side_new_1106605.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_5, arg_361_1.talkMaxDuration)

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_4) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_4 + var_364_14 and arg_361_1.time_ < var_364_4 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605093 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1106605093
		arg_365_1.duration_ = 6.466

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1106605094(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.725

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[32].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(1106605093)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 29
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605093", "story_v_side_new_1106605.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605093", "story_v_side_new_1106605.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_side_new_1106605", "1106605093", "story_v_side_new_1106605.awb")

						arg_365_1:RecordAudio("1106605093", var_368_9)
						arg_365_1:RecordAudio("1106605093", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605093", "story_v_side_new_1106605.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605093", "story_v_side_new_1106605.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605094 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1106605094
		arg_369_1.duration_ = 2.066

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1106605095(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["106603ui_story"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos106603ui_story = var_372_0.localPosition
			end

			local var_372_2 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2
				local var_372_4 = Vector3.New(0, -0.77, -6.25)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos106603ui_story, var_372_4, var_372_3)

				local var_372_5 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_5.x, var_372_5.y, var_372_5.z)

				local var_372_6 = var_372_0.localEulerAngles

				var_372_6.z = 0
				var_372_6.x = 0
				var_372_0.localEulerAngles = var_372_6
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_372_7 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_7.x, var_372_7.y, var_372_7.z)

				local var_372_8 = var_372_0.localEulerAngles

				var_372_8.z = 0
				var_372_8.x = 0
				var_372_0.localEulerAngles = var_372_8
			end

			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action439")
			end

			local var_372_10 = 0

			if var_372_10 < arg_369_1.time_ and arg_369_1.time_ <= var_372_10 + arg_372_0 then
				arg_369_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_372_11 = 0
			local var_372_12 = 0.175

			if var_372_11 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_13 = arg_369_1:FormatText(StoryNameCfg[32].name)

				arg_369_1.leftNameTxt_.text = var_372_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_14 = arg_369_1:GetWordFromCfg(1106605094)
				local var_372_15 = arg_369_1:FormatText(var_372_14.content)

				arg_369_1.text_.text = var_372_15

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_16 = 7
				local var_372_17 = utf8.len(var_372_15)
				local var_372_18 = var_372_16 <= 0 and var_372_12 or var_372_12 * (var_372_17 / var_372_16)

				if var_372_18 > 0 and var_372_12 < var_372_18 then
					arg_369_1.talkMaxDuration = var_372_18

					if var_372_18 + var_372_11 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_18 + var_372_11
					end
				end

				arg_369_1.text_.text = var_372_15
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605094", "story_v_side_new_1106605.awb") ~= 0 then
					local var_372_19 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605094", "story_v_side_new_1106605.awb") / 1000

					if var_372_19 + var_372_11 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_19 + var_372_11
					end

					if var_372_14.prefab_name ~= "" and arg_369_1.actors_[var_372_14.prefab_name] ~= nil then
						local var_372_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_14.prefab_name].transform, "story_v_side_new_1106605", "1106605094", "story_v_side_new_1106605.awb")

						arg_369_1:RecordAudio("1106605094", var_372_20)
						arg_369_1:RecordAudio("1106605094", var_372_20)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605094", "story_v_side_new_1106605.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605094", "story_v_side_new_1106605.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_21 = math.max(var_372_12, arg_369_1.talkMaxDuration)

			if var_372_11 <= arg_369_1.time_ and arg_369_1.time_ < var_372_11 + var_372_21 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_11) / var_372_21

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_11 + var_372_21 and arg_369_1.time_ < var_372_11 + var_372_21 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605095 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1106605095
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1106605096(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["106603ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos106603ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(0, 100, 0)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos106603ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(0, 100, 0)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = 0
			local var_376_10 = 0.425

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_11 = arg_373_1:GetWordFromCfg(1106605095)
				local var_376_12 = arg_373_1:FormatText(var_376_11.content)

				arg_373_1.text_.text = var_376_12

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 17
				local var_376_14 = utf8.len(var_376_12)
				local var_376_15 = var_376_13 <= 0 and var_376_10 or var_376_10 * (var_376_14 / var_376_13)

				if var_376_15 > 0 and var_376_10 < var_376_15 then
					arg_373_1.talkMaxDuration = var_376_15

					if var_376_15 + var_376_9 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_15 + var_376_9
					end
				end

				arg_373_1.text_.text = var_376_12
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_10, arg_373_1.talkMaxDuration)

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_9) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_9 + var_376_16 and arg_373_1.time_ < var_376_9 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605096 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1106605096
		arg_377_1.duration_ = 8.633

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1106605097(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["106603ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos106603ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(0, -0.77, -6.25)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos106603ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = arg_377_1.actors_["106603ui_story"]
			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 and arg_377_1.var_.characterEffect106603ui_story == nil then
				arg_377_1.var_.characterEffect106603ui_story = var_380_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_11 = 0.200000002980232

			if var_380_10 <= arg_377_1.time_ and arg_377_1.time_ < var_380_10 + var_380_11 then
				local var_380_12 = (arg_377_1.time_ - var_380_10) / var_380_11

				if arg_377_1.var_.characterEffect106603ui_story then
					arg_377_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_10 + var_380_11 and arg_377_1.time_ < var_380_10 + var_380_11 + arg_380_0 and arg_377_1.var_.characterEffect106603ui_story then
				arg_377_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_380_13 = 0

			if var_380_13 < arg_377_1.time_ and arg_377_1.time_ <= var_380_13 + arg_380_0 then
				arg_377_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action7_1")
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_380_15 = 0
			local var_380_16 = 1.025

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[32].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(1106605096)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 41
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605096", "story_v_side_new_1106605.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605096", "story_v_side_new_1106605.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_side_new_1106605", "1106605096", "story_v_side_new_1106605.awb")

						arg_377_1:RecordAudio("1106605096", var_380_24)
						arg_377_1:RecordAudio("1106605096", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605096", "story_v_side_new_1106605.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605096", "story_v_side_new_1106605.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605097 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1106605097
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1106605098(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["106603ui_story"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos106603ui_story = var_384_0.localPosition
			end

			local var_384_2 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Vector3.New(0, 100, 0)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos106603ui_story, var_384_4, var_384_3)

				local var_384_5 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_5.x, var_384_5.y, var_384_5.z)

				local var_384_6 = var_384_0.localEulerAngles

				var_384_6.z = 0
				var_384_6.x = 0
				var_384_0.localEulerAngles = var_384_6
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, 100, 0)

				local var_384_7 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_7.x, var_384_7.y, var_384_7.z)

				local var_384_8 = var_384_0.localEulerAngles

				var_384_8.z = 0
				var_384_8.x = 0
				var_384_0.localEulerAngles = var_384_8
			end

			local var_384_9 = 0
			local var_384_10 = 1.1

			if var_384_9 < arg_381_1.time_ and arg_381_1.time_ <= var_384_9 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_11 = arg_381_1:GetWordFromCfg(1106605097)
				local var_384_12 = arg_381_1:FormatText(var_384_11.content)

				arg_381_1.text_.text = var_384_12

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_13 = 44
				local var_384_14 = utf8.len(var_384_12)
				local var_384_15 = var_384_13 <= 0 and var_384_10 or var_384_10 * (var_384_14 / var_384_13)

				if var_384_15 > 0 and var_384_10 < var_384_15 then
					arg_381_1.talkMaxDuration = var_384_15

					if var_384_15 + var_384_9 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_15 + var_384_9
					end
				end

				arg_381_1.text_.text = var_384_12
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_16 = math.max(var_384_10, arg_381_1.talkMaxDuration)

			if var_384_9 <= arg_381_1.time_ and arg_381_1.time_ < var_384_9 + var_384_16 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_9) / var_384_16

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_9 + var_384_16 and arg_381_1.time_ < var_384_9 + var_384_16 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605098 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1106605098
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1106605099(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_2 = arg_385_1:GetWordFromCfg(1106605098)
				local var_388_3 = arg_385_1:FormatText(var_388_2.content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 40
				local var_388_5 = utf8.len(var_388_3)
				local var_388_6 = var_388_4 <= 0 and var_388_1 or var_388_1 * (var_388_5 / var_388_4)

				if var_388_6 > 0 and var_388_1 < var_388_6 then
					arg_385_1.talkMaxDuration = var_388_6

					if var_388_6 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_6 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_7 and arg_385_1.time_ < var_388_0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605099 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1106605099
		arg_389_1.duration_ = 2

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1106605100(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["106603ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos106603ui_story = var_392_0.localPosition
			end

			local var_392_2 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2
				local var_392_4 = Vector3.New(0, -0.77, -6.25)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos106603ui_story, var_392_4, var_392_3)

				local var_392_5 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_5.x, var_392_5.y, var_392_5.z)

				local var_392_6 = var_392_0.localEulerAngles

				var_392_6.z = 0
				var_392_6.x = 0
				var_392_0.localEulerAngles = var_392_6
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_392_7 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_7.x, var_392_7.y, var_392_7.z)

				local var_392_8 = var_392_0.localEulerAngles

				var_392_8.z = 0
				var_392_8.x = 0
				var_392_0.localEulerAngles = var_392_8
			end

			local var_392_9 = arg_389_1.actors_["106603ui_story"]
			local var_392_10 = 0

			if var_392_10 < arg_389_1.time_ and arg_389_1.time_ <= var_392_10 + arg_392_0 and arg_389_1.var_.characterEffect106603ui_story == nil then
				arg_389_1.var_.characterEffect106603ui_story = var_392_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_11 = 0.200000002980232

			if var_392_10 <= arg_389_1.time_ and arg_389_1.time_ < var_392_10 + var_392_11 then
				local var_392_12 = (arg_389_1.time_ - var_392_10) / var_392_11

				if arg_389_1.var_.characterEffect106603ui_story then
					arg_389_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_10 + var_392_11 and arg_389_1.time_ < var_392_10 + var_392_11 + arg_392_0 and arg_389_1.var_.characterEffect106603ui_story then
				arg_389_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_392_13 = 0

			if var_392_13 < arg_389_1.time_ and arg_389_1.time_ <= var_392_13 + arg_392_0 then
				arg_389_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_392_15 = 0
			local var_392_16 = 0.225

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[32].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(1106605099)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 9
				local var_392_21 = utf8.len(var_392_19)
				local var_392_22 = var_392_20 <= 0 and var_392_16 or var_392_16 * (var_392_21 / var_392_20)

				if var_392_22 > 0 and var_392_16 < var_392_22 then
					arg_389_1.talkMaxDuration = var_392_22

					if var_392_22 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_22 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_19
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605099", "story_v_side_new_1106605.awb") ~= 0 then
					local var_392_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605099", "story_v_side_new_1106605.awb") / 1000

					if var_392_23 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_15
					end

					if var_392_18.prefab_name ~= "" and arg_389_1.actors_[var_392_18.prefab_name] ~= nil then
						local var_392_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_18.prefab_name].transform, "story_v_side_new_1106605", "1106605099", "story_v_side_new_1106605.awb")

						arg_389_1:RecordAudio("1106605099", var_392_24)
						arg_389_1:RecordAudio("1106605099", var_392_24)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605099", "story_v_side_new_1106605.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605099", "story_v_side_new_1106605.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_25 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_25 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_25

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_25 and arg_389_1.time_ < var_392_15 + var_392_25 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605100 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1106605100
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1106605101(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["106603ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and arg_393_1.var_.characterEffect106603ui_story == nil then
				arg_393_1.var_.characterEffect106603ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect106603ui_story then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_393_1.var_.characterEffect106603ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and arg_393_1.var_.characterEffect106603ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_393_1.var_.characterEffect106603ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.55

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(1106605100)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 22
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605101 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1106605101
		arg_397_1.duration_ = 2.766

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1106605102(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["106603ui_story"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos106603ui_story = var_400_0.localPosition
			end

			local var_400_2 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2
				local var_400_4 = Vector3.New(0, -0.77, -6.25)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos106603ui_story, var_400_4, var_400_3)

				local var_400_5 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_5.x, var_400_5.y, var_400_5.z)

				local var_400_6 = var_400_0.localEulerAngles

				var_400_6.z = 0
				var_400_6.x = 0
				var_400_0.localEulerAngles = var_400_6
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_400_7 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_7.x, var_400_7.y, var_400_7.z)

				local var_400_8 = var_400_0.localEulerAngles

				var_400_8.z = 0
				var_400_8.x = 0
				var_400_0.localEulerAngles = var_400_8
			end

			local var_400_9 = arg_397_1.actors_["106603ui_story"]
			local var_400_10 = 0

			if var_400_10 < arg_397_1.time_ and arg_397_1.time_ <= var_400_10 + arg_400_0 and arg_397_1.var_.characterEffect106603ui_story == nil then
				arg_397_1.var_.characterEffect106603ui_story = var_400_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_11 = 0.200000002980232

			if var_400_10 <= arg_397_1.time_ and arg_397_1.time_ < var_400_10 + var_400_11 then
				local var_400_12 = (arg_397_1.time_ - var_400_10) / var_400_11

				if arg_397_1.var_.characterEffect106603ui_story then
					arg_397_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_10 + var_400_11 and arg_397_1.time_ < var_400_10 + var_400_11 + arg_400_0 and arg_397_1.var_.characterEffect106603ui_story then
				arg_397_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_400_13 = 0

			if var_400_13 < arg_397_1.time_ and arg_397_1.time_ <= var_400_13 + arg_400_0 then
				arg_397_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_400_14 = 0
			local var_400_15 = 0.225

			if var_400_14 < arg_397_1.time_ and arg_397_1.time_ <= var_400_14 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_16 = arg_397_1:FormatText(StoryNameCfg[32].name)

				arg_397_1.leftNameTxt_.text = var_400_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_17 = arg_397_1:GetWordFromCfg(1106605101)
				local var_400_18 = arg_397_1:FormatText(var_400_17.content)

				arg_397_1.text_.text = var_400_18

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_19 = 9
				local var_400_20 = utf8.len(var_400_18)
				local var_400_21 = var_400_19 <= 0 and var_400_15 or var_400_15 * (var_400_20 / var_400_19)

				if var_400_21 > 0 and var_400_15 < var_400_21 then
					arg_397_1.talkMaxDuration = var_400_21

					if var_400_21 + var_400_14 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_21 + var_400_14
					end
				end

				arg_397_1.text_.text = var_400_18
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605101", "story_v_side_new_1106605.awb") ~= 0 then
					local var_400_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605101", "story_v_side_new_1106605.awb") / 1000

					if var_400_22 + var_400_14 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_14
					end

					if var_400_17.prefab_name ~= "" and arg_397_1.actors_[var_400_17.prefab_name] ~= nil then
						local var_400_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_17.prefab_name].transform, "story_v_side_new_1106605", "1106605101", "story_v_side_new_1106605.awb")

						arg_397_1:RecordAudio("1106605101", var_400_23)
						arg_397_1:RecordAudio("1106605101", var_400_23)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605101", "story_v_side_new_1106605.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605101", "story_v_side_new_1106605.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_24 = math.max(var_400_15, arg_397_1.talkMaxDuration)

			if var_400_14 <= arg_397_1.time_ and arg_397_1.time_ < var_400_14 + var_400_24 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_14) / var_400_24

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_14 + var_400_24 and arg_397_1.time_ < var_400_14 + var_400_24 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605102 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1106605102
		arg_401_1.duration_ = 0.999999999999

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"

			SetActive(arg_401_1.choicesGo_, true)

			for iter_402_0, iter_402_1 in ipairs(arg_401_1.choices_) do
				local var_402_0 = iter_402_0 <= 2

				SetActive(iter_402_1.go, var_402_0)
			end

			arg_401_1.choices_[1].txt.text = arg_401_1:FormatText(StoryChoiceCfg[545].name)
			arg_401_1.choices_[2].txt.text = arg_401_1:FormatText(StoryChoiceCfg[546].name)
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1106605103(arg_401_1)
			end

			if arg_403_0 == 2 then
				arg_401_0:Play1106605103(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.allBtn_.enabled = false
			end

			local var_404_1 = 0.5

			if arg_401_1.time_ >= var_404_0 + var_404_1 and arg_401_1.time_ < var_404_0 + var_404_1 + arg_404_0 then
				arg_401_1.allBtn_.enabled = true
			end

			local var_404_2 = arg_401_1.actors_["106603ui_story"]
			local var_404_3 = 0

			if var_404_3 < arg_401_1.time_ and arg_401_1.time_ <= var_404_3 + arg_404_0 and arg_401_1.var_.characterEffect106603ui_story == nil then
				arg_401_1.var_.characterEffect106603ui_story = var_404_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_4 = 0.200000002980232

			if var_404_3 <= arg_401_1.time_ and arg_401_1.time_ < var_404_3 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_3) / var_404_4

				if arg_401_1.var_.characterEffect106603ui_story then
					local var_404_6 = Mathf.Lerp(0, 0.5, var_404_5)

					arg_401_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_401_1.var_.characterEffect106603ui_story.fillRatio = var_404_6
				end
			end

			if arg_401_1.time_ >= var_404_3 + var_404_4 and arg_401_1.time_ < var_404_3 + var_404_4 + arg_404_0 and arg_401_1.var_.characterEffect106603ui_story then
				local var_404_7 = 0.5

				arg_401_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_401_1.var_.characterEffect106603ui_story.fillRatio = var_404_7
			end
		end
	end,
	Play1106605103 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1106605103
		arg_405_1.duration_ = 0.999999999999

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"

			SetActive(arg_405_1.choicesGo_, true)

			for iter_406_0, iter_406_1 in ipairs(arg_405_1.choices_) do
				local var_406_0 = iter_406_0 <= 2

				SetActive(iter_406_1.go, var_406_0)
			end

			arg_405_1.choices_[1].txt.text = arg_405_1:FormatText(StoryChoiceCfg[547].name)
			arg_405_1.choices_[2].txt.text = arg_405_1:FormatText(StoryChoiceCfg[548].name)
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1106605104(arg_405_1)
			end

			if arg_407_0 == 2 then
				arg_405_0:Play1106605104(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.allBtn_.enabled = false
			end

			local var_408_1 = 0.5

			if arg_405_1.time_ >= var_408_0 + var_408_1 and arg_405_1.time_ < var_408_0 + var_408_1 + arg_408_0 then
				arg_405_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605104 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1106605104
		arg_409_1.duration_ = 4.033

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1106605105(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["106603ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos106603ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -0.77, -6.25)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos106603ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["106603ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and arg_409_1.var_.characterEffect106603ui_story == nil then
				arg_409_1.var_.characterEffect106603ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect106603ui_story then
					arg_409_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and arg_409_1.var_.characterEffect106603ui_story then
				arg_409_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_412_14 = 0
			local var_412_15 = 0.45

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_16 = arg_409_1:FormatText(StoryNameCfg[32].name)

				arg_409_1.leftNameTxt_.text = var_412_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_17 = arg_409_1:GetWordFromCfg(1106605104)
				local var_412_18 = arg_409_1:FormatText(var_412_17.content)

				arg_409_1.text_.text = var_412_18

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_19 = 18
				local var_412_20 = utf8.len(var_412_18)
				local var_412_21 = var_412_19 <= 0 and var_412_15 or var_412_15 * (var_412_20 / var_412_19)

				if var_412_21 > 0 and var_412_15 < var_412_21 then
					arg_409_1.talkMaxDuration = var_412_21

					if var_412_21 + var_412_14 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_21 + var_412_14
					end
				end

				arg_409_1.text_.text = var_412_18
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605104", "story_v_side_new_1106605.awb") ~= 0 then
					local var_412_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605104", "story_v_side_new_1106605.awb") / 1000

					if var_412_22 + var_412_14 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_14
					end

					if var_412_17.prefab_name ~= "" and arg_409_1.actors_[var_412_17.prefab_name] ~= nil then
						local var_412_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_17.prefab_name].transform, "story_v_side_new_1106605", "1106605104", "story_v_side_new_1106605.awb")

						arg_409_1:RecordAudio("1106605104", var_412_23)
						arg_409_1:RecordAudio("1106605104", var_412_23)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605104", "story_v_side_new_1106605.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605104", "story_v_side_new_1106605.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_24 = math.max(var_412_15, arg_409_1.talkMaxDuration)

			if var_412_14 <= arg_409_1.time_ and arg_409_1.time_ < var_412_14 + var_412_24 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_14) / var_412_24

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_14 + var_412_24 and arg_409_1.time_ < var_412_14 + var_412_24 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605105 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1106605105
		arg_413_1.duration_ = 0.999999999999

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"

			SetActive(arg_413_1.choicesGo_, true)

			for iter_414_0, iter_414_1 in ipairs(arg_413_1.choices_) do
				local var_414_0 = iter_414_0 <= 2

				SetActive(iter_414_1.go, var_414_0)
			end

			arg_413_1.choices_[1].txt.text = arg_413_1:FormatText(StoryChoiceCfg[549].name)
			arg_413_1.choices_[2].txt.text = arg_413_1:FormatText(StoryChoiceCfg[550].name)
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1106605106(arg_413_1)
			end

			if arg_415_0 == 2 then
				arg_413_0:Play1106605106(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			local var_416_1 = 0.5

			if arg_413_1.time_ >= var_416_0 + var_416_1 and arg_413_1.time_ < var_416_0 + var_416_1 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_2 = arg_413_1.actors_["106603ui_story"]
			local var_416_3 = 0

			if var_416_3 < arg_413_1.time_ and arg_413_1.time_ <= var_416_3 + arg_416_0 and arg_413_1.var_.characterEffect106603ui_story == nil then
				arg_413_1.var_.characterEffect106603ui_story = var_416_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_4 = 0.200000002980232

			if var_416_3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_3 + var_416_4 then
				local var_416_5 = (arg_413_1.time_ - var_416_3) / var_416_4

				if arg_413_1.var_.characterEffect106603ui_story then
					local var_416_6 = Mathf.Lerp(0, 0.5, var_416_5)

					arg_413_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_413_1.var_.characterEffect106603ui_story.fillRatio = var_416_6
				end
			end

			if arg_413_1.time_ >= var_416_3 + var_416_4 and arg_413_1.time_ < var_416_3 + var_416_4 + arg_416_0 and arg_413_1.var_.characterEffect106603ui_story then
				local var_416_7 = 0.5

				arg_413_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_413_1.var_.characterEffect106603ui_story.fillRatio = var_416_7
			end
		end
	end,
	Play1106605106 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1106605106
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1106605107(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_420_1 = 0
			local var_420_2 = 0.25

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_3 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_4 = arg_417_1:GetWordFromCfg(1106605106)
				local var_420_5 = arg_417_1:FormatText(var_420_4.content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_6 = 10
				local var_420_7 = utf8.len(var_420_5)
				local var_420_8 = var_420_6 <= 0 and var_420_2 or var_420_2 * (var_420_7 / var_420_6)

				if var_420_8 > 0 and var_420_2 < var_420_8 then
					arg_417_1.talkMaxDuration = var_420_8

					if var_420_8 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_9 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_9 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_9

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_9 and arg_417_1.time_ < var_420_1 + var_420_9 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605107 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1106605107
		arg_421_1.duration_ = 5.9

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1106605108(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["106603ui_story"].transform
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.var_.moveOldPos106603ui_story = var_424_0.localPosition
			end

			local var_424_2 = 0.001

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2
				local var_424_4 = Vector3.New(0, -0.77, -6.25)

				var_424_0.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos106603ui_story, var_424_4, var_424_3)

				local var_424_5 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_5.x, var_424_5.y, var_424_5.z)

				local var_424_6 = var_424_0.localEulerAngles

				var_424_6.z = 0
				var_424_6.x = 0
				var_424_0.localEulerAngles = var_424_6
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 then
				var_424_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_424_7 = manager.ui.mainCamera.transform.position - var_424_0.position

				var_424_0.forward = Vector3.New(var_424_7.x, var_424_7.y, var_424_7.z)

				local var_424_8 = var_424_0.localEulerAngles

				var_424_8.z = 0
				var_424_8.x = 0
				var_424_0.localEulerAngles = var_424_8
			end

			local var_424_9 = arg_421_1.actors_["106603ui_story"]
			local var_424_10 = 0

			if var_424_10 < arg_421_1.time_ and arg_421_1.time_ <= var_424_10 + arg_424_0 and arg_421_1.var_.characterEffect106603ui_story == nil then
				arg_421_1.var_.characterEffect106603ui_story = var_424_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_11 = 0.200000002980232

			if var_424_10 <= arg_421_1.time_ and arg_421_1.time_ < var_424_10 + var_424_11 then
				local var_424_12 = (arg_421_1.time_ - var_424_10) / var_424_11

				if arg_421_1.var_.characterEffect106603ui_story then
					arg_421_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= var_424_10 + var_424_11 and arg_421_1.time_ < var_424_10 + var_424_11 + arg_424_0 and arg_421_1.var_.characterEffect106603ui_story then
				arg_421_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_424_13 = 0

			if var_424_13 < arg_421_1.time_ and arg_421_1.time_ <= var_424_13 + arg_424_0 then
				arg_421_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_424_14 = 0

			if var_424_14 < arg_421_1.time_ and arg_421_1.time_ <= var_424_14 + arg_424_0 then
				arg_421_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action424")
			end

			local var_424_15 = 0
			local var_424_16 = 0.725

			if var_424_15 < arg_421_1.time_ and arg_421_1.time_ <= var_424_15 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_17 = arg_421_1:FormatText(StoryNameCfg[32].name)

				arg_421_1.leftNameTxt_.text = var_424_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_18 = arg_421_1:GetWordFromCfg(1106605107)
				local var_424_19 = arg_421_1:FormatText(var_424_18.content)

				arg_421_1.text_.text = var_424_19

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_20 = 29
				local var_424_21 = utf8.len(var_424_19)
				local var_424_22 = var_424_20 <= 0 and var_424_16 or var_424_16 * (var_424_21 / var_424_20)

				if var_424_22 > 0 and var_424_16 < var_424_22 then
					arg_421_1.talkMaxDuration = var_424_22

					if var_424_22 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_22 + var_424_15
					end
				end

				arg_421_1.text_.text = var_424_19
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605107", "story_v_side_new_1106605.awb") ~= 0 then
					local var_424_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605107", "story_v_side_new_1106605.awb") / 1000

					if var_424_23 + var_424_15 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_15
					end

					if var_424_18.prefab_name ~= "" and arg_421_1.actors_[var_424_18.prefab_name] ~= nil then
						local var_424_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_18.prefab_name].transform, "story_v_side_new_1106605", "1106605107", "story_v_side_new_1106605.awb")

						arg_421_1:RecordAudio("1106605107", var_424_24)
						arg_421_1:RecordAudio("1106605107", var_424_24)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605107", "story_v_side_new_1106605.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605107", "story_v_side_new_1106605.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_25 = math.max(var_424_16, arg_421_1.talkMaxDuration)

			if var_424_15 <= arg_421_1.time_ and arg_421_1.time_ < var_424_15 + var_424_25 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_15) / var_424_25

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_15 + var_424_25 and arg_421_1.time_ < var_424_15 + var_424_25 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605108 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1106605108
		arg_425_1.duration_ = 0.999999999999

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"

			SetActive(arg_425_1.choicesGo_, true)

			for iter_426_0, iter_426_1 in ipairs(arg_425_1.choices_) do
				local var_426_0 = iter_426_0 <= 1

				SetActive(iter_426_1.go, var_426_0)
			end

			arg_425_1.choices_[1].txt.text = arg_425_1:FormatText(StoryChoiceCfg[551].name)
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1106605109(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			local var_428_1 = 0.5

			if arg_425_1.time_ >= var_428_0 + var_428_1 and arg_425_1.time_ < var_428_0 + var_428_1 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end

			local var_428_2 = arg_425_1.actors_["106603ui_story"]
			local var_428_3 = 0

			if var_428_3 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 and arg_425_1.var_.characterEffect106603ui_story == nil then
				arg_425_1.var_.characterEffect106603ui_story = var_428_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_4 = 0.200000002980232

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_4 then
				local var_428_5 = (arg_425_1.time_ - var_428_3) / var_428_4

				if arg_425_1.var_.characterEffect106603ui_story then
					local var_428_6 = Mathf.Lerp(0, 0.5, var_428_5)

					arg_425_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_425_1.var_.characterEffect106603ui_story.fillRatio = var_428_6
				end
			end

			if arg_425_1.time_ >= var_428_3 + var_428_4 and arg_425_1.time_ < var_428_3 + var_428_4 + arg_428_0 and arg_425_1.var_.characterEffect106603ui_story then
				local var_428_7 = 0.5

				arg_425_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_425_1.var_.characterEffect106603ui_story.fillRatio = var_428_7
			end
		end
	end,
	Play1106605109 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1106605109
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1106605110(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["106603ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos106603ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(0, 100, 0)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos106603ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(0, 100, 0)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = 0
			local var_432_10 = 1.1

			if var_432_9 < arg_429_1.time_ and arg_429_1.time_ <= var_432_9 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_11 = arg_429_1:GetWordFromCfg(1106605109)
				local var_432_12 = arg_429_1:FormatText(var_432_11.content)

				arg_429_1.text_.text = var_432_12

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_13 = 44
				local var_432_14 = utf8.len(var_432_12)
				local var_432_15 = var_432_13 <= 0 and var_432_10 or var_432_10 * (var_432_14 / var_432_13)

				if var_432_15 > 0 and var_432_10 < var_432_15 then
					arg_429_1.talkMaxDuration = var_432_15

					if var_432_15 + var_432_9 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_15 + var_432_9
					end
				end

				arg_429_1.text_.text = var_432_12
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_16 = math.max(var_432_10, arg_429_1.talkMaxDuration)

			if var_432_9 <= arg_429_1.time_ and arg_429_1.time_ < var_432_9 + var_432_16 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_9) / var_432_16

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_9 + var_432_16 and arg_429_1.time_ < var_432_9 + var_432_16 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605110 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1106605110
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1106605111(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.825

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_3 = arg_433_1:GetWordFromCfg(1106605110)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 33
				local var_436_6 = utf8.len(var_436_4)
				local var_436_7 = var_436_5 <= 0 and var_436_1 or var_436_1 * (var_436_6 / var_436_5)

				if var_436_7 > 0 and var_436_1 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_8 and arg_433_1.time_ < var_436_0 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605111 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1106605111
		arg_437_1.duration_ = 4

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1106605112(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["106603ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos106603ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0, -0.77, -6.25)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos106603ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["106603ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and arg_437_1.var_.characterEffect106603ui_story == nil then
				arg_437_1.var_.characterEffect106603ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect106603ui_story then
					arg_437_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and arg_437_1.var_.characterEffect106603ui_story then
				arg_437_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_440_13 = 0

			if var_440_13 < arg_437_1.time_ and arg_437_1.time_ <= var_440_13 + arg_440_0 then
				arg_437_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_440_15 = 0
			local var_440_16 = 0.475

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[32].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(1106605111)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 19
				local var_440_21 = utf8.len(var_440_19)
				local var_440_22 = var_440_20 <= 0 and var_440_16 or var_440_16 * (var_440_21 / var_440_20)

				if var_440_22 > 0 and var_440_16 < var_440_22 then
					arg_437_1.talkMaxDuration = var_440_22

					if var_440_22 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_22 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_19
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605111", "story_v_side_new_1106605.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605111", "story_v_side_new_1106605.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_side_new_1106605", "1106605111", "story_v_side_new_1106605.awb")

						arg_437_1:RecordAudio("1106605111", var_440_24)
						arg_437_1:RecordAudio("1106605111", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605111", "story_v_side_new_1106605.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605111", "story_v_side_new_1106605.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_25 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_25 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_25

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_25 and arg_437_1.time_ < var_440_15 + var_440_25 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605112 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1106605112
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1106605113(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["106603ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and arg_441_1.var_.characterEffect106603ui_story == nil then
				arg_441_1.var_.characterEffect106603ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect106603ui_story then
					local var_444_4 = Mathf.Lerp(0, 0.5, var_444_3)

					arg_441_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_441_1.var_.characterEffect106603ui_story.fillRatio = var_444_4
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and arg_441_1.var_.characterEffect106603ui_story then
				local var_444_5 = 0.5

				arg_441_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_441_1.var_.characterEffect106603ui_story.fillRatio = var_444_5
			end

			local var_444_6 = 0
			local var_444_7 = 0.425

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_9 = arg_441_1:GetWordFromCfg(1106605112)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 17
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_14 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_14 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_14

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_14 and arg_441_1.time_ < var_444_6 + var_444_14 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605113 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1106605113
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1106605114(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.475

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(1106605113)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 19
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605114 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1106605114
		arg_449_1.duration_ = 3.666

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1106605115(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["106603ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos106603ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, -0.77, -6.25)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos106603ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["106603ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and arg_449_1.var_.characterEffect106603ui_story == nil then
				arg_449_1.var_.characterEffect106603ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect106603ui_story then
					arg_449_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and arg_449_1.var_.characterEffect106603ui_story then
				arg_449_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_452_13 = 0

			if var_452_13 < arg_449_1.time_ and arg_449_1.time_ <= var_452_13 + arg_452_0 then
				arg_449_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_452_14 = 0

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 then
				arg_449_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_2")
			end

			local var_452_15 = 0
			local var_452_16 = 0.425

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[32].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(1106605114)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 17
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605114", "story_v_side_new_1106605.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605114", "story_v_side_new_1106605.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_side_new_1106605", "1106605114", "story_v_side_new_1106605.awb")

						arg_449_1:RecordAudio("1106605114", var_452_24)
						arg_449_1:RecordAudio("1106605114", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605114", "story_v_side_new_1106605.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605114", "story_v_side_new_1106605.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605115 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1106605115
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1106605116(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["106603ui_story"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and arg_453_1.var_.characterEffect106603ui_story == nil then
				arg_453_1.var_.characterEffect106603ui_story = var_456_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.characterEffect106603ui_story then
					local var_456_4 = Mathf.Lerp(0, 0.5, var_456_3)

					arg_453_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_453_1.var_.characterEffect106603ui_story.fillRatio = var_456_4
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and arg_453_1.var_.characterEffect106603ui_story then
				local var_456_5 = 0.5

				arg_453_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_453_1.var_.characterEffect106603ui_story.fillRatio = var_456_5
			end

			local var_456_6 = 0
			local var_456_7 = 0.45

			if var_456_6 < arg_453_1.time_ and arg_453_1.time_ <= var_456_6 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_8 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_9 = arg_453_1:GetWordFromCfg(1106605115)
				local var_456_10 = arg_453_1:FormatText(var_456_9.content)

				arg_453_1.text_.text = var_456_10

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_11 = 18
				local var_456_12 = utf8.len(var_456_10)
				local var_456_13 = var_456_11 <= 0 and var_456_7 or var_456_7 * (var_456_12 / var_456_11)

				if var_456_13 > 0 and var_456_7 < var_456_13 then
					arg_453_1.talkMaxDuration = var_456_13

					if var_456_13 + var_456_6 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_13 + var_456_6
					end
				end

				arg_453_1.text_.text = var_456_10
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_14 = math.max(var_456_7, arg_453_1.talkMaxDuration)

			if var_456_6 <= arg_453_1.time_ and arg_453_1.time_ < var_456_6 + var_456_14 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_6) / var_456_14

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_6 + var_456_14 and arg_453_1.time_ < var_456_6 + var_456_14 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605116 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1106605116
		arg_457_1.duration_ = 4.333

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1106605117(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["106603ui_story"].transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPos106603ui_story = var_460_0.localPosition
			end

			local var_460_2 = 0.001

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0, -0.77, -6.25)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos106603ui_story, var_460_4, var_460_3)

				local var_460_5 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_5.x, var_460_5.y, var_460_5.z)

				local var_460_6 = var_460_0.localEulerAngles

				var_460_6.z = 0
				var_460_6.x = 0
				var_460_0.localEulerAngles = var_460_6
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_460_7 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_7.x, var_460_7.y, var_460_7.z)

				local var_460_8 = var_460_0.localEulerAngles

				var_460_8.z = 0
				var_460_8.x = 0
				var_460_0.localEulerAngles = var_460_8
			end

			local var_460_9 = arg_457_1.actors_["106603ui_story"]
			local var_460_10 = 0

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 and arg_457_1.var_.characterEffect106603ui_story == nil then
				arg_457_1.var_.characterEffect106603ui_story = var_460_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_11 = 0.200000002980232

			if var_460_10 <= arg_457_1.time_ and arg_457_1.time_ < var_460_10 + var_460_11 then
				local var_460_12 = (arg_457_1.time_ - var_460_10) / var_460_11

				if arg_457_1.var_.characterEffect106603ui_story then
					arg_457_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= var_460_10 + var_460_11 and arg_457_1.time_ < var_460_10 + var_460_11 + arg_460_0 and arg_457_1.var_.characterEffect106603ui_story then
				arg_457_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_460_13 = 0

			if var_460_13 < arg_457_1.time_ and arg_457_1.time_ <= var_460_13 + arg_460_0 then
				arg_457_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_460_14 = 0

			if var_460_14 < arg_457_1.time_ and arg_457_1.time_ <= var_460_14 + arg_460_0 then
				arg_457_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_1")
			end

			local var_460_15 = 0
			local var_460_16 = 0.575

			if var_460_15 < arg_457_1.time_ and arg_457_1.time_ <= var_460_15 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_17 = arg_457_1:FormatText(StoryNameCfg[32].name)

				arg_457_1.leftNameTxt_.text = var_460_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_18 = arg_457_1:GetWordFromCfg(1106605116)
				local var_460_19 = arg_457_1:FormatText(var_460_18.content)

				arg_457_1.text_.text = var_460_19

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_20 = 23
				local var_460_21 = utf8.len(var_460_19)
				local var_460_22 = var_460_20 <= 0 and var_460_16 or var_460_16 * (var_460_21 / var_460_20)

				if var_460_22 > 0 and var_460_16 < var_460_22 then
					arg_457_1.talkMaxDuration = var_460_22

					if var_460_22 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_22 + var_460_15
					end
				end

				arg_457_1.text_.text = var_460_19
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605116", "story_v_side_new_1106605.awb") ~= 0 then
					local var_460_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605116", "story_v_side_new_1106605.awb") / 1000

					if var_460_23 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_23 + var_460_15
					end

					if var_460_18.prefab_name ~= "" and arg_457_1.actors_[var_460_18.prefab_name] ~= nil then
						local var_460_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_18.prefab_name].transform, "story_v_side_new_1106605", "1106605116", "story_v_side_new_1106605.awb")

						arg_457_1:RecordAudio("1106605116", var_460_24)
						arg_457_1:RecordAudio("1106605116", var_460_24)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605116", "story_v_side_new_1106605.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605116", "story_v_side_new_1106605.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_25 = math.max(var_460_16, arg_457_1.talkMaxDuration)

			if var_460_15 <= arg_457_1.time_ and arg_457_1.time_ < var_460_15 + var_460_25 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_15) / var_460_25

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_15 + var_460_25 and arg_457_1.time_ < var_460_15 + var_460_25 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605117 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1106605117
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1106605118(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["106603ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos106603ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, 100, 0)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos106603ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, 100, 0)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = 0
			local var_464_10 = 1.55

			if var_464_9 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_11 = arg_461_1:GetWordFromCfg(1106605117)
				local var_464_12 = arg_461_1:FormatText(var_464_11.content)

				arg_461_1.text_.text = var_464_12

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 62
				local var_464_14 = utf8.len(var_464_12)
				local var_464_15 = var_464_13 <= 0 and var_464_10 or var_464_10 * (var_464_14 / var_464_13)

				if var_464_15 > 0 and var_464_10 < var_464_15 then
					arg_461_1.talkMaxDuration = var_464_15

					if var_464_15 + var_464_9 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_15 + var_464_9
					end
				end

				arg_461_1.text_.text = var_464_12
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_10, arg_461_1.talkMaxDuration)

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_9) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_9 + var_464_16 and arg_461_1.time_ < var_464_9 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605118 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1106605118
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1106605119(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.175

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:GetWordFromCfg(1106605118)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 7
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_8 and arg_465_1.time_ < var_468_0 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605119 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1106605119
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1106605120(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["106603ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos106603ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, -0.77, -6.25)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos106603ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["106603ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and arg_469_1.var_.characterEffect106603ui_story == nil then
				arg_469_1.var_.characterEffect106603ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.0166666666666667

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect106603ui_story then
					local var_472_13 = Mathf.Lerp(0, 0.5, var_472_12)

					arg_469_1.var_.characterEffect106603ui_story.fillFlat = true
					arg_469_1.var_.characterEffect106603ui_story.fillRatio = var_472_13
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and arg_469_1.var_.characterEffect106603ui_story then
				local var_472_14 = 0.5

				arg_469_1.var_.characterEffect106603ui_story.fillFlat = true
				arg_469_1.var_.characterEffect106603ui_story.fillRatio = var_472_14
			end

			local var_472_15 = 0

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_472_16 = 0

			if var_472_16 < arg_469_1.time_ and arg_469_1.time_ <= var_472_16 + arg_472_0 then
				arg_469_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action436")
			end

			local var_472_17 = 0

			if var_472_17 < arg_469_1.time_ and arg_469_1.time_ <= var_472_17 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_18 = 3

			if arg_469_1.time_ >= var_472_17 + var_472_18 and arg_469_1.time_ < var_472_17 + var_472_18 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_19 = 0
			local var_472_20 = 1.1

			if var_472_19 < arg_469_1.time_ and arg_469_1.time_ <= var_472_19 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_21 = arg_469_1:GetWordFromCfg(1106605119)
				local var_472_22 = arg_469_1:FormatText(var_472_21.content)

				arg_469_1.text_.text = var_472_22

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_23 = 44
				local var_472_24 = utf8.len(var_472_22)
				local var_472_25 = var_472_23 <= 0 and var_472_20 or var_472_20 * (var_472_24 / var_472_23)

				if var_472_25 > 0 and var_472_20 < var_472_25 then
					arg_469_1.talkMaxDuration = var_472_25

					if var_472_25 + var_472_19 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_25 + var_472_19
					end
				end

				arg_469_1.text_.text = var_472_22
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_26 = math.max(var_472_20, arg_469_1.talkMaxDuration)

			if var_472_19 <= arg_469_1.time_ and arg_469_1.time_ < var_472_19 + var_472_26 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_19) / var_472_26

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_19 + var_472_26 and arg_469_1.time_ < var_472_19 + var_472_26 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605120 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1106605120
		arg_473_1.duration_ = 3.4

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1106605121(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["106603ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos106603ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(0, -0.77, -6.25)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos106603ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["106603ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and arg_473_1.var_.characterEffect106603ui_story == nil then
				arg_473_1.var_.characterEffect106603ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect106603ui_story then
					arg_473_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and arg_473_1.var_.characterEffect106603ui_story then
				arg_473_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_2")
			end

			local var_476_15 = 0
			local var_476_16 = 0.4

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[32].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(1106605120)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 16
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605120", "story_v_side_new_1106605.awb") ~= 0 then
					local var_476_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605120", "story_v_side_new_1106605.awb") / 1000

					if var_476_23 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_23 + var_476_15
					end

					if var_476_18.prefab_name ~= "" and arg_473_1.actors_[var_476_18.prefab_name] ~= nil then
						local var_476_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_18.prefab_name].transform, "story_v_side_new_1106605", "1106605120", "story_v_side_new_1106605.awb")

						arg_473_1:RecordAudio("1106605120", var_476_24)
						arg_473_1:RecordAudio("1106605120", var_476_24)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605120", "story_v_side_new_1106605.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605120", "story_v_side_new_1106605.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_25 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_25 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_25

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_25 and arg_473_1.time_ < var_476_15 + var_476_25 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605121 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1106605121
		arg_477_1.duration_ = 5.999999999999

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1106605122(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = "ST02"

			if arg_477_1.bgs_[var_480_0] == nil then
				local var_480_1 = Object.Instantiate(arg_477_1.paintGo_)

				var_480_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_480_0)
				var_480_1.name = var_480_0
				var_480_1.transform.parent = arg_477_1.stage_.transform
				var_480_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_477_1.bgs_[var_480_0] = var_480_1
			end

			local var_480_2 = 2

			if var_480_2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				local var_480_3 = manager.ui.mainCamera.transform.localPosition
				local var_480_4 = Vector3.New(0, 0, 10) + Vector3.New(var_480_3.x, var_480_3.y, 0)
				local var_480_5 = arg_477_1.bgs_.ST02

				var_480_5.transform.localPosition = var_480_4
				var_480_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_6 = var_480_5:GetComponent("SpriteRenderer")

				if var_480_6 and var_480_6.sprite then
					local var_480_7 = (var_480_5.transform.localPosition - var_480_3).z
					local var_480_8 = manager.ui.mainCameraCom_
					local var_480_9 = 2 * var_480_7 * Mathf.Tan(var_480_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_480_10 = var_480_9 * var_480_8.aspect
					local var_480_11 = var_480_6.sprite.bounds.size.x
					local var_480_12 = var_480_6.sprite.bounds.size.y
					local var_480_13 = var_480_10 / var_480_11
					local var_480_14 = var_480_9 / var_480_12
					local var_480_15 = var_480_14 < var_480_13 and var_480_13 or var_480_14

					var_480_5.transform.localScale = Vector3.New(var_480_15, var_480_15, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "ST02" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_16 = 0

			if var_480_16 < arg_477_1.time_ and arg_477_1.time_ <= var_480_16 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_17 = 2

			if var_480_16 <= arg_477_1.time_ and arg_477_1.time_ < var_480_16 + var_480_17 then
				local var_480_18 = (arg_477_1.time_ - var_480_16) / var_480_17
				local var_480_19 = Color.New(0, 0, 0)

				var_480_19.a = Mathf.Lerp(0, 1, var_480_18)
				arg_477_1.mask_.color = var_480_19
			end

			if arg_477_1.time_ >= var_480_16 + var_480_17 and arg_477_1.time_ < var_480_16 + var_480_17 + arg_480_0 then
				local var_480_20 = Color.New(0, 0, 0)

				var_480_20.a = 1
				arg_477_1.mask_.color = var_480_20
			end

			local var_480_21 = 2

			if var_480_21 < arg_477_1.time_ and arg_477_1.time_ <= var_480_21 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_22 = 2

			if var_480_21 <= arg_477_1.time_ and arg_477_1.time_ < var_480_21 + var_480_22 then
				local var_480_23 = (arg_477_1.time_ - var_480_21) / var_480_22
				local var_480_24 = Color.New(0, 0, 0)

				var_480_24.a = Mathf.Lerp(1, 0, var_480_23)
				arg_477_1.mask_.color = var_480_24
			end

			if arg_477_1.time_ >= var_480_21 + var_480_22 and arg_477_1.time_ < var_480_21 + var_480_22 + arg_480_0 then
				local var_480_25 = Color.New(0, 0, 0)
				local var_480_26 = 0

				arg_477_1.mask_.enabled = false
				var_480_25.a = var_480_26
				arg_477_1.mask_.color = var_480_25
			end

			local var_480_27 = arg_477_1.actors_["106603ui_story"].transform
			local var_480_28 = 2

			if var_480_28 < arg_477_1.time_ and arg_477_1.time_ <= var_480_28 + arg_480_0 then
				arg_477_1.var_.moveOldPos106603ui_story = var_480_27.localPosition
			end

			local var_480_29 = 0.001

			if var_480_28 <= arg_477_1.time_ and arg_477_1.time_ < var_480_28 + var_480_29 then
				local var_480_30 = (arg_477_1.time_ - var_480_28) / var_480_29
				local var_480_31 = Vector3.New(0, 100, 0)

				var_480_27.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos106603ui_story, var_480_31, var_480_30)

				local var_480_32 = manager.ui.mainCamera.transform.position - var_480_27.position

				var_480_27.forward = Vector3.New(var_480_32.x, var_480_32.y, var_480_32.z)

				local var_480_33 = var_480_27.localEulerAngles

				var_480_33.z = 0
				var_480_33.x = 0
				var_480_27.localEulerAngles = var_480_33
			end

			if arg_477_1.time_ >= var_480_28 + var_480_29 and arg_477_1.time_ < var_480_28 + var_480_29 + arg_480_0 then
				var_480_27.localPosition = Vector3.New(0, 100, 0)

				local var_480_34 = manager.ui.mainCamera.transform.position - var_480_27.position

				var_480_27.forward = Vector3.New(var_480_34.x, var_480_34.y, var_480_34.z)

				local var_480_35 = var_480_27.localEulerAngles

				var_480_35.z = 0
				var_480_35.x = 0
				var_480_27.localEulerAngles = var_480_35
			end

			local var_480_36 = arg_477_1.actors_["1066ui_story"].transform
			local var_480_37 = 4

			if var_480_37 < arg_477_1.time_ and arg_477_1.time_ <= var_480_37 + arg_480_0 then
				arg_477_1.var_.moveOldPos1066ui_story = var_480_36.localPosition
			end

			local var_480_38 = 0.001

			if var_480_37 <= arg_477_1.time_ and arg_477_1.time_ < var_480_37 + var_480_38 then
				local var_480_39 = (arg_477_1.time_ - var_480_37) / var_480_38
				local var_480_40 = Vector3.New(0, -0.77, -6.1)

				var_480_36.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1066ui_story, var_480_40, var_480_39)

				local var_480_41 = manager.ui.mainCamera.transform.position - var_480_36.position

				var_480_36.forward = Vector3.New(var_480_41.x, var_480_41.y, var_480_41.z)

				local var_480_42 = var_480_36.localEulerAngles

				var_480_42.z = 0
				var_480_42.x = 0
				var_480_36.localEulerAngles = var_480_42
			end

			if arg_477_1.time_ >= var_480_37 + var_480_38 and arg_477_1.time_ < var_480_37 + var_480_38 + arg_480_0 then
				var_480_36.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_480_43 = manager.ui.mainCamera.transform.position - var_480_36.position

				var_480_36.forward = Vector3.New(var_480_43.x, var_480_43.y, var_480_43.z)

				local var_480_44 = var_480_36.localEulerAngles

				var_480_44.z = 0
				var_480_44.x = 0
				var_480_36.localEulerAngles = var_480_44
			end

			local var_480_45 = arg_477_1.actors_["1066ui_story"]
			local var_480_46 = 4

			if var_480_46 < arg_477_1.time_ and arg_477_1.time_ <= var_480_46 + arg_480_0 and arg_477_1.var_.characterEffect1066ui_story == nil then
				arg_477_1.var_.characterEffect1066ui_story = var_480_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_47 = 0.200000002980232

			if var_480_46 <= arg_477_1.time_ and arg_477_1.time_ < var_480_46 + var_480_47 then
				local var_480_48 = (arg_477_1.time_ - var_480_46) / var_480_47

				if arg_477_1.var_.characterEffect1066ui_story then
					arg_477_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_46 + var_480_47 and arg_477_1.time_ < var_480_46 + var_480_47 + arg_480_0 and arg_477_1.var_.characterEffect1066ui_story then
				arg_477_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_480_49 = 4

			if var_480_49 < arg_477_1.time_ and arg_477_1.time_ <= var_480_49 + arg_480_0 then
				arg_477_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			local var_480_50 = 4

			if var_480_50 < arg_477_1.time_ and arg_477_1.time_ <= var_480_50 + arg_480_0 then
				arg_477_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_51 = 0
			local var_480_52 = 1

			if var_480_51 < arg_477_1.time_ and arg_477_1.time_ <= var_480_51 + arg_480_0 then
				local var_480_53 = "stop"
				local var_480_54 = "effect"

				arg_477_1:AudioAction(var_480_53, var_480_54, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_55 = 4
			local var_480_56 = 0.125

			if var_480_55 < arg_477_1.time_ and arg_477_1.time_ <= var_480_55 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				local var_480_57 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_57:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_58 = arg_477_1:FormatText(StoryNameCfg[32].name)

				arg_477_1.leftNameTxt_.text = var_480_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_59 = arg_477_1:GetWordFromCfg(1106605121)
				local var_480_60 = arg_477_1:FormatText(var_480_59.content)

				arg_477_1.text_.text = var_480_60

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_61 = 5
				local var_480_62 = utf8.len(var_480_60)
				local var_480_63 = var_480_61 <= 0 and var_480_56 or var_480_56 * (var_480_62 / var_480_61)

				if var_480_63 > 0 and var_480_56 < var_480_63 then
					arg_477_1.talkMaxDuration = var_480_63
					var_480_55 = var_480_55 + 0.3

					if var_480_63 + var_480_55 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_63 + var_480_55
					end
				end

				arg_477_1.text_.text = var_480_60
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605121", "story_v_side_new_1106605.awb") ~= 0 then
					local var_480_64 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605121", "story_v_side_new_1106605.awb") / 1000

					if var_480_64 + var_480_55 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_64 + var_480_55
					end

					if var_480_59.prefab_name ~= "" and arg_477_1.actors_[var_480_59.prefab_name] ~= nil then
						local var_480_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_59.prefab_name].transform, "story_v_side_new_1106605", "1106605121", "story_v_side_new_1106605.awb")

						arg_477_1:RecordAudio("1106605121", var_480_65)
						arg_477_1:RecordAudio("1106605121", var_480_65)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605121", "story_v_side_new_1106605.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605121", "story_v_side_new_1106605.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_66 = var_480_55 + 0.3
			local var_480_67 = math.max(var_480_56, arg_477_1.talkMaxDuration)

			if var_480_66 <= arg_477_1.time_ and arg_477_1.time_ < var_480_66 + var_480_67 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_66) / var_480_67

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_66 + var_480_67 and arg_477_1.time_ < var_480_66 + var_480_67 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605122 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1106605122
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1106605123(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1066ui_story"]
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 and arg_483_1.var_.characterEffect1066ui_story == nil then
				arg_483_1.var_.characterEffect1066ui_story = var_486_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_2 then
				local var_486_3 = (arg_483_1.time_ - var_486_1) / var_486_2

				if arg_483_1.var_.characterEffect1066ui_story then
					local var_486_4 = Mathf.Lerp(0, 0.5, var_486_3)

					arg_483_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1066ui_story.fillRatio = var_486_4
				end
			end

			if arg_483_1.time_ >= var_486_1 + var_486_2 and arg_483_1.time_ < var_486_1 + var_486_2 + arg_486_0 and arg_483_1.var_.characterEffect1066ui_story then
				local var_486_5 = 0.5

				arg_483_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1066ui_story.fillRatio = var_486_5
			end

			local var_486_6 = 0
			local var_486_7 = 1.1

			if var_486_6 < arg_483_1.time_ and arg_483_1.time_ <= var_486_6 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_8 = arg_483_1:GetWordFromCfg(1106605122)
				local var_486_9 = arg_483_1:FormatText(var_486_8.content)

				arg_483_1.text_.text = var_486_9

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_10 = 44
				local var_486_11 = utf8.len(var_486_9)
				local var_486_12 = var_486_10 <= 0 and var_486_7 or var_486_7 * (var_486_11 / var_486_10)

				if var_486_12 > 0 and var_486_7 < var_486_12 then
					arg_483_1.talkMaxDuration = var_486_12

					if var_486_12 + var_486_6 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_12 + var_486_6
					end
				end

				arg_483_1.text_.text = var_486_9
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_13 = math.max(var_486_7, arg_483_1.talkMaxDuration)

			if var_486_6 <= arg_483_1.time_ and arg_483_1.time_ < var_486_6 + var_486_13 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_6) / var_486_13

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_6 + var_486_13 and arg_483_1.time_ < var_486_6 + var_486_13 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605123 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1106605123
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1106605124(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 1.125

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[7].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_3 = arg_487_1:GetWordFromCfg(1106605123)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 45
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_8 and arg_487_1.time_ < var_490_0 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605124 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1106605124
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1106605125(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1066ui_story"].transform
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.var_.moveOldPos1066ui_story = var_494_0.localPosition
			end

			local var_494_2 = 0.001

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2
				local var_494_4 = Vector3.New(0, -0.77, -6.1)

				var_494_0.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1066ui_story, var_494_4, var_494_3)

				local var_494_5 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_5.x, var_494_5.y, var_494_5.z)

				local var_494_6 = var_494_0.localEulerAngles

				var_494_6.z = 0
				var_494_6.x = 0
				var_494_0.localEulerAngles = var_494_6
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 then
				var_494_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_494_7 = manager.ui.mainCamera.transform.position - var_494_0.position

				var_494_0.forward = Vector3.New(var_494_7.x, var_494_7.y, var_494_7.z)

				local var_494_8 = var_494_0.localEulerAngles

				var_494_8.z = 0
				var_494_8.x = 0
				var_494_0.localEulerAngles = var_494_8
			end

			local var_494_9 = arg_491_1.actors_["1066ui_story"]
			local var_494_10 = 0

			if var_494_10 < arg_491_1.time_ and arg_491_1.time_ <= var_494_10 + arg_494_0 and arg_491_1.var_.characterEffect1066ui_story == nil then
				arg_491_1.var_.characterEffect1066ui_story = var_494_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_11 = 0.200000002980232

			if var_494_10 <= arg_491_1.time_ and arg_491_1.time_ < var_494_10 + var_494_11 then
				local var_494_12 = (arg_491_1.time_ - var_494_10) / var_494_11

				if arg_491_1.var_.characterEffect1066ui_story then
					arg_491_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= var_494_10 + var_494_11 and arg_491_1.time_ < var_494_10 + var_494_11 + arg_494_0 and arg_491_1.var_.characterEffect1066ui_story then
				arg_491_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_494_13 = 0

			if var_494_13 < arg_491_1.time_ and arg_491_1.time_ <= var_494_13 + arg_494_0 then
				arg_491_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_494_14 = 0
			local var_494_15 = 0.575

			if var_494_14 < arg_491_1.time_ and arg_491_1.time_ <= var_494_14 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_16 = arg_491_1:FormatText(StoryNameCfg[32].name)

				arg_491_1.leftNameTxt_.text = var_494_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_17 = arg_491_1:GetWordFromCfg(1106605124)
				local var_494_18 = arg_491_1:FormatText(var_494_17.content)

				arg_491_1.text_.text = var_494_18

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_19 = 23
				local var_494_20 = utf8.len(var_494_18)
				local var_494_21 = var_494_19 <= 0 and var_494_15 or var_494_15 * (var_494_20 / var_494_19)

				if var_494_21 > 0 and var_494_15 < var_494_21 then
					arg_491_1.talkMaxDuration = var_494_21

					if var_494_21 + var_494_14 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_21 + var_494_14
					end
				end

				arg_491_1.text_.text = var_494_18
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605124", "story_v_side_new_1106605.awb") ~= 0 then
					local var_494_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605124", "story_v_side_new_1106605.awb") / 1000

					if var_494_22 + var_494_14 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_22 + var_494_14
					end

					if var_494_17.prefab_name ~= "" and arg_491_1.actors_[var_494_17.prefab_name] ~= nil then
						local var_494_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_17.prefab_name].transform, "story_v_side_new_1106605", "1106605124", "story_v_side_new_1106605.awb")

						arg_491_1:RecordAudio("1106605124", var_494_23)
						arg_491_1:RecordAudio("1106605124", var_494_23)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605124", "story_v_side_new_1106605.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605124", "story_v_side_new_1106605.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_24 = math.max(var_494_15, arg_491_1.talkMaxDuration)

			if var_494_14 <= arg_491_1.time_ and arg_491_1.time_ < var_494_14 + var_494_24 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_14) / var_494_24

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_14 + var_494_24 and arg_491_1.time_ < var_494_14 + var_494_24 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605125 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1106605125
		arg_495_1.duration_ = 6.833

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1106605126(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1066ui_story"].transform
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.var_.moveOldPos1066ui_story = var_498_0.localPosition
			end

			local var_498_2 = 0.001

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2
				local var_498_4 = Vector3.New(0, -0.77, -6.1)

				var_498_0.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1066ui_story, var_498_4, var_498_3)

				local var_498_5 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_5.x, var_498_5.y, var_498_5.z)

				local var_498_6 = var_498_0.localEulerAngles

				var_498_6.z = 0
				var_498_6.x = 0
				var_498_0.localEulerAngles = var_498_6
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 then
				var_498_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_498_7 = manager.ui.mainCamera.transform.position - var_498_0.position

				var_498_0.forward = Vector3.New(var_498_7.x, var_498_7.y, var_498_7.z)

				local var_498_8 = var_498_0.localEulerAngles

				var_498_8.z = 0
				var_498_8.x = 0
				var_498_0.localEulerAngles = var_498_8
			end

			local var_498_9 = arg_495_1.actors_["1066ui_story"]
			local var_498_10 = 0

			if var_498_10 < arg_495_1.time_ and arg_495_1.time_ <= var_498_10 + arg_498_0 and arg_495_1.var_.characterEffect1066ui_story == nil then
				arg_495_1.var_.characterEffect1066ui_story = var_498_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_11 = 0.200000002980232

			if var_498_10 <= arg_495_1.time_ and arg_495_1.time_ < var_498_10 + var_498_11 then
				local var_498_12 = (arg_495_1.time_ - var_498_10) / var_498_11

				if arg_495_1.var_.characterEffect1066ui_story then
					arg_495_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= var_498_10 + var_498_11 and arg_495_1.time_ < var_498_10 + var_498_11 + arg_498_0 and arg_495_1.var_.characterEffect1066ui_story then
				arg_495_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_498_13 = 0

			if var_498_13 < arg_495_1.time_ and arg_495_1.time_ <= var_498_13 + arg_498_0 then
				arg_495_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_2")
			end

			local var_498_14 = 0

			if var_498_14 < arg_495_1.time_ and arg_495_1.time_ <= var_498_14 + arg_498_0 then
				arg_495_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_498_15 = 0
			local var_498_16 = 0.8

			if var_498_15 < arg_495_1.time_ and arg_495_1.time_ <= var_498_15 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_17 = arg_495_1:FormatText(StoryNameCfg[32].name)

				arg_495_1.leftNameTxt_.text = var_498_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_18 = arg_495_1:GetWordFromCfg(1106605125)
				local var_498_19 = arg_495_1:FormatText(var_498_18.content)

				arg_495_1.text_.text = var_498_19

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_20 = 32
				local var_498_21 = utf8.len(var_498_19)
				local var_498_22 = var_498_20 <= 0 and var_498_16 or var_498_16 * (var_498_21 / var_498_20)

				if var_498_22 > 0 and var_498_16 < var_498_22 then
					arg_495_1.talkMaxDuration = var_498_22

					if var_498_22 + var_498_15 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_22 + var_498_15
					end
				end

				arg_495_1.text_.text = var_498_19
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605125", "story_v_side_new_1106605.awb") ~= 0 then
					local var_498_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605125", "story_v_side_new_1106605.awb") / 1000

					if var_498_23 + var_498_15 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_23 + var_498_15
					end

					if var_498_18.prefab_name ~= "" and arg_495_1.actors_[var_498_18.prefab_name] ~= nil then
						local var_498_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_18.prefab_name].transform, "story_v_side_new_1106605", "1106605125", "story_v_side_new_1106605.awb")

						arg_495_1:RecordAudio("1106605125", var_498_24)
						arg_495_1:RecordAudio("1106605125", var_498_24)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605125", "story_v_side_new_1106605.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605125", "story_v_side_new_1106605.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_25 = math.max(var_498_16, arg_495_1.talkMaxDuration)

			if var_498_15 <= arg_495_1.time_ and arg_495_1.time_ < var_498_15 + var_498_25 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_15) / var_498_25

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_15 + var_498_25 and arg_495_1.time_ < var_498_15 + var_498_25 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605126 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1106605126
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1106605127(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1066ui_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and arg_499_1.var_.characterEffect1066ui_story == nil then
				arg_499_1.var_.characterEffect1066ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect1066ui_story then
					local var_502_4 = Mathf.Lerp(0, 0.5, var_502_3)

					arg_499_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1066ui_story.fillRatio = var_502_4
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and arg_499_1.var_.characterEffect1066ui_story then
				local var_502_5 = 0.5

				arg_499_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1066ui_story.fillRatio = var_502_5
			end

			local var_502_6 = 0
			local var_502_7 = 0.85

			if var_502_6 < arg_499_1.time_ and arg_499_1.time_ <= var_502_6 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_8 = arg_499_1:FormatText(StoryNameCfg[7].name)

				arg_499_1.leftNameTxt_.text = var_502_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_9 = arg_499_1:GetWordFromCfg(1106605126)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 34
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
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_14 = math.max(var_502_7, arg_499_1.talkMaxDuration)

			if var_502_6 <= arg_499_1.time_ and arg_499_1.time_ < var_502_6 + var_502_14 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_6) / var_502_14

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_6 + var_502_14 and arg_499_1.time_ < var_502_6 + var_502_14 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605127 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1106605127
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1106605128(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.95

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(1106605127)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 38
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605128 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1106605128
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1106605129(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.325

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:GetWordFromCfg(1106605128)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 13
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_8 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_8 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_8

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_8 and arg_507_1.time_ < var_510_0 + var_510_8 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605129 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1106605129
		arg_511_1.duration_ = 7.866

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1106605130(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1066ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos1066ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -0.77, -6.1)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1066ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["1066ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and arg_511_1.var_.characterEffect1066ui_story == nil then
				arg_511_1.var_.characterEffect1066ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect1066ui_story then
					arg_511_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and arg_511_1.var_.characterEffect1066ui_story then
				arg_511_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_514_13 = 0

			if var_514_13 < arg_511_1.time_ and arg_511_1.time_ <= var_514_13 + arg_514_0 then
				arg_511_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_514_14 = 0

			if var_514_14 < arg_511_1.time_ and arg_511_1.time_ <= var_514_14 + arg_514_0 then
				arg_511_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_514_15 = 0
			local var_514_16 = 0.925

			if var_514_15 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_17 = arg_511_1:FormatText(StoryNameCfg[32].name)

				arg_511_1.leftNameTxt_.text = var_514_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_18 = arg_511_1:GetWordFromCfg(1106605129)
				local var_514_19 = arg_511_1:FormatText(var_514_18.content)

				arg_511_1.text_.text = var_514_19

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_20 = 37
				local var_514_21 = utf8.len(var_514_19)
				local var_514_22 = var_514_20 <= 0 and var_514_16 or var_514_16 * (var_514_21 / var_514_20)

				if var_514_22 > 0 and var_514_16 < var_514_22 then
					arg_511_1.talkMaxDuration = var_514_22

					if var_514_22 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_22 + var_514_15
					end
				end

				arg_511_1.text_.text = var_514_19
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605129", "story_v_side_new_1106605.awb") ~= 0 then
					local var_514_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605129", "story_v_side_new_1106605.awb") / 1000

					if var_514_23 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_23 + var_514_15
					end

					if var_514_18.prefab_name ~= "" and arg_511_1.actors_[var_514_18.prefab_name] ~= nil then
						local var_514_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_18.prefab_name].transform, "story_v_side_new_1106605", "1106605129", "story_v_side_new_1106605.awb")

						arg_511_1:RecordAudio("1106605129", var_514_24)
						arg_511_1:RecordAudio("1106605129", var_514_24)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605129", "story_v_side_new_1106605.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605129", "story_v_side_new_1106605.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_25 = math.max(var_514_16, arg_511_1.talkMaxDuration)

			if var_514_15 <= arg_511_1.time_ and arg_511_1.time_ < var_514_15 + var_514_25 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_15) / var_514_25

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_15 + var_514_25 and arg_511_1.time_ < var_514_15 + var_514_25 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605130 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1106605130
		arg_515_1.duration_ = 3.333

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1106605131(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1066ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1066ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, -0.77, -6.1)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1066ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1066ui_story"]
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 and arg_515_1.var_.characterEffect1066ui_story == nil then
				arg_515_1.var_.characterEffect1066ui_story = var_518_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_11 = 0.200000002980232

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11

				if arg_515_1.var_.characterEffect1066ui_story then
					arg_515_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 and arg_515_1.var_.characterEffect1066ui_story then
				arg_515_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_518_13 = 0

			if var_518_13 < arg_515_1.time_ and arg_515_1.time_ <= var_518_13 + arg_518_0 then
				arg_515_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_2")
			end

			local var_518_14 = 0

			if var_518_14 < arg_515_1.time_ and arg_515_1.time_ <= var_518_14 + arg_518_0 then
				arg_515_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_518_15 = 0
			local var_518_16 = 0.375

			if var_518_15 < arg_515_1.time_ and arg_515_1.time_ <= var_518_15 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_17 = arg_515_1:FormatText(StoryNameCfg[32].name)

				arg_515_1.leftNameTxt_.text = var_518_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_18 = arg_515_1:GetWordFromCfg(1106605130)
				local var_518_19 = arg_515_1:FormatText(var_518_18.content)

				arg_515_1.text_.text = var_518_19

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_20 = 15
				local var_518_21 = utf8.len(var_518_19)
				local var_518_22 = var_518_20 <= 0 and var_518_16 or var_518_16 * (var_518_21 / var_518_20)

				if var_518_22 > 0 and var_518_16 < var_518_22 then
					arg_515_1.talkMaxDuration = var_518_22

					if var_518_22 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_22 + var_518_15
					end
				end

				arg_515_1.text_.text = var_518_19
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605130", "story_v_side_new_1106605.awb") ~= 0 then
					local var_518_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605130", "story_v_side_new_1106605.awb") / 1000

					if var_518_23 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_23 + var_518_15
					end

					if var_518_18.prefab_name ~= "" and arg_515_1.actors_[var_518_18.prefab_name] ~= nil then
						local var_518_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_18.prefab_name].transform, "story_v_side_new_1106605", "1106605130", "story_v_side_new_1106605.awb")

						arg_515_1:RecordAudio("1106605130", var_518_24)
						arg_515_1:RecordAudio("1106605130", var_518_24)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605130", "story_v_side_new_1106605.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605130", "story_v_side_new_1106605.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_25 = math.max(var_518_16, arg_515_1.talkMaxDuration)

			if var_518_15 <= arg_515_1.time_ and arg_515_1.time_ < var_518_15 + var_518_25 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_15) / var_518_25

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_15 + var_518_25 and arg_515_1.time_ < var_518_15 + var_518_25 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605131 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1106605131
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1106605132(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1066ui_story"]
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 and arg_519_1.var_.characterEffect1066ui_story == nil then
				arg_519_1.var_.characterEffect1066ui_story = var_522_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2

				if arg_519_1.var_.characterEffect1066ui_story then
					local var_522_4 = Mathf.Lerp(0, 0.5, var_522_3)

					arg_519_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1066ui_story.fillRatio = var_522_4
				end
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 and arg_519_1.var_.characterEffect1066ui_story then
				local var_522_5 = 0.5

				arg_519_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1066ui_story.fillRatio = var_522_5
			end

			local var_522_6 = 0
			local var_522_7 = 1.1

			if var_522_6 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_8 = arg_519_1:GetWordFromCfg(1106605131)
				local var_522_9 = arg_519_1:FormatText(var_522_8.content)

				arg_519_1.text_.text = var_522_9

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_10 = 44
				local var_522_11 = utf8.len(var_522_9)
				local var_522_12 = var_522_10 <= 0 and var_522_7 or var_522_7 * (var_522_11 / var_522_10)

				if var_522_12 > 0 and var_522_7 < var_522_12 then
					arg_519_1.talkMaxDuration = var_522_12

					if var_522_12 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_9
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_13 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_13 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_13

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_13 and arg_519_1.time_ < var_522_6 + var_522_13 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605132 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1106605132
		arg_523_1.duration_ = 3.566

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1106605133(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1066ui_story"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos1066ui_story = var_526_0.localPosition
			end

			local var_526_2 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2
				local var_526_4 = Vector3.New(0, -0.77, -6.1)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1066ui_story, var_526_4, var_526_3)

				local var_526_5 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_5.x, var_526_5.y, var_526_5.z)

				local var_526_6 = var_526_0.localEulerAngles

				var_526_6.z = 0
				var_526_6.x = 0
				var_526_0.localEulerAngles = var_526_6
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_526_7 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_7.x, var_526_7.y, var_526_7.z)

				local var_526_8 = var_526_0.localEulerAngles

				var_526_8.z = 0
				var_526_8.x = 0
				var_526_0.localEulerAngles = var_526_8
			end

			local var_526_9 = arg_523_1.actors_["1066ui_story"]
			local var_526_10 = 0

			if var_526_10 < arg_523_1.time_ and arg_523_1.time_ <= var_526_10 + arg_526_0 and arg_523_1.var_.characterEffect1066ui_story == nil then
				arg_523_1.var_.characterEffect1066ui_story = var_526_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_11 = 0.200000002980232

			if var_526_10 <= arg_523_1.time_ and arg_523_1.time_ < var_526_10 + var_526_11 then
				local var_526_12 = (arg_523_1.time_ - var_526_10) / var_526_11

				if arg_523_1.var_.characterEffect1066ui_story then
					arg_523_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= var_526_10 + var_526_11 and arg_523_1.time_ < var_526_10 + var_526_11 + arg_526_0 and arg_523_1.var_.characterEffect1066ui_story then
				arg_523_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_526_13 = 0

			if var_526_13 < arg_523_1.time_ and arg_523_1.time_ <= var_526_13 + arg_526_0 then
				arg_523_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_526_14 = 0

			if var_526_14 < arg_523_1.time_ and arg_523_1.time_ <= var_526_14 + arg_526_0 then
				arg_523_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_526_15 = 0
			local var_526_16 = 0.375

			if var_526_15 < arg_523_1.time_ and arg_523_1.time_ <= var_526_15 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_17 = arg_523_1:FormatText(StoryNameCfg[32].name)

				arg_523_1.leftNameTxt_.text = var_526_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_18 = arg_523_1:GetWordFromCfg(1106605132)
				local var_526_19 = arg_523_1:FormatText(var_526_18.content)

				arg_523_1.text_.text = var_526_19

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_20 = 15
				local var_526_21 = utf8.len(var_526_19)
				local var_526_22 = var_526_20 <= 0 and var_526_16 or var_526_16 * (var_526_21 / var_526_20)

				if var_526_22 > 0 and var_526_16 < var_526_22 then
					arg_523_1.talkMaxDuration = var_526_22

					if var_526_22 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_22 + var_526_15
					end
				end

				arg_523_1.text_.text = var_526_19
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605132", "story_v_side_new_1106605.awb") ~= 0 then
					local var_526_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605132", "story_v_side_new_1106605.awb") / 1000

					if var_526_23 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_23 + var_526_15
					end

					if var_526_18.prefab_name ~= "" and arg_523_1.actors_[var_526_18.prefab_name] ~= nil then
						local var_526_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_18.prefab_name].transform, "story_v_side_new_1106605", "1106605132", "story_v_side_new_1106605.awb")

						arg_523_1:RecordAudio("1106605132", var_526_24)
						arg_523_1:RecordAudio("1106605132", var_526_24)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605132", "story_v_side_new_1106605.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605132", "story_v_side_new_1106605.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_25 = math.max(var_526_16, arg_523_1.talkMaxDuration)

			if var_526_15 <= arg_523_1.time_ and arg_523_1.time_ < var_526_15 + var_526_25 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_15) / var_526_25

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_15 + var_526_25 and arg_523_1.time_ < var_526_15 + var_526_25 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605133 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1106605133
		arg_527_1.duration_ = 0.999999999999

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"

			SetActive(arg_527_1.choicesGo_, true)

			for iter_528_0, iter_528_1 in ipairs(arg_527_1.choices_) do
				local var_528_0 = iter_528_0 <= 1

				SetActive(iter_528_1.go, var_528_0)
			end

			arg_527_1.choices_[1].txt.text = arg_527_1:FormatText(StoryChoiceCfg[552].name)
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1106605134(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1066ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and arg_527_1.var_.characterEffect1066ui_story == nil then
				arg_527_1.var_.characterEffect1066ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1066ui_story then
					local var_530_4 = Mathf.Lerp(0, 0.5, var_530_3)

					arg_527_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1066ui_story.fillRatio = var_530_4
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and arg_527_1.var_.characterEffect1066ui_story then
				local var_530_5 = 0.5

				arg_527_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1066ui_story.fillRatio = var_530_5
			end

			local var_530_6 = 0

			if var_530_6 < arg_527_1.time_ and arg_527_1.time_ <= var_530_6 + arg_530_0 then
				arg_527_1.allBtn_.enabled = false
			end

			local var_530_7 = 0.5

			if arg_527_1.time_ >= var_530_6 + var_530_7 and arg_527_1.time_ < var_530_6 + var_530_7 + arg_530_0 then
				arg_527_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605134 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1106605134
		arg_531_1.duration_ = 2.466

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1106605135(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1066ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1066ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, -0.77, -6.1)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1066ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = arg_531_1.actors_["1066ui_story"]
			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 and arg_531_1.var_.characterEffect1066ui_story == nil then
				arg_531_1.var_.characterEffect1066ui_story = var_534_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_11 = 0.200000002980232

			if var_534_10 <= arg_531_1.time_ and arg_531_1.time_ < var_534_10 + var_534_11 then
				local var_534_12 = (arg_531_1.time_ - var_534_10) / var_534_11

				if arg_531_1.var_.characterEffect1066ui_story then
					arg_531_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_10 + var_534_11 and arg_531_1.time_ < var_534_10 + var_534_11 + arg_534_0 and arg_531_1.var_.characterEffect1066ui_story then
				arg_531_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_534_13 = 0

			if var_534_13 < arg_531_1.time_ and arg_531_1.time_ <= var_534_13 + arg_534_0 then
				arg_531_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action457")
			end

			local var_534_14 = 0

			if var_534_14 < arg_531_1.time_ and arg_531_1.time_ <= var_534_14 + arg_534_0 then
				arg_531_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_534_15 = 0
			local var_534_16 = 0.225

			if var_534_15 < arg_531_1.time_ and arg_531_1.time_ <= var_534_15 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_17 = arg_531_1:FormatText(StoryNameCfg[32].name)

				arg_531_1.leftNameTxt_.text = var_534_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_18 = arg_531_1:GetWordFromCfg(1106605134)
				local var_534_19 = arg_531_1:FormatText(var_534_18.content)

				arg_531_1.text_.text = var_534_19

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_20 = 9
				local var_534_21 = utf8.len(var_534_19)
				local var_534_22 = var_534_20 <= 0 and var_534_16 or var_534_16 * (var_534_21 / var_534_20)

				if var_534_22 > 0 and var_534_16 < var_534_22 then
					arg_531_1.talkMaxDuration = var_534_22

					if var_534_22 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_22 + var_534_15
					end
				end

				arg_531_1.text_.text = var_534_19
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605134", "story_v_side_new_1106605.awb") ~= 0 then
					local var_534_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605134", "story_v_side_new_1106605.awb") / 1000

					if var_534_23 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_23 + var_534_15
					end

					if var_534_18.prefab_name ~= "" and arg_531_1.actors_[var_534_18.prefab_name] ~= nil then
						local var_534_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_18.prefab_name].transform, "story_v_side_new_1106605", "1106605134", "story_v_side_new_1106605.awb")

						arg_531_1:RecordAudio("1106605134", var_534_24)
						arg_531_1:RecordAudio("1106605134", var_534_24)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605134", "story_v_side_new_1106605.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605134", "story_v_side_new_1106605.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_25 = math.max(var_534_16, arg_531_1.talkMaxDuration)

			if var_534_15 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_25 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_15) / var_534_25

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_15 + var_534_25 and arg_531_1.time_ < var_534_15 + var_534_25 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605135 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1106605135
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1106605136(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1066ui_story"]
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 and arg_535_1.var_.characterEffect1066ui_story == nil then
				arg_535_1.var_.characterEffect1066ui_story = var_538_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_2 = 0.200000002980232

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2

				if arg_535_1.var_.characterEffect1066ui_story then
					local var_538_4 = Mathf.Lerp(0, 0.5, var_538_3)

					arg_535_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1066ui_story.fillRatio = var_538_4
				end
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 and arg_535_1.var_.characterEffect1066ui_story then
				local var_538_5 = 0.5

				arg_535_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1066ui_story.fillRatio = var_538_5
			end

			local var_538_6 = 0
			local var_538_7 = 0.6

			if var_538_6 < arg_535_1.time_ and arg_535_1.time_ <= var_538_6 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_8 = arg_535_1:GetWordFromCfg(1106605135)
				local var_538_9 = arg_535_1:FormatText(var_538_8.content)

				arg_535_1.text_.text = var_538_9

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_10 = 24
				local var_538_11 = utf8.len(var_538_9)
				local var_538_12 = var_538_10 <= 0 and var_538_7 or var_538_7 * (var_538_11 / var_538_10)

				if var_538_12 > 0 and var_538_7 < var_538_12 then
					arg_535_1.talkMaxDuration = var_538_12

					if var_538_12 + var_538_6 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_12 + var_538_6
					end
				end

				arg_535_1.text_.text = var_538_9
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_13 = math.max(var_538_7, arg_535_1.talkMaxDuration)

			if var_538_6 <= arg_535_1.time_ and arg_535_1.time_ < var_538_6 + var_538_13 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_6) / var_538_13

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_6 + var_538_13 and arg_535_1.time_ < var_538_6 + var_538_13 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605136 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1106605136
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1106605137(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.65

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_2 = arg_539_1:GetWordFromCfg(1106605136)
				local var_542_3 = arg_539_1:FormatText(var_542_2.content)

				arg_539_1.text_.text = var_542_3

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 26
				local var_542_5 = utf8.len(var_542_3)
				local var_542_6 = var_542_4 <= 0 and var_542_1 or var_542_1 * (var_542_5 / var_542_4)

				if var_542_6 > 0 and var_542_1 < var_542_6 then
					arg_539_1.talkMaxDuration = var_542_6

					if var_542_6 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_6 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_3
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_7 and arg_539_1.time_ < var_542_0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605137 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1106605137
		arg_543_1.duration_ = 1.999999999999

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1106605138(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1066ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos1066ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -0.77, -6.1)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1066ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["1066ui_story"]
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 and arg_543_1.var_.characterEffect1066ui_story == nil then
				arg_543_1.var_.characterEffect1066ui_story = var_546_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_11 = 0.200000002980232

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11

				if arg_543_1.var_.characterEffect1066ui_story then
					arg_543_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 and arg_543_1.var_.characterEffect1066ui_story then
				arg_543_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_546_13 = 0

			if var_546_13 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action7_2")
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_15 = 0
			local var_546_16 = 0.175

			if var_546_15 < arg_543_1.time_ and arg_543_1.time_ <= var_546_15 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_17 = arg_543_1:FormatText(StoryNameCfg[32].name)

				arg_543_1.leftNameTxt_.text = var_546_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_18 = arg_543_1:GetWordFromCfg(1106605137)
				local var_546_19 = arg_543_1:FormatText(var_546_18.content)

				arg_543_1.text_.text = var_546_19

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_20 = 7
				local var_546_21 = utf8.len(var_546_19)
				local var_546_22 = var_546_20 <= 0 and var_546_16 or var_546_16 * (var_546_21 / var_546_20)

				if var_546_22 > 0 and var_546_16 < var_546_22 then
					arg_543_1.talkMaxDuration = var_546_22

					if var_546_22 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_15
					end
				end

				arg_543_1.text_.text = var_546_19
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605137", "story_v_side_new_1106605.awb") ~= 0 then
					local var_546_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605137", "story_v_side_new_1106605.awb") / 1000

					if var_546_23 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_23 + var_546_15
					end

					if var_546_18.prefab_name ~= "" and arg_543_1.actors_[var_546_18.prefab_name] ~= nil then
						local var_546_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_18.prefab_name].transform, "story_v_side_new_1106605", "1106605137", "story_v_side_new_1106605.awb")

						arg_543_1:RecordAudio("1106605137", var_546_24)
						arg_543_1:RecordAudio("1106605137", var_546_24)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605137", "story_v_side_new_1106605.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605137", "story_v_side_new_1106605.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_25 = math.max(var_546_16, arg_543_1.talkMaxDuration)

			if var_546_15 <= arg_543_1.time_ and arg_543_1.time_ < var_546_15 + var_546_25 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_15) / var_546_25

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_15 + var_546_25 and arg_543_1.time_ < var_546_15 + var_546_25 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605138 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1106605138
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1106605139(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1066ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and arg_547_1.var_.characterEffect1066ui_story == nil then
				arg_547_1.var_.characterEffect1066ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect1066ui_story then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1066ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and arg_547_1.var_.characterEffect1066ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1066ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 0.425

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_8 = arg_547_1:FormatText(StoryNameCfg[7].name)

				arg_547_1.leftNameTxt_.text = var_550_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_9 = arg_547_1:GetWordFromCfg(1106605138)
				local var_550_10 = arg_547_1:FormatText(var_550_9.content)

				arg_547_1.text_.text = var_550_10

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_11 = 19
				local var_550_12 = utf8.len(var_550_10)
				local var_550_13 = var_550_11 <= 0 and var_550_7 or var_550_7 * (var_550_12 / var_550_11)

				if var_550_13 > 0 and var_550_7 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_10
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_14 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_14 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_14

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_14 and arg_547_1.time_ < var_550_6 + var_550_14 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605139 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1106605139
		arg_551_1.duration_ = 8.933

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1106605140(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1066ui_story"].transform
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.var_.moveOldPos1066ui_story = var_554_0.localPosition
			end

			local var_554_2 = 0.001

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2
				local var_554_4 = Vector3.New(0, -0.77, -6.1)

				var_554_0.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1066ui_story, var_554_4, var_554_3)

				local var_554_5 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_5.x, var_554_5.y, var_554_5.z)

				local var_554_6 = var_554_0.localEulerAngles

				var_554_6.z = 0
				var_554_6.x = 0
				var_554_0.localEulerAngles = var_554_6
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 then
				var_554_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_554_7 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_7.x, var_554_7.y, var_554_7.z)

				local var_554_8 = var_554_0.localEulerAngles

				var_554_8.z = 0
				var_554_8.x = 0
				var_554_0.localEulerAngles = var_554_8
			end

			local var_554_9 = arg_551_1.actors_["1066ui_story"]
			local var_554_10 = 0

			if var_554_10 < arg_551_1.time_ and arg_551_1.time_ <= var_554_10 + arg_554_0 and arg_551_1.var_.characterEffect1066ui_story == nil then
				arg_551_1.var_.characterEffect1066ui_story = var_554_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_11 = 0.200000002980232

			if var_554_10 <= arg_551_1.time_ and arg_551_1.time_ < var_554_10 + var_554_11 then
				local var_554_12 = (arg_551_1.time_ - var_554_10) / var_554_11

				if arg_551_1.var_.characterEffect1066ui_story then
					arg_551_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= var_554_10 + var_554_11 and arg_551_1.time_ < var_554_10 + var_554_11 + arg_554_0 and arg_551_1.var_.characterEffect1066ui_story then
				arg_551_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_554_13 = 0

			if var_554_13 < arg_551_1.time_ and arg_551_1.time_ <= var_554_13 + arg_554_0 then
				arg_551_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action9_1")
			end

			local var_554_14 = 0

			if var_554_14 < arg_551_1.time_ and arg_551_1.time_ <= var_554_14 + arg_554_0 then
				arg_551_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_554_15 = 0
			local var_554_16 = 1.2

			if var_554_15 < arg_551_1.time_ and arg_551_1.time_ <= var_554_15 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_17 = arg_551_1:FormatText(StoryNameCfg[32].name)

				arg_551_1.leftNameTxt_.text = var_554_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_18 = arg_551_1:GetWordFromCfg(1106605139)
				local var_554_19 = arg_551_1:FormatText(var_554_18.content)

				arg_551_1.text_.text = var_554_19

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_20 = 48
				local var_554_21 = utf8.len(var_554_19)
				local var_554_22 = var_554_20 <= 0 and var_554_16 or var_554_16 * (var_554_21 / var_554_20)

				if var_554_22 > 0 and var_554_16 < var_554_22 then
					arg_551_1.talkMaxDuration = var_554_22

					if var_554_22 + var_554_15 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_22 + var_554_15
					end
				end

				arg_551_1.text_.text = var_554_19
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605139", "story_v_side_new_1106605.awb") ~= 0 then
					local var_554_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605139", "story_v_side_new_1106605.awb") / 1000

					if var_554_23 + var_554_15 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_23 + var_554_15
					end

					if var_554_18.prefab_name ~= "" and arg_551_1.actors_[var_554_18.prefab_name] ~= nil then
						local var_554_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_18.prefab_name].transform, "story_v_side_new_1106605", "1106605139", "story_v_side_new_1106605.awb")

						arg_551_1:RecordAudio("1106605139", var_554_24)
						arg_551_1:RecordAudio("1106605139", var_554_24)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605139", "story_v_side_new_1106605.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605139", "story_v_side_new_1106605.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_25 = math.max(var_554_16, arg_551_1.talkMaxDuration)

			if var_554_15 <= arg_551_1.time_ and arg_551_1.time_ < var_554_15 + var_554_25 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_15) / var_554_25

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_15 + var_554_25 and arg_551_1.time_ < var_554_15 + var_554_25 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605140 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1106605140
		arg_555_1.duration_ = 9

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1106605141(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = "ST17"

			if arg_555_1.bgs_[var_558_0] == nil then
				local var_558_1 = Object.Instantiate(arg_555_1.paintGo_)

				var_558_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_558_0)
				var_558_1.name = var_558_0
				var_558_1.transform.parent = arg_555_1.stage_.transform
				var_558_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.bgs_[var_558_0] = var_558_1
			end

			local var_558_2 = 2

			if var_558_2 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				local var_558_3 = manager.ui.mainCamera.transform.localPosition
				local var_558_4 = Vector3.New(0, 0, 10) + Vector3.New(var_558_3.x, var_558_3.y, 0)
				local var_558_5 = arg_555_1.bgs_.ST17

				var_558_5.transform.localPosition = var_558_4
				var_558_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_558_6 = var_558_5:GetComponent("SpriteRenderer")

				if var_558_6 and var_558_6.sprite then
					local var_558_7 = (var_558_5.transform.localPosition - var_558_3).z
					local var_558_8 = manager.ui.mainCameraCom_
					local var_558_9 = 2 * var_558_7 * Mathf.Tan(var_558_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_558_10 = var_558_9 * var_558_8.aspect
					local var_558_11 = var_558_6.sprite.bounds.size.x
					local var_558_12 = var_558_6.sprite.bounds.size.y
					local var_558_13 = var_558_10 / var_558_11
					local var_558_14 = var_558_9 / var_558_12
					local var_558_15 = var_558_14 < var_558_13 and var_558_13 or var_558_14

					var_558_5.transform.localScale = Vector3.New(var_558_15, var_558_15, 0)
				end

				for iter_558_0, iter_558_1 in pairs(arg_555_1.bgs_) do
					if iter_558_0 ~= "ST17" then
						iter_558_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_558_16 = 0

			if var_558_16 < arg_555_1.time_ and arg_555_1.time_ <= var_558_16 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_17 = 2

			if var_558_16 <= arg_555_1.time_ and arg_555_1.time_ < var_558_16 + var_558_17 then
				local var_558_18 = (arg_555_1.time_ - var_558_16) / var_558_17
				local var_558_19 = Color.New(0, 0, 0)

				var_558_19.a = Mathf.Lerp(0, 1, var_558_18)
				arg_555_1.mask_.color = var_558_19
			end

			if arg_555_1.time_ >= var_558_16 + var_558_17 and arg_555_1.time_ < var_558_16 + var_558_17 + arg_558_0 then
				local var_558_20 = Color.New(0, 0, 0)

				var_558_20.a = 1
				arg_555_1.mask_.color = var_558_20
			end

			local var_558_21 = 2

			if var_558_21 < arg_555_1.time_ and arg_555_1.time_ <= var_558_21 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_22 = 2

			if var_558_21 <= arg_555_1.time_ and arg_555_1.time_ < var_558_21 + var_558_22 then
				local var_558_23 = (arg_555_1.time_ - var_558_21) / var_558_22
				local var_558_24 = Color.New(0, 0, 0)

				var_558_24.a = Mathf.Lerp(1, 0, var_558_23)
				arg_555_1.mask_.color = var_558_24
			end

			if arg_555_1.time_ >= var_558_21 + var_558_22 and arg_555_1.time_ < var_558_21 + var_558_22 + arg_558_0 then
				local var_558_25 = Color.New(0, 0, 0)
				local var_558_26 = 0

				arg_555_1.mask_.enabled = false
				var_558_25.a = var_558_26
				arg_555_1.mask_.color = var_558_25
			end

			local var_558_27 = arg_555_1.actors_["1066ui_story"].transform
			local var_558_28 = 0

			if var_558_28 < arg_555_1.time_ and arg_555_1.time_ <= var_558_28 + arg_558_0 then
				arg_555_1.var_.moveOldPos1066ui_story = var_558_27.localPosition
			end

			local var_558_29 = 0.001

			if var_558_28 <= arg_555_1.time_ and arg_555_1.time_ < var_558_28 + var_558_29 then
				local var_558_30 = (arg_555_1.time_ - var_558_28) / var_558_29
				local var_558_31 = Vector3.New(0, 100, 0)

				var_558_27.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1066ui_story, var_558_31, var_558_30)

				local var_558_32 = manager.ui.mainCamera.transform.position - var_558_27.position

				var_558_27.forward = Vector3.New(var_558_32.x, var_558_32.y, var_558_32.z)

				local var_558_33 = var_558_27.localEulerAngles

				var_558_33.z = 0
				var_558_33.x = 0
				var_558_27.localEulerAngles = var_558_33
			end

			if arg_555_1.time_ >= var_558_28 + var_558_29 and arg_555_1.time_ < var_558_28 + var_558_29 + arg_558_0 then
				var_558_27.localPosition = Vector3.New(0, 100, 0)

				local var_558_34 = manager.ui.mainCamera.transform.position - var_558_27.position

				var_558_27.forward = Vector3.New(var_558_34.x, var_558_34.y, var_558_34.z)

				local var_558_35 = var_558_27.localEulerAngles

				var_558_35.z = 0
				var_558_35.x = 0
				var_558_27.localEulerAngles = var_558_35
			end

			local var_558_36 = 0
			local var_558_37 = 0.533333333333333

			if var_558_36 < arg_555_1.time_ and arg_555_1.time_ <= var_558_36 + arg_558_0 then
				local var_558_38 = "play"
				local var_558_39 = "effect"

				arg_555_1:AudioAction(var_558_38, var_558_39, "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end

			if arg_555_1.frameCnt_ <= 1 then
				arg_555_1.dialog_:SetActive(false)
			end

			local var_558_40 = 4
			local var_558_41 = 0.625

			if var_558_40 < arg_555_1.time_ and arg_555_1.time_ <= var_558_40 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0

				arg_555_1.dialog_:SetActive(true)

				local var_558_42 = LeanTween.value(arg_555_1.dialog_, 0, 1, 0.3)

				var_558_42:setOnUpdate(LuaHelper.FloatAction(function(arg_559_0)
					arg_555_1.dialogCg_.alpha = arg_559_0
				end))
				var_558_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_555_1.dialog_)
					var_558_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_555_1.duration_ = arg_555_1.duration_ + 0.3

				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_43 = arg_555_1:GetWordFromCfg(1106605140)
				local var_558_44 = arg_555_1:FormatText(var_558_43.content)

				arg_555_1.text_.text = var_558_44

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_45 = 25
				local var_558_46 = utf8.len(var_558_44)
				local var_558_47 = var_558_45 <= 0 and var_558_41 or var_558_41 * (var_558_46 / var_558_45)

				if var_558_47 > 0 and var_558_41 < var_558_47 then
					arg_555_1.talkMaxDuration = var_558_47
					var_558_40 = var_558_40 + 0.3

					if var_558_47 + var_558_40 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_47 + var_558_40
					end
				end

				arg_555_1.text_.text = var_558_44
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_48 = var_558_40 + 0.3
			local var_558_49 = math.max(var_558_41, arg_555_1.talkMaxDuration)

			if var_558_48 <= arg_555_1.time_ and arg_555_1.time_ < var_558_48 + var_558_49 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_48) / var_558_49

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_48 + var_558_49 and arg_555_1.time_ < var_558_48 + var_558_49 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605141 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1106605141
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1106605142(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 1.275

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, false)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_2 = arg_561_1:GetWordFromCfg(1106605141)
				local var_564_3 = arg_561_1:FormatText(var_564_2.content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 51
				local var_564_5 = utf8.len(var_564_3)
				local var_564_6 = var_564_4 <= 0 and var_564_1 or var_564_1 * (var_564_5 / var_564_4)

				if var_564_6 > 0 and var_564_1 < var_564_6 then
					arg_561_1.talkMaxDuration = var_564_6

					if var_564_6 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_6 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_7 and arg_561_1.time_ < var_564_0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605142 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1106605142
		arg_565_1.duration_ = 5.1

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1106605143(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1066ui_story"].transform
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.var_.moveOldPos1066ui_story = var_568_0.localPosition
			end

			local var_568_2 = 0.001

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2
				local var_568_4 = Vector3.New(0, -0.77, -6.1)

				var_568_0.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1066ui_story, var_568_4, var_568_3)

				local var_568_5 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_5.x, var_568_5.y, var_568_5.z)

				local var_568_6 = var_568_0.localEulerAngles

				var_568_6.z = 0
				var_568_6.x = 0
				var_568_0.localEulerAngles = var_568_6
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 then
				var_568_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_568_7 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_7.x, var_568_7.y, var_568_7.z)

				local var_568_8 = var_568_0.localEulerAngles

				var_568_8.z = 0
				var_568_8.x = 0
				var_568_0.localEulerAngles = var_568_8
			end

			local var_568_9 = arg_565_1.actors_["1066ui_story"]
			local var_568_10 = 0

			if var_568_10 < arg_565_1.time_ and arg_565_1.time_ <= var_568_10 + arg_568_0 and arg_565_1.var_.characterEffect1066ui_story == nil then
				arg_565_1.var_.characterEffect1066ui_story = var_568_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_11 = 0.200000002980232

			if var_568_10 <= arg_565_1.time_ and arg_565_1.time_ < var_568_10 + var_568_11 then
				local var_568_12 = (arg_565_1.time_ - var_568_10) / var_568_11

				if arg_565_1.var_.characterEffect1066ui_story then
					arg_565_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_10 + var_568_11 and arg_565_1.time_ < var_568_10 + var_568_11 + arg_568_0 and arg_565_1.var_.characterEffect1066ui_story then
				arg_565_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_568_13 = 0

			if var_568_13 < arg_565_1.time_ and arg_565_1.time_ <= var_568_13 + arg_568_0 then
				arg_565_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			local var_568_14 = 0

			if var_568_14 < arg_565_1.time_ and arg_565_1.time_ <= var_568_14 + arg_568_0 then
				arg_565_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_568_15 = 0
			local var_568_16 = 0.65

			if var_568_15 < arg_565_1.time_ and arg_565_1.time_ <= var_568_15 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_17 = arg_565_1:FormatText(StoryNameCfg[32].name)

				arg_565_1.leftNameTxt_.text = var_568_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_18 = arg_565_1:GetWordFromCfg(1106605142)
				local var_568_19 = arg_565_1:FormatText(var_568_18.content)

				arg_565_1.text_.text = var_568_19

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_20 = 26
				local var_568_21 = utf8.len(var_568_19)
				local var_568_22 = var_568_20 <= 0 and var_568_16 or var_568_16 * (var_568_21 / var_568_20)

				if var_568_22 > 0 and var_568_16 < var_568_22 then
					arg_565_1.talkMaxDuration = var_568_22

					if var_568_22 + var_568_15 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_22 + var_568_15
					end
				end

				arg_565_1.text_.text = var_568_19
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605142", "story_v_side_new_1106605.awb") ~= 0 then
					local var_568_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605142", "story_v_side_new_1106605.awb") / 1000

					if var_568_23 + var_568_15 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_23 + var_568_15
					end

					if var_568_18.prefab_name ~= "" and arg_565_1.actors_[var_568_18.prefab_name] ~= nil then
						local var_568_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_18.prefab_name].transform, "story_v_side_new_1106605", "1106605142", "story_v_side_new_1106605.awb")

						arg_565_1:RecordAudio("1106605142", var_568_24)
						arg_565_1:RecordAudio("1106605142", var_568_24)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605142", "story_v_side_new_1106605.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605142", "story_v_side_new_1106605.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_25 = math.max(var_568_16, arg_565_1.talkMaxDuration)

			if var_568_15 <= arg_565_1.time_ and arg_565_1.time_ < var_568_15 + var_568_25 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_15) / var_568_25

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_15 + var_568_25 and arg_565_1.time_ < var_568_15 + var_568_25 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605143 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1106605143
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1106605144(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1066ui_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and arg_569_1.var_.characterEffect1066ui_story == nil then
				arg_569_1.var_.characterEffect1066ui_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect1066ui_story then
					local var_572_4 = Mathf.Lerp(0, 0.5, var_572_3)

					arg_569_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1066ui_story.fillRatio = var_572_4
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and arg_569_1.var_.characterEffect1066ui_story then
				local var_572_5 = 0.5

				arg_569_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1066ui_story.fillRatio = var_572_5
			end

			local var_572_6 = 0
			local var_572_7 = 0.775

			if var_572_6 < arg_569_1.time_ and arg_569_1.time_ <= var_572_6 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_8 = arg_569_1:FormatText(StoryNameCfg[7].name)

				arg_569_1.leftNameTxt_.text = var_572_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_9 = arg_569_1:GetWordFromCfg(1106605143)
				local var_572_10 = arg_569_1:FormatText(var_572_9.content)

				arg_569_1.text_.text = var_572_10

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_11 = 31
				local var_572_12 = utf8.len(var_572_10)
				local var_572_13 = var_572_11 <= 0 and var_572_7 or var_572_7 * (var_572_12 / var_572_11)

				if var_572_13 > 0 and var_572_7 < var_572_13 then
					arg_569_1.talkMaxDuration = var_572_13

					if var_572_13 + var_572_6 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_13 + var_572_6
					end
				end

				arg_569_1.text_.text = var_572_10
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_14 = math.max(var_572_7, arg_569_1.talkMaxDuration)

			if var_572_6 <= arg_569_1.time_ and arg_569_1.time_ < var_572_6 + var_572_14 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_6) / var_572_14

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_6 + var_572_14 and arg_569_1.time_ < var_572_6 + var_572_14 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605144 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1106605144
		arg_573_1.duration_ = 5.433

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1106605145(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["1066ui_story"].transform
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.var_.moveOldPos1066ui_story = var_576_0.localPosition
			end

			local var_576_2 = 0.001

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2
				local var_576_4 = Vector3.New(0, -0.77, -6.1)

				var_576_0.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1066ui_story, var_576_4, var_576_3)

				local var_576_5 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_5.x, var_576_5.y, var_576_5.z)

				local var_576_6 = var_576_0.localEulerAngles

				var_576_6.z = 0
				var_576_6.x = 0
				var_576_0.localEulerAngles = var_576_6
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 then
				var_576_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_576_7 = manager.ui.mainCamera.transform.position - var_576_0.position

				var_576_0.forward = Vector3.New(var_576_7.x, var_576_7.y, var_576_7.z)

				local var_576_8 = var_576_0.localEulerAngles

				var_576_8.z = 0
				var_576_8.x = 0
				var_576_0.localEulerAngles = var_576_8
			end

			local var_576_9 = arg_573_1.actors_["1066ui_story"]
			local var_576_10 = 0

			if var_576_10 < arg_573_1.time_ and arg_573_1.time_ <= var_576_10 + arg_576_0 and arg_573_1.var_.characterEffect1066ui_story == nil then
				arg_573_1.var_.characterEffect1066ui_story = var_576_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_11 = 0.200000002980232

			if var_576_10 <= arg_573_1.time_ and arg_573_1.time_ < var_576_10 + var_576_11 then
				local var_576_12 = (arg_573_1.time_ - var_576_10) / var_576_11

				if arg_573_1.var_.characterEffect1066ui_story then
					arg_573_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_10 + var_576_11 and arg_573_1.time_ < var_576_10 + var_576_11 + arg_576_0 and arg_573_1.var_.characterEffect1066ui_story then
				arg_573_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_576_13 = 0

			if var_576_13 < arg_573_1.time_ and arg_573_1.time_ <= var_576_13 + arg_576_0 then
				arg_573_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action443")
			end

			local var_576_14 = 0

			if var_576_14 < arg_573_1.time_ and arg_573_1.time_ <= var_576_14 + arg_576_0 then
				arg_573_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_576_15 = 0
			local var_576_16 = 0.625

			if var_576_15 < arg_573_1.time_ and arg_573_1.time_ <= var_576_15 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_17 = arg_573_1:FormatText(StoryNameCfg[32].name)

				arg_573_1.leftNameTxt_.text = var_576_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_18 = arg_573_1:GetWordFromCfg(1106605144)
				local var_576_19 = arg_573_1:FormatText(var_576_18.content)

				arg_573_1.text_.text = var_576_19

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_20 = 25
				local var_576_21 = utf8.len(var_576_19)
				local var_576_22 = var_576_20 <= 0 and var_576_16 or var_576_16 * (var_576_21 / var_576_20)

				if var_576_22 > 0 and var_576_16 < var_576_22 then
					arg_573_1.talkMaxDuration = var_576_22

					if var_576_22 + var_576_15 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_22 + var_576_15
					end
				end

				arg_573_1.text_.text = var_576_19
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605144", "story_v_side_new_1106605.awb") ~= 0 then
					local var_576_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605144", "story_v_side_new_1106605.awb") / 1000

					if var_576_23 + var_576_15 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_23 + var_576_15
					end

					if var_576_18.prefab_name ~= "" and arg_573_1.actors_[var_576_18.prefab_name] ~= nil then
						local var_576_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_18.prefab_name].transform, "story_v_side_new_1106605", "1106605144", "story_v_side_new_1106605.awb")

						arg_573_1:RecordAudio("1106605144", var_576_24)
						arg_573_1:RecordAudio("1106605144", var_576_24)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605144", "story_v_side_new_1106605.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605144", "story_v_side_new_1106605.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_25 = math.max(var_576_16, arg_573_1.talkMaxDuration)

			if var_576_15 <= arg_573_1.time_ and arg_573_1.time_ < var_576_15 + var_576_25 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_15) / var_576_25

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_15 + var_576_25 and arg_573_1.time_ < var_576_15 + var_576_25 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605145 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1106605145
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1106605146(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1066ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and arg_577_1.var_.characterEffect1066ui_story == nil then
				arg_577_1.var_.characterEffect1066ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.200000002980232

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect1066ui_story then
					local var_580_4 = Mathf.Lerp(0, 0.5, var_580_3)

					arg_577_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1066ui_story.fillRatio = var_580_4
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and arg_577_1.var_.characterEffect1066ui_story then
				local var_580_5 = 0.5

				arg_577_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1066ui_story.fillRatio = var_580_5
			end

			local var_580_6 = 0
			local var_580_7 = 0.875

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_8 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_9 = arg_577_1:GetWordFromCfg(1106605145)
				local var_580_10 = arg_577_1:FormatText(var_580_9.content)

				arg_577_1.text_.text = var_580_10

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 35
				local var_580_12 = utf8.len(var_580_10)
				local var_580_13 = var_580_11 <= 0 and var_580_7 or var_580_7 * (var_580_12 / var_580_11)

				if var_580_13 > 0 and var_580_7 < var_580_13 then
					arg_577_1.talkMaxDuration = var_580_13

					if var_580_13 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_13 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_10
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_14 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_14 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_14

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_14 and arg_577_1.time_ < var_580_6 + var_580_14 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605146 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1106605146
		arg_581_1.duration_ = 2.066

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1106605147(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1066ui_story"].transform
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.var_.moveOldPos1066ui_story = var_584_0.localPosition
			end

			local var_584_2 = 0.001

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2
				local var_584_4 = Vector3.New(0, -0.77, -6.1)

				var_584_0.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1066ui_story, var_584_4, var_584_3)

				local var_584_5 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_5.x, var_584_5.y, var_584_5.z)

				local var_584_6 = var_584_0.localEulerAngles

				var_584_6.z = 0
				var_584_6.x = 0
				var_584_0.localEulerAngles = var_584_6
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 then
				var_584_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_584_7 = manager.ui.mainCamera.transform.position - var_584_0.position

				var_584_0.forward = Vector3.New(var_584_7.x, var_584_7.y, var_584_7.z)

				local var_584_8 = var_584_0.localEulerAngles

				var_584_8.z = 0
				var_584_8.x = 0
				var_584_0.localEulerAngles = var_584_8
			end

			local var_584_9 = arg_581_1.actors_["1066ui_story"]
			local var_584_10 = 0

			if var_584_10 < arg_581_1.time_ and arg_581_1.time_ <= var_584_10 + arg_584_0 and arg_581_1.var_.characterEffect1066ui_story == nil then
				arg_581_1.var_.characterEffect1066ui_story = var_584_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_11 = 0.200000002980232

			if var_584_10 <= arg_581_1.time_ and arg_581_1.time_ < var_584_10 + var_584_11 then
				local var_584_12 = (arg_581_1.time_ - var_584_10) / var_584_11

				if arg_581_1.var_.characterEffect1066ui_story then
					arg_581_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= var_584_10 + var_584_11 and arg_581_1.time_ < var_584_10 + var_584_11 + arg_584_0 and arg_581_1.var_.characterEffect1066ui_story then
				arg_581_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_584_13 = 0

			if var_584_13 < arg_581_1.time_ and arg_581_1.time_ <= var_584_13 + arg_584_0 then
				arg_581_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_2")
			end

			local var_584_14 = 0

			if var_584_14 < arg_581_1.time_ and arg_581_1.time_ <= var_584_14 + arg_584_0 then
				arg_581_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_584_15 = 0
			local var_584_16 = 0.075

			if var_584_15 < arg_581_1.time_ and arg_581_1.time_ <= var_584_15 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_17 = arg_581_1:FormatText(StoryNameCfg[32].name)

				arg_581_1.leftNameTxt_.text = var_584_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_18 = arg_581_1:GetWordFromCfg(1106605146)
				local var_584_19 = arg_581_1:FormatText(var_584_18.content)

				arg_581_1.text_.text = var_584_19

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_20 = 3
				local var_584_21 = utf8.len(var_584_19)
				local var_584_22 = var_584_20 <= 0 and var_584_16 or var_584_16 * (var_584_21 / var_584_20)

				if var_584_22 > 0 and var_584_16 < var_584_22 then
					arg_581_1.talkMaxDuration = var_584_22

					if var_584_22 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_22 + var_584_15
					end
				end

				arg_581_1.text_.text = var_584_19
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605146", "story_v_side_new_1106605.awb") ~= 0 then
					local var_584_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605146", "story_v_side_new_1106605.awb") / 1000

					if var_584_23 + var_584_15 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_23 + var_584_15
					end

					if var_584_18.prefab_name ~= "" and arg_581_1.actors_[var_584_18.prefab_name] ~= nil then
						local var_584_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_18.prefab_name].transform, "story_v_side_new_1106605", "1106605146", "story_v_side_new_1106605.awb")

						arg_581_1:RecordAudio("1106605146", var_584_24)
						arg_581_1:RecordAudio("1106605146", var_584_24)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605146", "story_v_side_new_1106605.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605146", "story_v_side_new_1106605.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_25 = math.max(var_584_16, arg_581_1.talkMaxDuration)

			if var_584_15 <= arg_581_1.time_ and arg_581_1.time_ < var_584_15 + var_584_25 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_15) / var_584_25

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_15 + var_584_25 and arg_581_1.time_ < var_584_15 + var_584_25 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605147 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1106605147
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1106605148(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["1066ui_story"]
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 and arg_585_1.var_.characterEffect1066ui_story == nil then
				arg_585_1.var_.characterEffect1066ui_story = var_588_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2

				if arg_585_1.var_.characterEffect1066ui_story then
					local var_588_4 = Mathf.Lerp(0, 0.5, var_588_3)

					arg_585_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1066ui_story.fillRatio = var_588_4
				end
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 and arg_585_1.var_.characterEffect1066ui_story then
				local var_588_5 = 0.5

				arg_585_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1066ui_story.fillRatio = var_588_5
			end

			local var_588_6 = 0
			local var_588_7 = 1.175

			if var_588_6 < arg_585_1.time_ and arg_585_1.time_ <= var_588_6 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_8 = arg_585_1:GetWordFromCfg(1106605147)
				local var_588_9 = arg_585_1:FormatText(var_588_8.content)

				arg_585_1.text_.text = var_588_9

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_10 = 47
				local var_588_11 = utf8.len(var_588_9)
				local var_588_12 = var_588_10 <= 0 and var_588_7 or var_588_7 * (var_588_11 / var_588_10)

				if var_588_12 > 0 and var_588_7 < var_588_12 then
					arg_585_1.talkMaxDuration = var_588_12

					if var_588_12 + var_588_6 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_12 + var_588_6
					end
				end

				arg_585_1.text_.text = var_588_9
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_13 = math.max(var_588_7, arg_585_1.talkMaxDuration)

			if var_588_6 <= arg_585_1.time_ and arg_585_1.time_ < var_588_6 + var_588_13 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_6) / var_588_13

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_6 + var_588_13 and arg_585_1.time_ < var_588_6 + var_588_13 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605148 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1106605148
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1106605149(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_592_1 = 0
			local var_592_2 = 1.025

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:GetWordFromCfg(1106605148)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 41
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_2 or var_592_2 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_2 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_8 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_8 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_8

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_8 and arg_589_1.time_ < var_592_1 + var_592_8 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605149 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1106605149
		arg_593_1.duration_ = 5.566

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1106605150(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.575

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[90].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_3 = arg_593_1:GetWordFromCfg(1106605149)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 23
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605149", "story_v_side_new_1106605.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605149", "story_v_side_new_1106605.awb") / 1000

					if var_596_8 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_0
					end

					if var_596_3.prefab_name ~= "" and arg_593_1.actors_[var_596_3.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_3.prefab_name].transform, "story_v_side_new_1106605", "1106605149", "story_v_side_new_1106605.awb")

						arg_593_1:RecordAudio("1106605149", var_596_9)
						arg_593_1:RecordAudio("1106605149", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605149", "story_v_side_new_1106605.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605149", "story_v_side_new_1106605.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_10 and arg_593_1.time_ < var_596_0 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605150 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1106605150
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1106605151(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0
			local var_600_1 = 1

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, false)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_2 = arg_597_1:GetWordFromCfg(1106605150)
				local var_600_3 = arg_597_1:FormatText(var_600_2.content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_4 = 40
				local var_600_5 = utf8.len(var_600_3)
				local var_600_6 = var_600_4 <= 0 and var_600_1 or var_600_1 * (var_600_5 / var_600_4)

				if var_600_6 > 0 and var_600_1 < var_600_6 then
					arg_597_1.talkMaxDuration = var_600_6

					if var_600_6 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_7 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_7 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_7

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_7 and arg_597_1.time_ < var_600_0 + var_600_7 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605151 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1106605151
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1106605152(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0
			local var_604_1 = 0.3

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_2 = arg_601_1:FormatText(StoryNameCfg[7].name)

				arg_601_1.leftNameTxt_.text = var_604_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:GetWordFromCfg(1106605151)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 12
				local var_604_6 = utf8.len(var_604_4)
				local var_604_7 = var_604_5 <= 0 and var_604_1 or var_604_1 * (var_604_6 / var_604_5)

				if var_604_7 > 0 and var_604_1 < var_604_7 then
					arg_601_1.talkMaxDuration = var_604_7

					if var_604_7 + var_604_0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_0
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_8 = math.max(var_604_1, arg_601_1.talkMaxDuration)

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_8 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_0) / var_604_8

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_0 + var_604_8 and arg_601_1.time_ < var_604_0 + var_604_8 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605152 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1106605152
		arg_605_1.duration_ = 3.2

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1106605153(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = arg_605_1.actors_["1066ui_story"].transform
			local var_608_1 = 0

			if var_608_1 < arg_605_1.time_ and arg_605_1.time_ <= var_608_1 + arg_608_0 then
				arg_605_1.var_.moveOldPos1066ui_story = var_608_0.localPosition
			end

			local var_608_2 = 0.001

			if var_608_1 <= arg_605_1.time_ and arg_605_1.time_ < var_608_1 + var_608_2 then
				local var_608_3 = (arg_605_1.time_ - var_608_1) / var_608_2
				local var_608_4 = Vector3.New(0, -0.77, -6.1)

				var_608_0.localPosition = Vector3.Lerp(arg_605_1.var_.moveOldPos1066ui_story, var_608_4, var_608_3)

				local var_608_5 = manager.ui.mainCamera.transform.position - var_608_0.position

				var_608_0.forward = Vector3.New(var_608_5.x, var_608_5.y, var_608_5.z)

				local var_608_6 = var_608_0.localEulerAngles

				var_608_6.z = 0
				var_608_6.x = 0
				var_608_0.localEulerAngles = var_608_6
			end

			if arg_605_1.time_ >= var_608_1 + var_608_2 and arg_605_1.time_ < var_608_1 + var_608_2 + arg_608_0 then
				var_608_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_608_7 = manager.ui.mainCamera.transform.position - var_608_0.position

				var_608_0.forward = Vector3.New(var_608_7.x, var_608_7.y, var_608_7.z)

				local var_608_8 = var_608_0.localEulerAngles

				var_608_8.z = 0
				var_608_8.x = 0
				var_608_0.localEulerAngles = var_608_8
			end

			local var_608_9 = arg_605_1.actors_["1066ui_story"]
			local var_608_10 = 0

			if var_608_10 < arg_605_1.time_ and arg_605_1.time_ <= var_608_10 + arg_608_0 and arg_605_1.var_.characterEffect1066ui_story == nil then
				arg_605_1.var_.characterEffect1066ui_story = var_608_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_11 = 0.200000002980232

			if var_608_10 <= arg_605_1.time_ and arg_605_1.time_ < var_608_10 + var_608_11 then
				local var_608_12 = (arg_605_1.time_ - var_608_10) / var_608_11

				if arg_605_1.var_.characterEffect1066ui_story then
					arg_605_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= var_608_10 + var_608_11 and arg_605_1.time_ < var_608_10 + var_608_11 + arg_608_0 and arg_605_1.var_.characterEffect1066ui_story then
				arg_605_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_608_13 = 0

			if var_608_13 < arg_605_1.time_ and arg_605_1.time_ <= var_608_13 + arg_608_0 then
				arg_605_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			local var_608_14 = 0

			if var_608_14 < arg_605_1.time_ and arg_605_1.time_ <= var_608_14 + arg_608_0 then
				arg_605_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_608_15 = 0
			local var_608_16 = 0.075

			if var_608_15 < arg_605_1.time_ and arg_605_1.time_ <= var_608_15 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_17 = arg_605_1:FormatText(StoryNameCfg[32].name)

				arg_605_1.leftNameTxt_.text = var_608_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_18 = arg_605_1:GetWordFromCfg(1106605152)
				local var_608_19 = arg_605_1:FormatText(var_608_18.content)

				arg_605_1.text_.text = var_608_19

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_20 = 3
				local var_608_21 = utf8.len(var_608_19)
				local var_608_22 = var_608_20 <= 0 and var_608_16 or var_608_16 * (var_608_21 / var_608_20)

				if var_608_22 > 0 and var_608_16 < var_608_22 then
					arg_605_1.talkMaxDuration = var_608_22

					if var_608_22 + var_608_15 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_22 + var_608_15
					end
				end

				arg_605_1.text_.text = var_608_19
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605152", "story_v_side_new_1106605.awb") ~= 0 then
					local var_608_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605152", "story_v_side_new_1106605.awb") / 1000

					if var_608_23 + var_608_15 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_23 + var_608_15
					end

					if var_608_18.prefab_name ~= "" and arg_605_1.actors_[var_608_18.prefab_name] ~= nil then
						local var_608_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_18.prefab_name].transform, "story_v_side_new_1106605", "1106605152", "story_v_side_new_1106605.awb")

						arg_605_1:RecordAudio("1106605152", var_608_24)
						arg_605_1:RecordAudio("1106605152", var_608_24)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605152", "story_v_side_new_1106605.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605152", "story_v_side_new_1106605.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_25 = math.max(var_608_16, arg_605_1.talkMaxDuration)

			if var_608_15 <= arg_605_1.time_ and arg_605_1.time_ < var_608_15 + var_608_25 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_15) / var_608_25

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_15 + var_608_25 and arg_605_1.time_ < var_608_15 + var_608_25 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605153 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1106605153
		arg_609_1.duration_ = 3.466

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1106605154(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = arg_609_1.actors_["1066ui_story"]
			local var_612_1 = 0

			if var_612_1 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 and arg_609_1.var_.characterEffect1066ui_story == nil then
				arg_609_1.var_.characterEffect1066ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_2 = 0.200000002980232

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_2 then
				local var_612_3 = (arg_609_1.time_ - var_612_1) / var_612_2

				if arg_609_1.var_.characterEffect1066ui_story then
					local var_612_4 = Mathf.Lerp(0, 0.5, var_612_3)

					arg_609_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1066ui_story.fillRatio = var_612_4
				end
			end

			if arg_609_1.time_ >= var_612_1 + var_612_2 and arg_609_1.time_ < var_612_1 + var_612_2 + arg_612_0 and arg_609_1.var_.characterEffect1066ui_story then
				local var_612_5 = 0.5

				arg_609_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1066ui_story.fillRatio = var_612_5
			end

			local var_612_6 = 0
			local var_612_7 = 0.325

			if var_612_6 < arg_609_1.time_ and arg_609_1.time_ <= var_612_6 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_8 = arg_609_1:FormatText(StoryNameCfg[90].name)

				arg_609_1.leftNameTxt_.text = var_612_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_9 = arg_609_1:GetWordFromCfg(1106605153)
				local var_612_10 = arg_609_1:FormatText(var_612_9.content)

				arg_609_1.text_.text = var_612_10

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_11 = 13
				local var_612_12 = utf8.len(var_612_10)
				local var_612_13 = var_612_11 <= 0 and var_612_7 or var_612_7 * (var_612_12 / var_612_11)

				if var_612_13 > 0 and var_612_7 < var_612_13 then
					arg_609_1.talkMaxDuration = var_612_13

					if var_612_13 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_13 + var_612_6
					end
				end

				arg_609_1.text_.text = var_612_10
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605153", "story_v_side_new_1106605.awb") ~= 0 then
					local var_612_14 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605153", "story_v_side_new_1106605.awb") / 1000

					if var_612_14 + var_612_6 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_14 + var_612_6
					end

					if var_612_9.prefab_name ~= "" and arg_609_1.actors_[var_612_9.prefab_name] ~= nil then
						local var_612_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_9.prefab_name].transform, "story_v_side_new_1106605", "1106605153", "story_v_side_new_1106605.awb")

						arg_609_1:RecordAudio("1106605153", var_612_15)
						arg_609_1:RecordAudio("1106605153", var_612_15)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605153", "story_v_side_new_1106605.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605153", "story_v_side_new_1106605.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_16 = math.max(var_612_7, arg_609_1.talkMaxDuration)

			if var_612_6 <= arg_609_1.time_ and arg_609_1.time_ < var_612_6 + var_612_16 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_6) / var_612_16

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_6 + var_612_16 and arg_609_1.time_ < var_612_6 + var_612_16 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605154 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1106605154
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1106605155(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0
			local var_616_1 = 1

			if var_616_0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, false)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_2 = arg_613_1:GetWordFromCfg(1106605154)
				local var_616_3 = arg_613_1:FormatText(var_616_2.content)

				arg_613_1.text_.text = var_616_3

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_4 = 40
				local var_616_5 = utf8.len(var_616_3)
				local var_616_6 = var_616_4 <= 0 and var_616_1 or var_616_1 * (var_616_5 / var_616_4)

				if var_616_6 > 0 and var_616_1 < var_616_6 then
					arg_613_1.talkMaxDuration = var_616_6

					if var_616_6 + var_616_0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_6 + var_616_0
					end
				end

				arg_613_1.text_.text = var_616_3
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_7 = math.max(var_616_1, arg_613_1.talkMaxDuration)

			if var_616_0 <= arg_613_1.time_ and arg_613_1.time_ < var_616_0 + var_616_7 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_0) / var_616_7

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_0 + var_616_7 and arg_613_1.time_ < var_616_0 + var_616_7 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605155 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1106605155
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1106605156(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 0.325

			if var_620_0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_2 = arg_617_1:FormatText(StoryNameCfg[7].name)

				arg_617_1.leftNameTxt_.text = var_620_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:GetWordFromCfg(1106605155)
				local var_620_4 = arg_617_1:FormatText(var_620_3.content)

				arg_617_1.text_.text = var_620_4

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 13
				local var_620_6 = utf8.len(var_620_4)
				local var_620_7 = var_620_5 <= 0 and var_620_1 or var_620_1 * (var_620_6 / var_620_5)

				if var_620_7 > 0 and var_620_1 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_4
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_8 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 <= arg_617_1.time_ and arg_617_1.time_ < var_620_0 + var_620_8 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_0) / var_620_8

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_0 + var_620_8 and arg_617_1.time_ < var_620_0 + var_620_8 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605156 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1106605156
		arg_621_1.duration_ = 2.866

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1106605157(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["1066ui_story"].transform
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.var_.moveOldPos1066ui_story = var_624_0.localPosition
			end

			local var_624_2 = 0.001

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2
				local var_624_4 = Vector3.New(0, -0.77, -6.1)

				var_624_0.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos1066ui_story, var_624_4, var_624_3)

				local var_624_5 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_5.x, var_624_5.y, var_624_5.z)

				local var_624_6 = var_624_0.localEulerAngles

				var_624_6.z = 0
				var_624_6.x = 0
				var_624_0.localEulerAngles = var_624_6
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 then
				var_624_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_624_7 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_7.x, var_624_7.y, var_624_7.z)

				local var_624_8 = var_624_0.localEulerAngles

				var_624_8.z = 0
				var_624_8.x = 0
				var_624_0.localEulerAngles = var_624_8
			end

			local var_624_9 = arg_621_1.actors_["1066ui_story"]
			local var_624_10 = 0

			if var_624_10 < arg_621_1.time_ and arg_621_1.time_ <= var_624_10 + arg_624_0 and arg_621_1.var_.characterEffect1066ui_story == nil then
				arg_621_1.var_.characterEffect1066ui_story = var_624_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_11 = 0.200000002980232

			if var_624_10 <= arg_621_1.time_ and arg_621_1.time_ < var_624_10 + var_624_11 then
				local var_624_12 = (arg_621_1.time_ - var_624_10) / var_624_11

				if arg_621_1.var_.characterEffect1066ui_story then
					arg_621_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= var_624_10 + var_624_11 and arg_621_1.time_ < var_624_10 + var_624_11 + arg_624_0 and arg_621_1.var_.characterEffect1066ui_story then
				arg_621_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_624_13 = 0

			if var_624_13 < arg_621_1.time_ and arg_621_1.time_ <= var_624_13 + arg_624_0 then
				arg_621_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_624_14 = 0

			if var_624_14 < arg_621_1.time_ and arg_621_1.time_ <= var_624_14 + arg_624_0 then
				arg_621_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_624_15 = 0
			local var_624_16 = 0.25

			if var_624_15 < arg_621_1.time_ and arg_621_1.time_ <= var_624_15 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_17 = arg_621_1:FormatText(StoryNameCfg[32].name)

				arg_621_1.leftNameTxt_.text = var_624_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_18 = arg_621_1:GetWordFromCfg(1106605156)
				local var_624_19 = arg_621_1:FormatText(var_624_18.content)

				arg_621_1.text_.text = var_624_19

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_20 = 10
				local var_624_21 = utf8.len(var_624_19)
				local var_624_22 = var_624_20 <= 0 and var_624_16 or var_624_16 * (var_624_21 / var_624_20)

				if var_624_22 > 0 and var_624_16 < var_624_22 then
					arg_621_1.talkMaxDuration = var_624_22

					if var_624_22 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_22 + var_624_15
					end
				end

				arg_621_1.text_.text = var_624_19
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605156", "story_v_side_new_1106605.awb") ~= 0 then
					local var_624_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605156", "story_v_side_new_1106605.awb") / 1000

					if var_624_23 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_23 + var_624_15
					end

					if var_624_18.prefab_name ~= "" and arg_621_1.actors_[var_624_18.prefab_name] ~= nil then
						local var_624_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_18.prefab_name].transform, "story_v_side_new_1106605", "1106605156", "story_v_side_new_1106605.awb")

						arg_621_1:RecordAudio("1106605156", var_624_24)
						arg_621_1:RecordAudio("1106605156", var_624_24)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605156", "story_v_side_new_1106605.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605156", "story_v_side_new_1106605.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_25 = math.max(var_624_16, arg_621_1.talkMaxDuration)

			if var_624_15 <= arg_621_1.time_ and arg_621_1.time_ < var_624_15 + var_624_25 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_15) / var_624_25

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_15 + var_624_25 and arg_621_1.time_ < var_624_15 + var_624_25 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605157 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1106605157
		arg_625_1.duration_ = 0.999999999999

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"

			SetActive(arg_625_1.choicesGo_, true)

			for iter_626_0, iter_626_1 in ipairs(arg_625_1.choices_) do
				local var_626_0 = iter_626_0 <= 1

				SetActive(iter_626_1.go, var_626_0)
			end

			arg_625_1.choices_[1].txt.text = arg_625_1:FormatText(StoryChoiceCfg[553].name)
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1106605158(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["1066ui_story"]
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 and arg_625_1.var_.characterEffect1066ui_story == nil then
				arg_625_1.var_.characterEffect1066ui_story = var_628_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2

				if arg_625_1.var_.characterEffect1066ui_story then
					local var_628_4 = Mathf.Lerp(0, 0.5, var_628_3)

					arg_625_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_625_1.var_.characterEffect1066ui_story.fillRatio = var_628_4
				end
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 and arg_625_1.var_.characterEffect1066ui_story then
				local var_628_5 = 0.5

				arg_625_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_625_1.var_.characterEffect1066ui_story.fillRatio = var_628_5
			end

			local var_628_6 = 0
			local var_628_7 = 1

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				local var_628_8 = "stop"
				local var_628_9 = "effect"

				arg_625_1:AudioAction(var_628_8, var_628_9, "se_story_121_04", "se_story_121_04_crowd_loop", "")
			end
		end
	end,
	Play1106605158 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1106605158
		arg_629_1.duration_ = 9

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1106605159(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = "ST28"

			if arg_629_1.bgs_[var_632_0] == nil then
				local var_632_1 = Object.Instantiate(arg_629_1.paintGo_)

				var_632_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_632_0)
				var_632_1.name = var_632_0
				var_632_1.transform.parent = arg_629_1.stage_.transform
				var_632_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_629_1.bgs_[var_632_0] = var_632_1
			end

			local var_632_2 = 2

			if var_632_2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_2 + arg_632_0 then
				local var_632_3 = manager.ui.mainCamera.transform.localPosition
				local var_632_4 = Vector3.New(0, 0, 10) + Vector3.New(var_632_3.x, var_632_3.y, 0)
				local var_632_5 = arg_629_1.bgs_.ST28

				var_632_5.transform.localPosition = var_632_4
				var_632_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_632_6 = var_632_5:GetComponent("SpriteRenderer")

				if var_632_6 and var_632_6.sprite then
					local var_632_7 = (var_632_5.transform.localPosition - var_632_3).z
					local var_632_8 = manager.ui.mainCameraCom_
					local var_632_9 = 2 * var_632_7 * Mathf.Tan(var_632_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_632_10 = var_632_9 * var_632_8.aspect
					local var_632_11 = var_632_6.sprite.bounds.size.x
					local var_632_12 = var_632_6.sprite.bounds.size.y
					local var_632_13 = var_632_10 / var_632_11
					local var_632_14 = var_632_9 / var_632_12
					local var_632_15 = var_632_14 < var_632_13 and var_632_13 or var_632_14

					var_632_5.transform.localScale = Vector3.New(var_632_15, var_632_15, 0)
				end

				for iter_632_0, iter_632_1 in pairs(arg_629_1.bgs_) do
					if iter_632_0 ~= "ST28" then
						iter_632_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_632_16 = 0

			if var_632_16 < arg_629_1.time_ and arg_629_1.time_ <= var_632_16 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_17 = 2

			if var_632_16 <= arg_629_1.time_ and arg_629_1.time_ < var_632_16 + var_632_17 then
				local var_632_18 = (arg_629_1.time_ - var_632_16) / var_632_17
				local var_632_19 = Color.New(0, 0, 0)

				var_632_19.a = Mathf.Lerp(0, 1, var_632_18)
				arg_629_1.mask_.color = var_632_19
			end

			if arg_629_1.time_ >= var_632_16 + var_632_17 and arg_629_1.time_ < var_632_16 + var_632_17 + arg_632_0 then
				local var_632_20 = Color.New(0, 0, 0)

				var_632_20.a = 1
				arg_629_1.mask_.color = var_632_20
			end

			local var_632_21 = 2

			if var_632_21 < arg_629_1.time_ and arg_629_1.time_ <= var_632_21 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_22 = 2

			if var_632_21 <= arg_629_1.time_ and arg_629_1.time_ < var_632_21 + var_632_22 then
				local var_632_23 = (arg_629_1.time_ - var_632_21) / var_632_22
				local var_632_24 = Color.New(0, 0, 0)

				var_632_24.a = Mathf.Lerp(1, 0, var_632_23)
				arg_629_1.mask_.color = var_632_24
			end

			if arg_629_1.time_ >= var_632_21 + var_632_22 and arg_629_1.time_ < var_632_21 + var_632_22 + arg_632_0 then
				local var_632_25 = Color.New(0, 0, 0)
				local var_632_26 = 0

				arg_629_1.mask_.enabled = false
				var_632_25.a = var_632_26
				arg_629_1.mask_.color = var_632_25
			end

			local var_632_27 = arg_629_1.actors_["1066ui_story"].transform
			local var_632_28 = 2

			if var_632_28 < arg_629_1.time_ and arg_629_1.time_ <= var_632_28 + arg_632_0 then
				arg_629_1.var_.moveOldPos1066ui_story = var_632_27.localPosition
			end

			local var_632_29 = 0.001

			if var_632_28 <= arg_629_1.time_ and arg_629_1.time_ < var_632_28 + var_632_29 then
				local var_632_30 = (arg_629_1.time_ - var_632_28) / var_632_29
				local var_632_31 = Vector3.New(0, 100, 0)

				var_632_27.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1066ui_story, var_632_31, var_632_30)

				local var_632_32 = manager.ui.mainCamera.transform.position - var_632_27.position

				var_632_27.forward = Vector3.New(var_632_32.x, var_632_32.y, var_632_32.z)

				local var_632_33 = var_632_27.localEulerAngles

				var_632_33.z = 0
				var_632_33.x = 0
				var_632_27.localEulerAngles = var_632_33
			end

			if arg_629_1.time_ >= var_632_28 + var_632_29 and arg_629_1.time_ < var_632_28 + var_632_29 + arg_632_0 then
				var_632_27.localPosition = Vector3.New(0, 100, 0)

				local var_632_34 = manager.ui.mainCamera.transform.position - var_632_27.position

				var_632_27.forward = Vector3.New(var_632_34.x, var_632_34.y, var_632_34.z)

				local var_632_35 = var_632_27.localEulerAngles

				var_632_35.z = 0
				var_632_35.x = 0
				var_632_27.localEulerAngles = var_632_35
			end

			local var_632_36 = 0
			local var_632_37 = 1

			if var_632_36 < arg_629_1.time_ and arg_629_1.time_ <= var_632_36 + arg_632_0 then
				local var_632_38 = "play"
				local var_632_39 = "effect"

				arg_629_1:AudioAction(var_632_38, var_632_39, "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_40 = 4
			local var_632_41 = 0.275

			if var_632_40 < arg_629_1.time_ and arg_629_1.time_ <= var_632_40 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				local var_632_42 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_42:setOnUpdate(LuaHelper.FloatAction(function(arg_633_0)
					arg_629_1.dialogCg_.alpha = arg_633_0
				end))
				var_632_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, true)

				local var_632_43 = arg_629_1:FormatText(StoryNameCfg[7].name)

				arg_629_1.leftNameTxt_.text = var_632_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_44 = arg_629_1:GetWordFromCfg(1106605158)
				local var_632_45 = arg_629_1:FormatText(var_632_44.content)

				arg_629_1.text_.text = var_632_45

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_46 = 11
				local var_632_47 = utf8.len(var_632_45)
				local var_632_48 = var_632_46 <= 0 and var_632_41 or var_632_41 * (var_632_47 / var_632_46)

				if var_632_48 > 0 and var_632_41 < var_632_48 then
					arg_629_1.talkMaxDuration = var_632_48
					var_632_40 = var_632_40 + 0.3

					if var_632_48 + var_632_40 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_48 + var_632_40
					end
				end

				arg_629_1.text_.text = var_632_45
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_49 = var_632_40 + 0.3
			local var_632_50 = math.max(var_632_41, arg_629_1.talkMaxDuration)

			if var_632_49 <= arg_629_1.time_ and arg_629_1.time_ < var_632_49 + var_632_50 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_49) / var_632_50

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_49 + var_632_50 and arg_629_1.time_ < var_632_49 + var_632_50 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605159 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1106605159
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1106605160(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0
			local var_638_1 = 1.5

			if var_638_0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_2 = arg_635_1:GetWordFromCfg(1106605159)
				local var_638_3 = arg_635_1:FormatText(var_638_2.content)

				arg_635_1.text_.text = var_638_3

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 60
				local var_638_5 = utf8.len(var_638_3)
				local var_638_6 = var_638_4 <= 0 and var_638_1 or var_638_1 * (var_638_5 / var_638_4)

				if var_638_6 > 0 and var_638_1 < var_638_6 then
					arg_635_1.talkMaxDuration = var_638_6

					if var_638_6 + var_638_0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_6 + var_638_0
					end
				end

				arg_635_1.text_.text = var_638_3
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_1, arg_635_1.talkMaxDuration)

			if var_638_0 <= arg_635_1.time_ and arg_635_1.time_ < var_638_0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_0 + var_638_7 and arg_635_1.time_ < var_638_0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605160 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1106605160
		arg_639_1.duration_ = 11.033

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1106605161(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = arg_639_1.actors_["1066ui_story"].transform
			local var_642_1 = 0

			if var_642_1 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.var_.moveOldPos1066ui_story = var_642_0.localPosition
			end

			local var_642_2 = 0.001

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_2 then
				local var_642_3 = (arg_639_1.time_ - var_642_1) / var_642_2
				local var_642_4 = Vector3.New(0, -0.77, -6.1)

				var_642_0.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1066ui_story, var_642_4, var_642_3)

				local var_642_5 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_5.x, var_642_5.y, var_642_5.z)

				local var_642_6 = var_642_0.localEulerAngles

				var_642_6.z = 0
				var_642_6.x = 0
				var_642_0.localEulerAngles = var_642_6
			end

			if arg_639_1.time_ >= var_642_1 + var_642_2 and arg_639_1.time_ < var_642_1 + var_642_2 + arg_642_0 then
				var_642_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_642_7 = manager.ui.mainCamera.transform.position - var_642_0.position

				var_642_0.forward = Vector3.New(var_642_7.x, var_642_7.y, var_642_7.z)

				local var_642_8 = var_642_0.localEulerAngles

				var_642_8.z = 0
				var_642_8.x = 0
				var_642_0.localEulerAngles = var_642_8
			end

			local var_642_9 = arg_639_1.actors_["1066ui_story"]
			local var_642_10 = 0

			if var_642_10 < arg_639_1.time_ and arg_639_1.time_ <= var_642_10 + arg_642_0 and arg_639_1.var_.characterEffect1066ui_story == nil then
				arg_639_1.var_.characterEffect1066ui_story = var_642_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_11 = 0.200000002980232

			if var_642_10 <= arg_639_1.time_ and arg_639_1.time_ < var_642_10 + var_642_11 then
				local var_642_12 = (arg_639_1.time_ - var_642_10) / var_642_11

				if arg_639_1.var_.characterEffect1066ui_story then
					arg_639_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= var_642_10 + var_642_11 and arg_639_1.time_ < var_642_10 + var_642_11 + arg_642_0 and arg_639_1.var_.characterEffect1066ui_story then
				arg_639_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_642_13 = 0

			if var_642_13 < arg_639_1.time_ and arg_639_1.time_ <= var_642_13 + arg_642_0 then
				arg_639_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action8_1")
			end

			local var_642_14 = 0

			if var_642_14 < arg_639_1.time_ and arg_639_1.time_ <= var_642_14 + arg_642_0 then
				arg_639_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_642_15 = 0
			local var_642_16 = 1.175

			if var_642_15 < arg_639_1.time_ and arg_639_1.time_ <= var_642_15 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_17 = arg_639_1:FormatText(StoryNameCfg[32].name)

				arg_639_1.leftNameTxt_.text = var_642_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_18 = arg_639_1:GetWordFromCfg(1106605160)
				local var_642_19 = arg_639_1:FormatText(var_642_18.content)

				arg_639_1.text_.text = var_642_19

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_20 = 47
				local var_642_21 = utf8.len(var_642_19)
				local var_642_22 = var_642_20 <= 0 and var_642_16 or var_642_16 * (var_642_21 / var_642_20)

				if var_642_22 > 0 and var_642_16 < var_642_22 then
					arg_639_1.talkMaxDuration = var_642_22

					if var_642_22 + var_642_15 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_22 + var_642_15
					end
				end

				arg_639_1.text_.text = var_642_19
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605160", "story_v_side_new_1106605.awb") ~= 0 then
					local var_642_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605160", "story_v_side_new_1106605.awb") / 1000

					if var_642_23 + var_642_15 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_23 + var_642_15
					end

					if var_642_18.prefab_name ~= "" and arg_639_1.actors_[var_642_18.prefab_name] ~= nil then
						local var_642_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_18.prefab_name].transform, "story_v_side_new_1106605", "1106605160", "story_v_side_new_1106605.awb")

						arg_639_1:RecordAudio("1106605160", var_642_24)
						arg_639_1:RecordAudio("1106605160", var_642_24)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605160", "story_v_side_new_1106605.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605160", "story_v_side_new_1106605.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_25 = math.max(var_642_16, arg_639_1.talkMaxDuration)

			if var_642_15 <= arg_639_1.time_ and arg_639_1.time_ < var_642_15 + var_642_25 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_15) / var_642_25

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_15 + var_642_25 and arg_639_1.time_ < var_642_15 + var_642_25 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605161 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1106605161
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1106605162(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1066ui_story"]
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 and arg_643_1.var_.characterEffect1066ui_story == nil then
				arg_643_1.var_.characterEffect1066ui_story = var_646_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2

				if arg_643_1.var_.characterEffect1066ui_story then
					local var_646_4 = Mathf.Lerp(0, 0.5, var_646_3)

					arg_643_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_643_1.var_.characterEffect1066ui_story.fillRatio = var_646_4
				end
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 and arg_643_1.var_.characterEffect1066ui_story then
				local var_646_5 = 0.5

				arg_643_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_643_1.var_.characterEffect1066ui_story.fillRatio = var_646_5
			end

			local var_646_6 = 0
			local var_646_7 = 1.1

			if var_646_6 < arg_643_1.time_ and arg_643_1.time_ <= var_646_6 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_8 = arg_643_1:FormatText(StoryNameCfg[7].name)

				arg_643_1.leftNameTxt_.text = var_646_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_9 = arg_643_1:GetWordFromCfg(1106605161)
				local var_646_10 = arg_643_1:FormatText(var_646_9.content)

				arg_643_1.text_.text = var_646_10

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_11 = 44
				local var_646_12 = utf8.len(var_646_10)
				local var_646_13 = var_646_11 <= 0 and var_646_7 or var_646_7 * (var_646_12 / var_646_11)

				if var_646_13 > 0 and var_646_7 < var_646_13 then
					arg_643_1.talkMaxDuration = var_646_13

					if var_646_13 + var_646_6 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_13 + var_646_6
					end
				end

				arg_643_1.text_.text = var_646_10
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_14 = math.max(var_646_7, arg_643_1.talkMaxDuration)

			if var_646_6 <= arg_643_1.time_ and arg_643_1.time_ < var_646_6 + var_646_14 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_6) / var_646_14

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_6 + var_646_14 and arg_643_1.time_ < var_646_6 + var_646_14 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605162 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1106605162
		arg_647_1.duration_ = 10.133

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1106605163(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["1066ui_story"].transform
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 then
				arg_647_1.var_.moveOldPos1066ui_story = var_650_0.localPosition
			end

			local var_650_2 = 0.001

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2
				local var_650_4 = Vector3.New(0, -0.77, -6.1)

				var_650_0.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1066ui_story, var_650_4, var_650_3)

				local var_650_5 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_5.x, var_650_5.y, var_650_5.z)

				local var_650_6 = var_650_0.localEulerAngles

				var_650_6.z = 0
				var_650_6.x = 0
				var_650_0.localEulerAngles = var_650_6
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 then
				var_650_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_650_7 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_7.x, var_650_7.y, var_650_7.z)

				local var_650_8 = var_650_0.localEulerAngles

				var_650_8.z = 0
				var_650_8.x = 0
				var_650_0.localEulerAngles = var_650_8
			end

			local var_650_9 = arg_647_1.actors_["1066ui_story"]
			local var_650_10 = 0

			if var_650_10 < arg_647_1.time_ and arg_647_1.time_ <= var_650_10 + arg_650_0 and arg_647_1.var_.characterEffect1066ui_story == nil then
				arg_647_1.var_.characterEffect1066ui_story = var_650_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_11 = 0.200000002980232

			if var_650_10 <= arg_647_1.time_ and arg_647_1.time_ < var_650_10 + var_650_11 then
				local var_650_12 = (arg_647_1.time_ - var_650_10) / var_650_11

				if arg_647_1.var_.characterEffect1066ui_story then
					arg_647_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_647_1.time_ >= var_650_10 + var_650_11 and arg_647_1.time_ < var_650_10 + var_650_11 + arg_650_0 and arg_647_1.var_.characterEffect1066ui_story then
				arg_647_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_650_13 = 0

			if var_650_13 < arg_647_1.time_ and arg_647_1.time_ <= var_650_13 + arg_650_0 then
				arg_647_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action8_2")
			end

			local var_650_14 = 0

			if var_650_14 < arg_647_1.time_ and arg_647_1.time_ <= var_650_14 + arg_650_0 then
				arg_647_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_650_15 = 0
			local var_650_16 = 1.175

			if var_650_15 < arg_647_1.time_ and arg_647_1.time_ <= var_650_15 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_17 = arg_647_1:FormatText(StoryNameCfg[32].name)

				arg_647_1.leftNameTxt_.text = var_650_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_18 = arg_647_1:GetWordFromCfg(1106605162)
				local var_650_19 = arg_647_1:FormatText(var_650_18.content)

				arg_647_1.text_.text = var_650_19

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_20 = 47
				local var_650_21 = utf8.len(var_650_19)
				local var_650_22 = var_650_20 <= 0 and var_650_16 or var_650_16 * (var_650_21 / var_650_20)

				if var_650_22 > 0 and var_650_16 < var_650_22 then
					arg_647_1.talkMaxDuration = var_650_22

					if var_650_22 + var_650_15 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_22 + var_650_15
					end
				end

				arg_647_1.text_.text = var_650_19
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605162", "story_v_side_new_1106605.awb") ~= 0 then
					local var_650_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605162", "story_v_side_new_1106605.awb") / 1000

					if var_650_23 + var_650_15 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_23 + var_650_15
					end

					if var_650_18.prefab_name ~= "" and arg_647_1.actors_[var_650_18.prefab_name] ~= nil then
						local var_650_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_18.prefab_name].transform, "story_v_side_new_1106605", "1106605162", "story_v_side_new_1106605.awb")

						arg_647_1:RecordAudio("1106605162", var_650_24)
						arg_647_1:RecordAudio("1106605162", var_650_24)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605162", "story_v_side_new_1106605.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605162", "story_v_side_new_1106605.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_25 = math.max(var_650_16, arg_647_1.talkMaxDuration)

			if var_650_15 <= arg_647_1.time_ and arg_647_1.time_ < var_650_15 + var_650_25 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_15) / var_650_25

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_15 + var_650_25 and arg_647_1.time_ < var_650_15 + var_650_25 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605163 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1106605163
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1106605164(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = arg_651_1.actors_["1066ui_story"]
			local var_654_1 = 0

			if var_654_1 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 and arg_651_1.var_.characterEffect1066ui_story == nil then
				arg_651_1.var_.characterEffect1066ui_story = var_654_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_2 = 0.200000002980232

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_2 then
				local var_654_3 = (arg_651_1.time_ - var_654_1) / var_654_2

				if arg_651_1.var_.characterEffect1066ui_story then
					local var_654_4 = Mathf.Lerp(0, 0.5, var_654_3)

					arg_651_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_651_1.var_.characterEffect1066ui_story.fillRatio = var_654_4
				end
			end

			if arg_651_1.time_ >= var_654_1 + var_654_2 and arg_651_1.time_ < var_654_1 + var_654_2 + arg_654_0 and arg_651_1.var_.characterEffect1066ui_story then
				local var_654_5 = 0.5

				arg_651_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_651_1.var_.characterEffect1066ui_story.fillRatio = var_654_5
			end

			local var_654_6 = 0
			local var_654_7 = 0.625

			if var_654_6 < arg_651_1.time_ and arg_651_1.time_ <= var_654_6 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_8 = arg_651_1:FormatText(StoryNameCfg[7].name)

				arg_651_1.leftNameTxt_.text = var_654_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_9 = arg_651_1:GetWordFromCfg(1106605163)
				local var_654_10 = arg_651_1:FormatText(var_654_9.content)

				arg_651_1.text_.text = var_654_10

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_11 = 25
				local var_654_12 = utf8.len(var_654_10)
				local var_654_13 = var_654_11 <= 0 and var_654_7 or var_654_7 * (var_654_12 / var_654_11)

				if var_654_13 > 0 and var_654_7 < var_654_13 then
					arg_651_1.talkMaxDuration = var_654_13

					if var_654_13 + var_654_6 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_13 + var_654_6
					end
				end

				arg_651_1.text_.text = var_654_10
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_14 = math.max(var_654_7, arg_651_1.talkMaxDuration)

			if var_654_6 <= arg_651_1.time_ and arg_651_1.time_ < var_654_6 + var_654_14 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_6) / var_654_14

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_6 + var_654_14 and arg_651_1.time_ < var_654_6 + var_654_14 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605164 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1106605164
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1106605165(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_658_1 = 0
			local var_658_2 = 0.375

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_3 = arg_655_1:FormatText(StoryNameCfg[7].name)

				arg_655_1.leftNameTxt_.text = var_658_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_4 = arg_655_1:GetWordFromCfg(1106605164)
				local var_658_5 = arg_655_1:FormatText(var_658_4.content)

				arg_655_1.text_.text = var_658_5

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_6 = 15
				local var_658_7 = utf8.len(var_658_5)
				local var_658_8 = var_658_6 <= 0 and var_658_2 or var_658_2 * (var_658_7 / var_658_6)

				if var_658_8 > 0 and var_658_2 < var_658_8 then
					arg_655_1.talkMaxDuration = var_658_8

					if var_658_8 + var_658_1 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_8 + var_658_1
					end
				end

				arg_655_1.text_.text = var_658_5
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_9 = math.max(var_658_2, arg_655_1.talkMaxDuration)

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_9 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_1) / var_658_9

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_1 + var_658_9 and arg_655_1.time_ < var_658_1 + var_658_9 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605165 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1106605165
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1106605166(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 0.75

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, false)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_2 = arg_659_1:GetWordFromCfg(1106605165)
				local var_662_3 = arg_659_1:FormatText(var_662_2.content)

				arg_659_1.text_.text = var_662_3

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_4 = 30
				local var_662_5 = utf8.len(var_662_3)
				local var_662_6 = var_662_4 <= 0 and var_662_1 or var_662_1 * (var_662_5 / var_662_4)

				if var_662_6 > 0 and var_662_1 < var_662_6 then
					arg_659_1.talkMaxDuration = var_662_6

					if var_662_6 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_6 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_3
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_7 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_7 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_7

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_7 and arg_659_1.time_ < var_662_0 + var_662_7 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605166 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1106605166
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1106605167(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0
			local var_666_1 = 1.425

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_2 = arg_663_1:GetWordFromCfg(1106605166)
				local var_666_3 = arg_663_1:FormatText(var_666_2.content)

				arg_663_1.text_.text = var_666_3

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_4 = 57
				local var_666_5 = utf8.len(var_666_3)
				local var_666_6 = var_666_4 <= 0 and var_666_1 or var_666_1 * (var_666_5 / var_666_4)

				if var_666_6 > 0 and var_666_1 < var_666_6 then
					arg_663_1.talkMaxDuration = var_666_6

					if var_666_6 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_6 + var_666_0
					end
				end

				arg_663_1.text_.text = var_666_3
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_7 = math.max(var_666_1, arg_663_1.talkMaxDuration)

			if var_666_0 <= arg_663_1.time_ and arg_663_1.time_ < var_666_0 + var_666_7 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_0) / var_666_7

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_0 + var_666_7 and arg_663_1.time_ < var_666_0 + var_666_7 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605167 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 1106605167
		arg_667_1.duration_ = 5.5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play1106605168(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["1066ui_story"].transform
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 then
				arg_667_1.var_.moveOldPos1066ui_story = var_670_0.localPosition
			end

			local var_670_2 = 0.001

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2
				local var_670_4 = Vector3.New(0, -0.77, -6.1)

				var_670_0.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos1066ui_story, var_670_4, var_670_3)

				local var_670_5 = manager.ui.mainCamera.transform.position - var_670_0.position

				var_670_0.forward = Vector3.New(var_670_5.x, var_670_5.y, var_670_5.z)

				local var_670_6 = var_670_0.localEulerAngles

				var_670_6.z = 0
				var_670_6.x = 0
				var_670_0.localEulerAngles = var_670_6
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 then
				var_670_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_670_7 = manager.ui.mainCamera.transform.position - var_670_0.position

				var_670_0.forward = Vector3.New(var_670_7.x, var_670_7.y, var_670_7.z)

				local var_670_8 = var_670_0.localEulerAngles

				var_670_8.z = 0
				var_670_8.x = 0
				var_670_0.localEulerAngles = var_670_8
			end

			local var_670_9 = arg_667_1.actors_["1066ui_story"]
			local var_670_10 = 0

			if var_670_10 < arg_667_1.time_ and arg_667_1.time_ <= var_670_10 + arg_670_0 and arg_667_1.var_.characterEffect1066ui_story == nil then
				arg_667_1.var_.characterEffect1066ui_story = var_670_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_11 = 0.200000002980232

			if var_670_10 <= arg_667_1.time_ and arg_667_1.time_ < var_670_10 + var_670_11 then
				local var_670_12 = (arg_667_1.time_ - var_670_10) / var_670_11

				if arg_667_1.var_.characterEffect1066ui_story then
					arg_667_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= var_670_10 + var_670_11 and arg_667_1.time_ < var_670_10 + var_670_11 + arg_670_0 and arg_667_1.var_.characterEffect1066ui_story then
				arg_667_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_670_13 = 0

			if var_670_13 < arg_667_1.time_ and arg_667_1.time_ <= var_670_13 + arg_670_0 then
				arg_667_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			local var_670_14 = 0

			if var_670_14 < arg_667_1.time_ and arg_667_1.time_ <= var_670_14 + arg_670_0 then
				arg_667_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_670_15 = 0
			local var_670_16 = 0.65

			if var_670_15 < arg_667_1.time_ and arg_667_1.time_ <= var_670_15 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_17 = arg_667_1:FormatText(StoryNameCfg[32].name)

				arg_667_1.leftNameTxt_.text = var_670_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_18 = arg_667_1:GetWordFromCfg(1106605167)
				local var_670_19 = arg_667_1:FormatText(var_670_18.content)

				arg_667_1.text_.text = var_670_19

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_20 = 26
				local var_670_21 = utf8.len(var_670_19)
				local var_670_22 = var_670_20 <= 0 and var_670_16 or var_670_16 * (var_670_21 / var_670_20)

				if var_670_22 > 0 and var_670_16 < var_670_22 then
					arg_667_1.talkMaxDuration = var_670_22

					if var_670_22 + var_670_15 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_22 + var_670_15
					end
				end

				arg_667_1.text_.text = var_670_19
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605167", "story_v_side_new_1106605.awb") ~= 0 then
					local var_670_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605167", "story_v_side_new_1106605.awb") / 1000

					if var_670_23 + var_670_15 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_23 + var_670_15
					end

					if var_670_18.prefab_name ~= "" and arg_667_1.actors_[var_670_18.prefab_name] ~= nil then
						local var_670_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_667_1.actors_[var_670_18.prefab_name].transform, "story_v_side_new_1106605", "1106605167", "story_v_side_new_1106605.awb")

						arg_667_1:RecordAudio("1106605167", var_670_24)
						arg_667_1:RecordAudio("1106605167", var_670_24)
					else
						arg_667_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605167", "story_v_side_new_1106605.awb")
					end

					arg_667_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605167", "story_v_side_new_1106605.awb")
				end

				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_25 = math.max(var_670_16, arg_667_1.talkMaxDuration)

			if var_670_15 <= arg_667_1.time_ and arg_667_1.time_ < var_670_15 + var_670_25 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_15) / var_670_25

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_15 + var_670_25 and arg_667_1.time_ < var_670_15 + var_670_25 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605168 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 1106605168
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play1106605169(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = arg_671_1.actors_["1066ui_story"]
			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 and arg_671_1.var_.characterEffect1066ui_story == nil then
				arg_671_1.var_.characterEffect1066ui_story = var_674_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_674_2 = 0.200000002980232

			if var_674_1 <= arg_671_1.time_ and arg_671_1.time_ < var_674_1 + var_674_2 then
				local var_674_3 = (arg_671_1.time_ - var_674_1) / var_674_2

				if arg_671_1.var_.characterEffect1066ui_story then
					local var_674_4 = Mathf.Lerp(0, 0.5, var_674_3)

					arg_671_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_671_1.var_.characterEffect1066ui_story.fillRatio = var_674_4
				end
			end

			if arg_671_1.time_ >= var_674_1 + var_674_2 and arg_671_1.time_ < var_674_1 + var_674_2 + arg_674_0 and arg_671_1.var_.characterEffect1066ui_story then
				local var_674_5 = 0.5

				arg_671_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_671_1.var_.characterEffect1066ui_story.fillRatio = var_674_5
			end

			local var_674_6 = 0
			local var_674_7 = 0.4

			if var_674_6 < arg_671_1.time_ and arg_671_1.time_ <= var_674_6 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_8 = arg_671_1:FormatText(StoryNameCfg[7].name)

				arg_671_1.leftNameTxt_.text = var_674_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_9 = arg_671_1:GetWordFromCfg(1106605168)
				local var_674_10 = arg_671_1:FormatText(var_674_9.content)

				arg_671_1.text_.text = var_674_10

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_11 = 16
				local var_674_12 = utf8.len(var_674_10)
				local var_674_13 = var_674_11 <= 0 and var_674_7 or var_674_7 * (var_674_12 / var_674_11)

				if var_674_13 > 0 and var_674_7 < var_674_13 then
					arg_671_1.talkMaxDuration = var_674_13

					if var_674_13 + var_674_6 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_13 + var_674_6
					end
				end

				arg_671_1.text_.text = var_674_10
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_14 = math.max(var_674_7, arg_671_1.talkMaxDuration)

			if var_674_6 <= arg_671_1.time_ and arg_671_1.time_ < var_674_6 + var_674_14 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_6) / var_674_14

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_6 + var_674_14 and arg_671_1.time_ < var_674_6 + var_674_14 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605169 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 1106605169
		arg_675_1.duration_ = 10.5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play1106605170(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["1066ui_story"].transform
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1.var_.moveOldPos1066ui_story = var_678_0.localPosition
			end

			local var_678_2 = 0.001

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2
				local var_678_4 = Vector3.New(0, -0.77, -6.1)

				var_678_0.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos1066ui_story, var_678_4, var_678_3)

				local var_678_5 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_5.x, var_678_5.y, var_678_5.z)

				local var_678_6 = var_678_0.localEulerAngles

				var_678_6.z = 0
				var_678_6.x = 0
				var_678_0.localEulerAngles = var_678_6
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 then
				var_678_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_678_7 = manager.ui.mainCamera.transform.position - var_678_0.position

				var_678_0.forward = Vector3.New(var_678_7.x, var_678_7.y, var_678_7.z)

				local var_678_8 = var_678_0.localEulerAngles

				var_678_8.z = 0
				var_678_8.x = 0
				var_678_0.localEulerAngles = var_678_8
			end

			local var_678_9 = arg_675_1.actors_["1066ui_story"]
			local var_678_10 = 0

			if var_678_10 < arg_675_1.time_ and arg_675_1.time_ <= var_678_10 + arg_678_0 and arg_675_1.var_.characterEffect1066ui_story == nil then
				arg_675_1.var_.characterEffect1066ui_story = var_678_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_678_11 = 0.200000002980232

			if var_678_10 <= arg_675_1.time_ and arg_675_1.time_ < var_678_10 + var_678_11 then
				local var_678_12 = (arg_675_1.time_ - var_678_10) / var_678_11

				if arg_675_1.var_.characterEffect1066ui_story then
					arg_675_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_675_1.time_ >= var_678_10 + var_678_11 and arg_675_1.time_ < var_678_10 + var_678_11 + arg_678_0 and arg_675_1.var_.characterEffect1066ui_story then
				arg_675_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_678_13 = 0

			if var_678_13 < arg_675_1.time_ and arg_675_1.time_ <= var_678_13 + arg_678_0 then
				arg_675_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			local var_678_14 = 0

			if var_678_14 < arg_675_1.time_ and arg_675_1.time_ <= var_678_14 + arg_678_0 then
				arg_675_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_678_15 = 0
			local var_678_16 = 1.25

			if var_678_15 < arg_675_1.time_ and arg_675_1.time_ <= var_678_15 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_17 = arg_675_1:FormatText(StoryNameCfg[32].name)

				arg_675_1.leftNameTxt_.text = var_678_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_18 = arg_675_1:GetWordFromCfg(1106605169)
				local var_678_19 = arg_675_1:FormatText(var_678_18.content)

				arg_675_1.text_.text = var_678_19

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_20 = 50
				local var_678_21 = utf8.len(var_678_19)
				local var_678_22 = var_678_20 <= 0 and var_678_16 or var_678_16 * (var_678_21 / var_678_20)

				if var_678_22 > 0 and var_678_16 < var_678_22 then
					arg_675_1.talkMaxDuration = var_678_22

					if var_678_22 + var_678_15 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_22 + var_678_15
					end
				end

				arg_675_1.text_.text = var_678_19
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605169", "story_v_side_new_1106605.awb") ~= 0 then
					local var_678_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605169", "story_v_side_new_1106605.awb") / 1000

					if var_678_23 + var_678_15 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_23 + var_678_15
					end

					if var_678_18.prefab_name ~= "" and arg_675_1.actors_[var_678_18.prefab_name] ~= nil then
						local var_678_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_18.prefab_name].transform, "story_v_side_new_1106605", "1106605169", "story_v_side_new_1106605.awb")

						arg_675_1:RecordAudio("1106605169", var_678_24)
						arg_675_1:RecordAudio("1106605169", var_678_24)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605169", "story_v_side_new_1106605.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605169", "story_v_side_new_1106605.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_25 = math.max(var_678_16, arg_675_1.talkMaxDuration)

			if var_678_15 <= arg_675_1.time_ and arg_675_1.time_ < var_678_15 + var_678_25 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_15) / var_678_25

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_15 + var_678_25 and arg_675_1.time_ < var_678_15 + var_678_25 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605170 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 1106605170
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play1106605171(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["1066ui_story"]
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 and arg_679_1.var_.characterEffect1066ui_story == nil then
				arg_679_1.var_.characterEffect1066ui_story = var_682_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_2 = 0.200000002980232

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2

				if arg_679_1.var_.characterEffect1066ui_story then
					local var_682_4 = Mathf.Lerp(0, 0.5, var_682_3)

					arg_679_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1066ui_story.fillRatio = var_682_4
				end
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 and arg_679_1.var_.characterEffect1066ui_story then
				local var_682_5 = 0.5

				arg_679_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1066ui_story.fillRatio = var_682_5
			end

			local var_682_6 = 0
			local var_682_7 = 0.975

			if var_682_6 < arg_679_1.time_ and arg_679_1.time_ <= var_682_6 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_8 = arg_679_1:FormatText(StoryNameCfg[7].name)

				arg_679_1.leftNameTxt_.text = var_682_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_9 = arg_679_1:GetWordFromCfg(1106605170)
				local var_682_10 = arg_679_1:FormatText(var_682_9.content)

				arg_679_1.text_.text = var_682_10

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_11 = 39
				local var_682_12 = utf8.len(var_682_10)
				local var_682_13 = var_682_11 <= 0 and var_682_7 or var_682_7 * (var_682_12 / var_682_11)

				if var_682_13 > 0 and var_682_7 < var_682_13 then
					arg_679_1.talkMaxDuration = var_682_13

					if var_682_13 + var_682_6 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_13 + var_682_6
					end
				end

				arg_679_1.text_.text = var_682_10
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_14 = math.max(var_682_7, arg_679_1.talkMaxDuration)

			if var_682_6 <= arg_679_1.time_ and arg_679_1.time_ < var_682_6 + var_682_14 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_6) / var_682_14

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_6 + var_682_14 and arg_679_1.time_ < var_682_6 + var_682_14 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605171 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 1106605171
		arg_683_1.duration_ = 3.2

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play1106605172(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = arg_683_1.actors_["1066ui_story"].transform
			local var_686_1 = 0

			if var_686_1 < arg_683_1.time_ and arg_683_1.time_ <= var_686_1 + arg_686_0 then
				arg_683_1.var_.moveOldPos1066ui_story = var_686_0.localPosition
			end

			local var_686_2 = 0.001

			if var_686_1 <= arg_683_1.time_ and arg_683_1.time_ < var_686_1 + var_686_2 then
				local var_686_3 = (arg_683_1.time_ - var_686_1) / var_686_2
				local var_686_4 = Vector3.New(0, -0.77, -6.1)

				var_686_0.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos1066ui_story, var_686_4, var_686_3)

				local var_686_5 = manager.ui.mainCamera.transform.position - var_686_0.position

				var_686_0.forward = Vector3.New(var_686_5.x, var_686_5.y, var_686_5.z)

				local var_686_6 = var_686_0.localEulerAngles

				var_686_6.z = 0
				var_686_6.x = 0
				var_686_0.localEulerAngles = var_686_6
			end

			if arg_683_1.time_ >= var_686_1 + var_686_2 and arg_683_1.time_ < var_686_1 + var_686_2 + arg_686_0 then
				var_686_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_686_7 = manager.ui.mainCamera.transform.position - var_686_0.position

				var_686_0.forward = Vector3.New(var_686_7.x, var_686_7.y, var_686_7.z)

				local var_686_8 = var_686_0.localEulerAngles

				var_686_8.z = 0
				var_686_8.x = 0
				var_686_0.localEulerAngles = var_686_8
			end

			local var_686_9 = arg_683_1.actors_["1066ui_story"]
			local var_686_10 = 0

			if var_686_10 < arg_683_1.time_ and arg_683_1.time_ <= var_686_10 + arg_686_0 and arg_683_1.var_.characterEffect1066ui_story == nil then
				arg_683_1.var_.characterEffect1066ui_story = var_686_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_686_11 = 0.200000002980232

			if var_686_10 <= arg_683_1.time_ and arg_683_1.time_ < var_686_10 + var_686_11 then
				local var_686_12 = (arg_683_1.time_ - var_686_10) / var_686_11

				if arg_683_1.var_.characterEffect1066ui_story then
					arg_683_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_683_1.time_ >= var_686_10 + var_686_11 and arg_683_1.time_ < var_686_10 + var_686_11 + arg_686_0 and arg_683_1.var_.characterEffect1066ui_story then
				arg_683_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_686_13 = 0

			if var_686_13 < arg_683_1.time_ and arg_683_1.time_ <= var_686_13 + arg_686_0 then
				arg_683_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_686_14 = 0
			local var_686_15 = 0.325

			if var_686_14 < arg_683_1.time_ and arg_683_1.time_ <= var_686_14 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_16 = arg_683_1:FormatText(StoryNameCfg[32].name)

				arg_683_1.leftNameTxt_.text = var_686_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_17 = arg_683_1:GetWordFromCfg(1106605171)
				local var_686_18 = arg_683_1:FormatText(var_686_17.content)

				arg_683_1.text_.text = var_686_18

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_19 = 13
				local var_686_20 = utf8.len(var_686_18)
				local var_686_21 = var_686_19 <= 0 and var_686_15 or var_686_15 * (var_686_20 / var_686_19)

				if var_686_21 > 0 and var_686_15 < var_686_21 then
					arg_683_1.talkMaxDuration = var_686_21

					if var_686_21 + var_686_14 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_21 + var_686_14
					end
				end

				arg_683_1.text_.text = var_686_18
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605171", "story_v_side_new_1106605.awb") ~= 0 then
					local var_686_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605171", "story_v_side_new_1106605.awb") / 1000

					if var_686_22 + var_686_14 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_22 + var_686_14
					end

					if var_686_17.prefab_name ~= "" and arg_683_1.actors_[var_686_17.prefab_name] ~= nil then
						local var_686_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_17.prefab_name].transform, "story_v_side_new_1106605", "1106605171", "story_v_side_new_1106605.awb")

						arg_683_1:RecordAudio("1106605171", var_686_23)
						arg_683_1:RecordAudio("1106605171", var_686_23)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605171", "story_v_side_new_1106605.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605171", "story_v_side_new_1106605.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_24 = math.max(var_686_15, arg_683_1.talkMaxDuration)

			if var_686_14 <= arg_683_1.time_ and arg_683_1.time_ < var_686_14 + var_686_24 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_14) / var_686_24

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_14 + var_686_24 and arg_683_1.time_ < var_686_14 + var_686_24 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605172 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 1106605172
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play1106605173(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["1066ui_story"]
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 and arg_687_1.var_.characterEffect1066ui_story == nil then
				arg_687_1.var_.characterEffect1066ui_story = var_690_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_2 = 0.200000002980232

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2

				if arg_687_1.var_.characterEffect1066ui_story then
					local var_690_4 = Mathf.Lerp(0, 0.5, var_690_3)

					arg_687_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_687_1.var_.characterEffect1066ui_story.fillRatio = var_690_4
				end
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 and arg_687_1.var_.characterEffect1066ui_story then
				local var_690_5 = 0.5

				arg_687_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_687_1.var_.characterEffect1066ui_story.fillRatio = var_690_5
			end

			local var_690_6 = 0
			local var_690_7 = 1.1

			if var_690_6 < arg_687_1.time_ and arg_687_1.time_ <= var_690_6 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_8 = arg_687_1:FormatText(StoryNameCfg[7].name)

				arg_687_1.leftNameTxt_.text = var_690_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_9 = arg_687_1:GetWordFromCfg(1106605172)
				local var_690_10 = arg_687_1:FormatText(var_690_9.content)

				arg_687_1.text_.text = var_690_10

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_11 = 44
				local var_690_12 = utf8.len(var_690_10)
				local var_690_13 = var_690_11 <= 0 and var_690_7 or var_690_7 * (var_690_12 / var_690_11)

				if var_690_13 > 0 and var_690_7 < var_690_13 then
					arg_687_1.talkMaxDuration = var_690_13

					if var_690_13 + var_690_6 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_13 + var_690_6
					end
				end

				arg_687_1.text_.text = var_690_10
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_14 = math.max(var_690_7, arg_687_1.talkMaxDuration)

			if var_690_6 <= arg_687_1.time_ and arg_687_1.time_ < var_690_6 + var_690_14 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_6) / var_690_14

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_6 + var_690_14 and arg_687_1.time_ < var_690_6 + var_690_14 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605173 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 1106605173
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play1106605174(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = 0
			local var_694_1 = 1.525

			if var_694_0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_0 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_2 = arg_691_1:FormatText(StoryNameCfg[7].name)

				arg_691_1.leftNameTxt_.text = var_694_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_3 = arg_691_1:GetWordFromCfg(1106605173)
				local var_694_4 = arg_691_1:FormatText(var_694_3.content)

				arg_691_1.text_.text = var_694_4

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_5 = 61
				local var_694_6 = utf8.len(var_694_4)
				local var_694_7 = var_694_5 <= 0 and var_694_1 or var_694_1 * (var_694_6 / var_694_5)

				if var_694_7 > 0 and var_694_1 < var_694_7 then
					arg_691_1.talkMaxDuration = var_694_7

					if var_694_7 + var_694_0 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_7 + var_694_0
					end
				end

				arg_691_1.text_.text = var_694_4
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_8 = math.max(var_694_1, arg_691_1.talkMaxDuration)

			if var_694_0 <= arg_691_1.time_ and arg_691_1.time_ < var_694_0 + var_694_8 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_0) / var_694_8

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_0 + var_694_8 and arg_691_1.time_ < var_694_0 + var_694_8 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605174 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 1106605174
		arg_695_1.duration_ = 1.999999999999

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play1106605175(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1066ui_story"].transform
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.var_.moveOldPos1066ui_story = var_698_0.localPosition
			end

			local var_698_2 = 0.001

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2
				local var_698_4 = Vector3.New(0, -0.77, -6.1)

				var_698_0.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1066ui_story, var_698_4, var_698_3)

				local var_698_5 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_5.x, var_698_5.y, var_698_5.z)

				local var_698_6 = var_698_0.localEulerAngles

				var_698_6.z = 0
				var_698_6.x = 0
				var_698_0.localEulerAngles = var_698_6
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 then
				var_698_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_698_7 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_7.x, var_698_7.y, var_698_7.z)

				local var_698_8 = var_698_0.localEulerAngles

				var_698_8.z = 0
				var_698_8.x = 0
				var_698_0.localEulerAngles = var_698_8
			end

			local var_698_9 = arg_695_1.actors_["1066ui_story"]
			local var_698_10 = 0

			if var_698_10 < arg_695_1.time_ and arg_695_1.time_ <= var_698_10 + arg_698_0 and arg_695_1.var_.characterEffect1066ui_story == nil then
				arg_695_1.var_.characterEffect1066ui_story = var_698_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_11 = 0.200000002980232

			if var_698_10 <= arg_695_1.time_ and arg_695_1.time_ < var_698_10 + var_698_11 then
				local var_698_12 = (arg_695_1.time_ - var_698_10) / var_698_11

				if arg_695_1.var_.characterEffect1066ui_story then
					arg_695_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_695_1.time_ >= var_698_10 + var_698_11 and arg_695_1.time_ < var_698_10 + var_698_11 + arg_698_0 and arg_695_1.var_.characterEffect1066ui_story then
				arg_695_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_698_13 = 0

			if var_698_13 < arg_695_1.time_ and arg_695_1.time_ <= var_698_13 + arg_698_0 then
				arg_695_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_2")
			end

			local var_698_14 = 0
			local var_698_15 = 0.1

			if var_698_14 < arg_695_1.time_ and arg_695_1.time_ <= var_698_14 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_16 = arg_695_1:FormatText(StoryNameCfg[32].name)

				arg_695_1.leftNameTxt_.text = var_698_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_17 = arg_695_1:GetWordFromCfg(1106605174)
				local var_698_18 = arg_695_1:FormatText(var_698_17.content)

				arg_695_1.text_.text = var_698_18

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_19 = 4
				local var_698_20 = utf8.len(var_698_18)
				local var_698_21 = var_698_19 <= 0 and var_698_15 or var_698_15 * (var_698_20 / var_698_19)

				if var_698_21 > 0 and var_698_15 < var_698_21 then
					arg_695_1.talkMaxDuration = var_698_21

					if var_698_21 + var_698_14 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_21 + var_698_14
					end
				end

				arg_695_1.text_.text = var_698_18
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605174", "story_v_side_new_1106605.awb") ~= 0 then
					local var_698_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605174", "story_v_side_new_1106605.awb") / 1000

					if var_698_22 + var_698_14 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_22 + var_698_14
					end

					if var_698_17.prefab_name ~= "" and arg_695_1.actors_[var_698_17.prefab_name] ~= nil then
						local var_698_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_695_1.actors_[var_698_17.prefab_name].transform, "story_v_side_new_1106605", "1106605174", "story_v_side_new_1106605.awb")

						arg_695_1:RecordAudio("1106605174", var_698_23)
						arg_695_1:RecordAudio("1106605174", var_698_23)
					else
						arg_695_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605174", "story_v_side_new_1106605.awb")
					end

					arg_695_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605174", "story_v_side_new_1106605.awb")
				end

				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_24 = math.max(var_698_15, arg_695_1.talkMaxDuration)

			if var_698_14 <= arg_695_1.time_ and arg_695_1.time_ < var_698_14 + var_698_24 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_14) / var_698_24

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_14 + var_698_24 and arg_695_1.time_ < var_698_14 + var_698_24 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605175 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 1106605175
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play1106605176(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1066ui_story"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and arg_699_1.var_.characterEffect1066ui_story == nil then
				arg_699_1.var_.characterEffect1066ui_story = var_702_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_2 = 0.200000002980232

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.characterEffect1066ui_story then
					local var_702_4 = Mathf.Lerp(0, 0.5, var_702_3)

					arg_699_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_699_1.var_.characterEffect1066ui_story.fillRatio = var_702_4
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and arg_699_1.var_.characterEffect1066ui_story then
				local var_702_5 = 0.5

				arg_699_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_699_1.var_.characterEffect1066ui_story.fillRatio = var_702_5
			end

			local var_702_6 = 0
			local var_702_7 = 0.8

			if var_702_6 < arg_699_1.time_ and arg_699_1.time_ <= var_702_6 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_8 = arg_699_1:GetWordFromCfg(1106605175)
				local var_702_9 = arg_699_1:FormatText(var_702_8.content)

				arg_699_1.text_.text = var_702_9

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_10 = 32
				local var_702_11 = utf8.len(var_702_9)
				local var_702_12 = var_702_10 <= 0 and var_702_7 or var_702_7 * (var_702_11 / var_702_10)

				if var_702_12 > 0 and var_702_7 < var_702_12 then
					arg_699_1.talkMaxDuration = var_702_12

					if var_702_12 + var_702_6 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_12 + var_702_6
					end
				end

				arg_699_1.text_.text = var_702_9
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_13 = math.max(var_702_7, arg_699_1.talkMaxDuration)

			if var_702_6 <= arg_699_1.time_ and arg_699_1.time_ < var_702_6 + var_702_13 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_6) / var_702_13

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_6 + var_702_13 and arg_699_1.time_ < var_702_6 + var_702_13 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605176 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 1106605176
		arg_703_1.duration_ = 7.366

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play1106605177(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1066ui_story"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos1066ui_story = var_706_0.localPosition
			end

			local var_706_2 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_2 then
				local var_706_3 = (arg_703_1.time_ - var_706_1) / var_706_2
				local var_706_4 = Vector3.New(0, -0.77, -6.1)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1066ui_story, var_706_4, var_706_3)

				local var_706_5 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_5.x, var_706_5.y, var_706_5.z)

				local var_706_6 = var_706_0.localEulerAngles

				var_706_6.z = 0
				var_706_6.x = 0
				var_706_0.localEulerAngles = var_706_6
			end

			if arg_703_1.time_ >= var_706_1 + var_706_2 and arg_703_1.time_ < var_706_1 + var_706_2 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_706_7 = manager.ui.mainCamera.transform.position - var_706_0.position

				var_706_0.forward = Vector3.New(var_706_7.x, var_706_7.y, var_706_7.z)

				local var_706_8 = var_706_0.localEulerAngles

				var_706_8.z = 0
				var_706_8.x = 0
				var_706_0.localEulerAngles = var_706_8
			end

			local var_706_9 = arg_703_1.actors_["1066ui_story"]
			local var_706_10 = 0

			if var_706_10 < arg_703_1.time_ and arg_703_1.time_ <= var_706_10 + arg_706_0 and arg_703_1.var_.characterEffect1066ui_story == nil then
				arg_703_1.var_.characterEffect1066ui_story = var_706_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_706_11 = 0.200000002980232

			if var_706_10 <= arg_703_1.time_ and arg_703_1.time_ < var_706_10 + var_706_11 then
				local var_706_12 = (arg_703_1.time_ - var_706_10) / var_706_11

				if arg_703_1.var_.characterEffect1066ui_story then
					arg_703_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_703_1.time_ >= var_706_10 + var_706_11 and arg_703_1.time_ < var_706_10 + var_706_11 + arg_706_0 and arg_703_1.var_.characterEffect1066ui_story then
				arg_703_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_706_13 = 0

			if var_706_13 < arg_703_1.time_ and arg_703_1.time_ <= var_706_13 + arg_706_0 then
				arg_703_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_706_14 = 0

			if var_706_14 < arg_703_1.time_ and arg_703_1.time_ <= var_706_14 + arg_706_0 then
				arg_703_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_706_15 = 0
			local var_706_16 = 0.8

			if var_706_15 < arg_703_1.time_ and arg_703_1.time_ <= var_706_15 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_17 = arg_703_1:FormatText(StoryNameCfg[32].name)

				arg_703_1.leftNameTxt_.text = var_706_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_18 = arg_703_1:GetWordFromCfg(1106605176)
				local var_706_19 = arg_703_1:FormatText(var_706_18.content)

				arg_703_1.text_.text = var_706_19

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_20 = 32
				local var_706_21 = utf8.len(var_706_19)
				local var_706_22 = var_706_20 <= 0 and var_706_16 or var_706_16 * (var_706_21 / var_706_20)

				if var_706_22 > 0 and var_706_16 < var_706_22 then
					arg_703_1.talkMaxDuration = var_706_22

					if var_706_22 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_22 + var_706_15
					end
				end

				arg_703_1.text_.text = var_706_19
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605176", "story_v_side_new_1106605.awb") ~= 0 then
					local var_706_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605176", "story_v_side_new_1106605.awb") / 1000

					if var_706_23 + var_706_15 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_23 + var_706_15
					end

					if var_706_18.prefab_name ~= "" and arg_703_1.actors_[var_706_18.prefab_name] ~= nil then
						local var_706_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_703_1.actors_[var_706_18.prefab_name].transform, "story_v_side_new_1106605", "1106605176", "story_v_side_new_1106605.awb")

						arg_703_1:RecordAudio("1106605176", var_706_24)
						arg_703_1:RecordAudio("1106605176", var_706_24)
					else
						arg_703_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605176", "story_v_side_new_1106605.awb")
					end

					arg_703_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605176", "story_v_side_new_1106605.awb")
				end

				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_25 = math.max(var_706_16, arg_703_1.talkMaxDuration)

			if var_706_15 <= arg_703_1.time_ and arg_703_1.time_ < var_706_15 + var_706_25 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_15) / var_706_25

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_15 + var_706_25 and arg_703_1.time_ < var_706_15 + var_706_25 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605177 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 1106605177
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play1106605178(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1066ui_story"]
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 and arg_707_1.var_.characterEffect1066ui_story == nil then
				arg_707_1.var_.characterEffect1066ui_story = var_710_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_2 = 0.200000002980232

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2

				if arg_707_1.var_.characterEffect1066ui_story then
					local var_710_4 = Mathf.Lerp(0, 0.5, var_710_3)

					arg_707_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_707_1.var_.characterEffect1066ui_story.fillRatio = var_710_4
				end
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 and arg_707_1.var_.characterEffect1066ui_story then
				local var_710_5 = 0.5

				arg_707_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_707_1.var_.characterEffect1066ui_story.fillRatio = var_710_5
			end

			local var_710_6 = 0
			local var_710_7 = 0.525

			if var_710_6 < arg_707_1.time_ and arg_707_1.time_ <= var_710_6 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_8 = arg_707_1:FormatText(StoryNameCfg[7].name)

				arg_707_1.leftNameTxt_.text = var_710_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_9 = arg_707_1:GetWordFromCfg(1106605177)
				local var_710_10 = arg_707_1:FormatText(var_710_9.content)

				arg_707_1.text_.text = var_710_10

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_11 = 21
				local var_710_12 = utf8.len(var_710_10)
				local var_710_13 = var_710_11 <= 0 and var_710_7 or var_710_7 * (var_710_12 / var_710_11)

				if var_710_13 > 0 and var_710_7 < var_710_13 then
					arg_707_1.talkMaxDuration = var_710_13

					if var_710_13 + var_710_6 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_13 + var_710_6
					end
				end

				arg_707_1.text_.text = var_710_10
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_14 = math.max(var_710_7, arg_707_1.talkMaxDuration)

			if var_710_6 <= arg_707_1.time_ and arg_707_1.time_ < var_710_6 + var_710_14 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_6) / var_710_14

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_6 + var_710_14 and arg_707_1.time_ < var_710_6 + var_710_14 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605178 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 1106605178
		arg_711_1.duration_ = 3.8

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play1106605179(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1066ui_story"].transform
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 then
				arg_711_1.var_.moveOldPos1066ui_story = var_714_0.localPosition
			end

			local var_714_2 = 0.001

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2
				local var_714_4 = Vector3.New(0, -0.77, -6.1)

				var_714_0.localPosition = Vector3.Lerp(arg_711_1.var_.moveOldPos1066ui_story, var_714_4, var_714_3)

				local var_714_5 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_5.x, var_714_5.y, var_714_5.z)

				local var_714_6 = var_714_0.localEulerAngles

				var_714_6.z = 0
				var_714_6.x = 0
				var_714_0.localEulerAngles = var_714_6
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 then
				var_714_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_714_7 = manager.ui.mainCamera.transform.position - var_714_0.position

				var_714_0.forward = Vector3.New(var_714_7.x, var_714_7.y, var_714_7.z)

				local var_714_8 = var_714_0.localEulerAngles

				var_714_8.z = 0
				var_714_8.x = 0
				var_714_0.localEulerAngles = var_714_8
			end

			local var_714_9 = arg_711_1.actors_["1066ui_story"]
			local var_714_10 = 0

			if var_714_10 < arg_711_1.time_ and arg_711_1.time_ <= var_714_10 + arg_714_0 and arg_711_1.var_.characterEffect1066ui_story == nil then
				arg_711_1.var_.characterEffect1066ui_story = var_714_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_11 = 0.200000002980232

			if var_714_10 <= arg_711_1.time_ and arg_711_1.time_ < var_714_10 + var_714_11 then
				local var_714_12 = (arg_711_1.time_ - var_714_10) / var_714_11

				if arg_711_1.var_.characterEffect1066ui_story then
					arg_711_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_711_1.time_ >= var_714_10 + var_714_11 and arg_711_1.time_ < var_714_10 + var_714_11 + arg_714_0 and arg_711_1.var_.characterEffect1066ui_story then
				arg_711_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_714_13 = 0

			if var_714_13 < arg_711_1.time_ and arg_711_1.time_ <= var_714_13 + arg_714_0 then
				arg_711_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_714_14 = 0
			local var_714_15 = 0.375

			if var_714_14 < arg_711_1.time_ and arg_711_1.time_ <= var_714_14 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_16 = arg_711_1:FormatText(StoryNameCfg[32].name)

				arg_711_1.leftNameTxt_.text = var_714_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_17 = arg_711_1:GetWordFromCfg(1106605178)
				local var_714_18 = arg_711_1:FormatText(var_714_17.content)

				arg_711_1.text_.text = var_714_18

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_19 = 15
				local var_714_20 = utf8.len(var_714_18)
				local var_714_21 = var_714_19 <= 0 and var_714_15 or var_714_15 * (var_714_20 / var_714_19)

				if var_714_21 > 0 and var_714_15 < var_714_21 then
					arg_711_1.talkMaxDuration = var_714_21

					if var_714_21 + var_714_14 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_21 + var_714_14
					end
				end

				arg_711_1.text_.text = var_714_18
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605178", "story_v_side_new_1106605.awb") ~= 0 then
					local var_714_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605178", "story_v_side_new_1106605.awb") / 1000

					if var_714_22 + var_714_14 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_22 + var_714_14
					end

					if var_714_17.prefab_name ~= "" and arg_711_1.actors_[var_714_17.prefab_name] ~= nil then
						local var_714_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_17.prefab_name].transform, "story_v_side_new_1106605", "1106605178", "story_v_side_new_1106605.awb")

						arg_711_1:RecordAudio("1106605178", var_714_23)
						arg_711_1:RecordAudio("1106605178", var_714_23)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605178", "story_v_side_new_1106605.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605178", "story_v_side_new_1106605.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_24 = math.max(var_714_15, arg_711_1.talkMaxDuration)

			if var_714_14 <= arg_711_1.time_ and arg_711_1.time_ < var_714_14 + var_714_24 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_14) / var_714_24

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_14 + var_714_24 and arg_711_1.time_ < var_714_14 + var_714_24 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605179 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 1106605179
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play1106605180(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["1066ui_story"]
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 and arg_715_1.var_.characterEffect1066ui_story == nil then
				arg_715_1.var_.characterEffect1066ui_story = var_718_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_718_2 = 0.200000002980232

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2

				if arg_715_1.var_.characterEffect1066ui_story then
					local var_718_4 = Mathf.Lerp(0, 0.5, var_718_3)

					arg_715_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_715_1.var_.characterEffect1066ui_story.fillRatio = var_718_4
				end
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 and arg_715_1.var_.characterEffect1066ui_story then
				local var_718_5 = 0.5

				arg_715_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_715_1.var_.characterEffect1066ui_story.fillRatio = var_718_5
			end

			local var_718_6 = 0
			local var_718_7 = 1.625

			if var_718_6 < arg_715_1.time_ and arg_715_1.time_ <= var_718_6 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_8 = arg_715_1:FormatText(StoryNameCfg[7].name)

				arg_715_1.leftNameTxt_.text = var_718_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_9 = arg_715_1:GetWordFromCfg(1106605179)
				local var_718_10 = arg_715_1:FormatText(var_718_9.content)

				arg_715_1.text_.text = var_718_10

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_11 = 65
				local var_718_12 = utf8.len(var_718_10)
				local var_718_13 = var_718_11 <= 0 and var_718_7 or var_718_7 * (var_718_12 / var_718_11)

				if var_718_13 > 0 and var_718_7 < var_718_13 then
					arg_715_1.talkMaxDuration = var_718_13

					if var_718_13 + var_718_6 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_13 + var_718_6
					end
				end

				arg_715_1.text_.text = var_718_10
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_14 = math.max(var_718_7, arg_715_1.talkMaxDuration)

			if var_718_6 <= arg_715_1.time_ and arg_715_1.time_ < var_718_6 + var_718_14 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_6) / var_718_14

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_6 + var_718_14 and arg_715_1.time_ < var_718_6 + var_718_14 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605180 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 1106605180
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play1106605181(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0
			local var_722_1 = 0.5

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_2 = arg_719_1:FormatText(StoryNameCfg[7].name)

				arg_719_1.leftNameTxt_.text = var_722_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_3 = arg_719_1:GetWordFromCfg(1106605180)
				local var_722_4 = arg_719_1:FormatText(var_722_3.content)

				arg_719_1.text_.text = var_722_4

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_5 = 20
				local var_722_6 = utf8.len(var_722_4)
				local var_722_7 = var_722_5 <= 0 and var_722_1 or var_722_1 * (var_722_6 / var_722_5)

				if var_722_7 > 0 and var_722_1 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_0
					end
				end

				arg_719_1.text_.text = var_722_4
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_8 = math.max(var_722_1, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_8 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_0) / var_722_8

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_8 and arg_719_1.time_ < var_722_0 + var_722_8 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605181 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 1106605181
		arg_723_1.duration_ = 1.999999999999

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play1106605182(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = arg_723_1.actors_["1066ui_story"].transform
			local var_726_1 = 0

			if var_726_1 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.var_.moveOldPos1066ui_story = var_726_0.localPosition
			end

			local var_726_2 = 0.001

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_2 then
				local var_726_3 = (arg_723_1.time_ - var_726_1) / var_726_2
				local var_726_4 = Vector3.New(0, -0.77, -6.1)

				var_726_0.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1066ui_story, var_726_4, var_726_3)

				local var_726_5 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_5.x, var_726_5.y, var_726_5.z)

				local var_726_6 = var_726_0.localEulerAngles

				var_726_6.z = 0
				var_726_6.x = 0
				var_726_0.localEulerAngles = var_726_6
			end

			if arg_723_1.time_ >= var_726_1 + var_726_2 and arg_723_1.time_ < var_726_1 + var_726_2 + arg_726_0 then
				var_726_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_726_7 = manager.ui.mainCamera.transform.position - var_726_0.position

				var_726_0.forward = Vector3.New(var_726_7.x, var_726_7.y, var_726_7.z)

				local var_726_8 = var_726_0.localEulerAngles

				var_726_8.z = 0
				var_726_8.x = 0
				var_726_0.localEulerAngles = var_726_8
			end

			local var_726_9 = arg_723_1.actors_["1066ui_story"]
			local var_726_10 = 0

			if var_726_10 < arg_723_1.time_ and arg_723_1.time_ <= var_726_10 + arg_726_0 and arg_723_1.var_.characterEffect1066ui_story == nil then
				arg_723_1.var_.characterEffect1066ui_story = var_726_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_11 = 0.200000002980232

			if var_726_10 <= arg_723_1.time_ and arg_723_1.time_ < var_726_10 + var_726_11 then
				local var_726_12 = (arg_723_1.time_ - var_726_10) / var_726_11

				if arg_723_1.var_.characterEffect1066ui_story then
					arg_723_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= var_726_10 + var_726_11 and arg_723_1.time_ < var_726_10 + var_726_11 + arg_726_0 and arg_723_1.var_.characterEffect1066ui_story then
				arg_723_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_726_13 = 0

			if var_726_13 < arg_723_1.time_ and arg_723_1.time_ <= var_726_13 + arg_726_0 then
				arg_723_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_726_14 = 0
			local var_726_15 = 0.05

			if var_726_14 < arg_723_1.time_ and arg_723_1.time_ <= var_726_14 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_16 = arg_723_1:FormatText(StoryNameCfg[32].name)

				arg_723_1.leftNameTxt_.text = var_726_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_17 = arg_723_1:GetWordFromCfg(1106605181)
				local var_726_18 = arg_723_1:FormatText(var_726_17.content)

				arg_723_1.text_.text = var_726_18

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_19 = 2
				local var_726_20 = utf8.len(var_726_18)
				local var_726_21 = var_726_19 <= 0 and var_726_15 or var_726_15 * (var_726_20 / var_726_19)

				if var_726_21 > 0 and var_726_15 < var_726_21 then
					arg_723_1.talkMaxDuration = var_726_21

					if var_726_21 + var_726_14 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_21 + var_726_14
					end
				end

				arg_723_1.text_.text = var_726_18
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605181", "story_v_side_new_1106605.awb") ~= 0 then
					local var_726_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605181", "story_v_side_new_1106605.awb") / 1000

					if var_726_22 + var_726_14 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_22 + var_726_14
					end

					if var_726_17.prefab_name ~= "" and arg_723_1.actors_[var_726_17.prefab_name] ~= nil then
						local var_726_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_17.prefab_name].transform, "story_v_side_new_1106605", "1106605181", "story_v_side_new_1106605.awb")

						arg_723_1:RecordAudio("1106605181", var_726_23)
						arg_723_1:RecordAudio("1106605181", var_726_23)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605181", "story_v_side_new_1106605.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605181", "story_v_side_new_1106605.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_24 = math.max(var_726_15, arg_723_1.talkMaxDuration)

			if var_726_14 <= arg_723_1.time_ and arg_723_1.time_ < var_726_14 + var_726_24 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_14) / var_726_24

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_14 + var_726_24 and arg_723_1.time_ < var_726_14 + var_726_24 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605182 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 1106605182
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play1106605183(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["1066ui_story"]
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 and arg_727_1.var_.characterEffect1066ui_story == nil then
				arg_727_1.var_.characterEffect1066ui_story = var_730_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_2 = 0.200000002980232

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2

				if arg_727_1.var_.characterEffect1066ui_story then
					local var_730_4 = Mathf.Lerp(0, 0.5, var_730_3)

					arg_727_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_727_1.var_.characterEffect1066ui_story.fillRatio = var_730_4
				end
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 and arg_727_1.var_.characterEffect1066ui_story then
				local var_730_5 = 0.5

				arg_727_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_727_1.var_.characterEffect1066ui_story.fillRatio = var_730_5
			end

			local var_730_6 = 0
			local var_730_7 = 0.825

			if var_730_6 < arg_727_1.time_ and arg_727_1.time_ <= var_730_6 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_8 = arg_727_1:GetWordFromCfg(1106605182)
				local var_730_9 = arg_727_1:FormatText(var_730_8.content)

				arg_727_1.text_.text = var_730_9

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_10 = 33
				local var_730_11 = utf8.len(var_730_9)
				local var_730_12 = var_730_10 <= 0 and var_730_7 or var_730_7 * (var_730_11 / var_730_10)

				if var_730_12 > 0 and var_730_7 < var_730_12 then
					arg_727_1.talkMaxDuration = var_730_12

					if var_730_12 + var_730_6 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_12 + var_730_6
					end
				end

				arg_727_1.text_.text = var_730_9
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_13 = math.max(var_730_7, arg_727_1.talkMaxDuration)

			if var_730_6 <= arg_727_1.time_ and arg_727_1.time_ < var_730_6 + var_730_13 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_6) / var_730_13

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_6 + var_730_13 and arg_727_1.time_ < var_730_6 + var_730_13 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605183 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 1106605183
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play1106605184(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0
			local var_734_1 = 1.425

			if var_734_0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_2 = arg_731_1:FormatText(StoryNameCfg[7].name)

				arg_731_1.leftNameTxt_.text = var_734_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_3 = arg_731_1:GetWordFromCfg(1106605183)
				local var_734_4 = arg_731_1:FormatText(var_734_3.content)

				arg_731_1.text_.text = var_734_4

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 57
				local var_734_6 = utf8.len(var_734_4)
				local var_734_7 = var_734_5 <= 0 and var_734_1 or var_734_1 * (var_734_6 / var_734_5)

				if var_734_7 > 0 and var_734_1 < var_734_7 then
					arg_731_1.talkMaxDuration = var_734_7

					if var_734_7 + var_734_0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_7 + var_734_0
					end
				end

				arg_731_1.text_.text = var_734_4
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_8 = math.max(var_734_1, arg_731_1.talkMaxDuration)

			if var_734_0 <= arg_731_1.time_ and arg_731_1.time_ < var_734_0 + var_734_8 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_0) / var_734_8

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_0 + var_734_8 and arg_731_1.time_ < var_734_0 + var_734_8 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605184 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 1106605184
		arg_735_1.duration_ = 2.466

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play1106605185(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = arg_735_1.actors_["1066ui_story"].transform
			local var_738_1 = 0

			if var_738_1 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 then
				arg_735_1.var_.moveOldPos1066ui_story = var_738_0.localPosition
			end

			local var_738_2 = 0.001

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_2 then
				local var_738_3 = (arg_735_1.time_ - var_738_1) / var_738_2
				local var_738_4 = Vector3.New(0, -0.77, -6.1)

				var_738_0.localPosition = Vector3.Lerp(arg_735_1.var_.moveOldPos1066ui_story, var_738_4, var_738_3)

				local var_738_5 = manager.ui.mainCamera.transform.position - var_738_0.position

				var_738_0.forward = Vector3.New(var_738_5.x, var_738_5.y, var_738_5.z)

				local var_738_6 = var_738_0.localEulerAngles

				var_738_6.z = 0
				var_738_6.x = 0
				var_738_0.localEulerAngles = var_738_6
			end

			if arg_735_1.time_ >= var_738_1 + var_738_2 and arg_735_1.time_ < var_738_1 + var_738_2 + arg_738_0 then
				var_738_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_738_7 = manager.ui.mainCamera.transform.position - var_738_0.position

				var_738_0.forward = Vector3.New(var_738_7.x, var_738_7.y, var_738_7.z)

				local var_738_8 = var_738_0.localEulerAngles

				var_738_8.z = 0
				var_738_8.x = 0
				var_738_0.localEulerAngles = var_738_8
			end

			local var_738_9 = arg_735_1.actors_["1066ui_story"]
			local var_738_10 = 0

			if var_738_10 < arg_735_1.time_ and arg_735_1.time_ <= var_738_10 + arg_738_0 and arg_735_1.var_.characterEffect1066ui_story == nil then
				arg_735_1.var_.characterEffect1066ui_story = var_738_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_11 = 0.200000002980232

			if var_738_10 <= arg_735_1.time_ and arg_735_1.time_ < var_738_10 + var_738_11 then
				local var_738_12 = (arg_735_1.time_ - var_738_10) / var_738_11

				if arg_735_1.var_.characterEffect1066ui_story then
					arg_735_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_735_1.time_ >= var_738_10 + var_738_11 and arg_735_1.time_ < var_738_10 + var_738_11 + arg_738_0 and arg_735_1.var_.characterEffect1066ui_story then
				arg_735_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_738_13 = 0

			if var_738_13 < arg_735_1.time_ and arg_735_1.time_ <= var_738_13 + arg_738_0 then
				arg_735_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_738_14 = 0

			if var_738_14 < arg_735_1.time_ and arg_735_1.time_ <= var_738_14 + arg_738_0 then
				arg_735_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_2")
			end

			local var_738_15 = 0
			local var_738_16 = 0.35

			if var_738_15 < arg_735_1.time_ and arg_735_1.time_ <= var_738_15 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				local var_738_17 = arg_735_1:FormatText(StoryNameCfg[32].name)

				arg_735_1.leftNameTxt_.text = var_738_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_18 = arg_735_1:GetWordFromCfg(1106605184)
				local var_738_19 = arg_735_1:FormatText(var_738_18.content)

				arg_735_1.text_.text = var_738_19

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_20 = 14
				local var_738_21 = utf8.len(var_738_19)
				local var_738_22 = var_738_20 <= 0 and var_738_16 or var_738_16 * (var_738_21 / var_738_20)

				if var_738_22 > 0 and var_738_16 < var_738_22 then
					arg_735_1.talkMaxDuration = var_738_22

					if var_738_22 + var_738_15 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_22 + var_738_15
					end
				end

				arg_735_1.text_.text = var_738_19
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605184", "story_v_side_new_1106605.awb") ~= 0 then
					local var_738_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605184", "story_v_side_new_1106605.awb") / 1000

					if var_738_23 + var_738_15 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_23 + var_738_15
					end

					if var_738_18.prefab_name ~= "" and arg_735_1.actors_[var_738_18.prefab_name] ~= nil then
						local var_738_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_735_1.actors_[var_738_18.prefab_name].transform, "story_v_side_new_1106605", "1106605184", "story_v_side_new_1106605.awb")

						arg_735_1:RecordAudio("1106605184", var_738_24)
						arg_735_1:RecordAudio("1106605184", var_738_24)
					else
						arg_735_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605184", "story_v_side_new_1106605.awb")
					end

					arg_735_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605184", "story_v_side_new_1106605.awb")
				end

				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_25 = math.max(var_738_16, arg_735_1.talkMaxDuration)

			if var_738_15 <= arg_735_1.time_ and arg_735_1.time_ < var_738_15 + var_738_25 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_15) / var_738_25

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_15 + var_738_25 and arg_735_1.time_ < var_738_15 + var_738_25 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605185 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 1106605185
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play1106605186(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = arg_739_1.actors_["1066ui_story"]
			local var_742_1 = 0

			if var_742_1 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 and arg_739_1.var_.characterEffect1066ui_story == nil then
				arg_739_1.var_.characterEffect1066ui_story = var_742_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_2 = 0.200000002980232

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_2 then
				local var_742_3 = (arg_739_1.time_ - var_742_1) / var_742_2

				if arg_739_1.var_.characterEffect1066ui_story then
					local var_742_4 = Mathf.Lerp(0, 0.5, var_742_3)

					arg_739_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_739_1.var_.characterEffect1066ui_story.fillRatio = var_742_4
				end
			end

			if arg_739_1.time_ >= var_742_1 + var_742_2 and arg_739_1.time_ < var_742_1 + var_742_2 + arg_742_0 and arg_739_1.var_.characterEffect1066ui_story then
				local var_742_5 = 0.5

				arg_739_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_739_1.var_.characterEffect1066ui_story.fillRatio = var_742_5
			end

			local var_742_6 = 0
			local var_742_7 = 1.175

			if var_742_6 < arg_739_1.time_ and arg_739_1.time_ <= var_742_6 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, false)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_8 = arg_739_1:GetWordFromCfg(1106605185)
				local var_742_9 = arg_739_1:FormatText(var_742_8.content)

				arg_739_1.text_.text = var_742_9

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_10 = 47
				local var_742_11 = utf8.len(var_742_9)
				local var_742_12 = var_742_10 <= 0 and var_742_7 or var_742_7 * (var_742_11 / var_742_10)

				if var_742_12 > 0 and var_742_7 < var_742_12 then
					arg_739_1.talkMaxDuration = var_742_12

					if var_742_12 + var_742_6 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_12 + var_742_6
					end
				end

				arg_739_1.text_.text = var_742_9
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_13 = math.max(var_742_7, arg_739_1.talkMaxDuration)

			if var_742_6 <= arg_739_1.time_ and arg_739_1.time_ < var_742_6 + var_742_13 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_6) / var_742_13

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_6 + var_742_13 and arg_739_1.time_ < var_742_6 + var_742_13 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605186 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 1106605186
		arg_743_1.duration_ = 5.3

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play1106605187(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = arg_743_1.actors_["1066ui_story"].transform
			local var_746_1 = 0

			if var_746_1 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 then
				arg_743_1.var_.moveOldPos1066ui_story = var_746_0.localPosition
			end

			local var_746_2 = 0.001

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_2 then
				local var_746_3 = (arg_743_1.time_ - var_746_1) / var_746_2
				local var_746_4 = Vector3.New(0, -0.77, -6.1)

				var_746_0.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos1066ui_story, var_746_4, var_746_3)

				local var_746_5 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_5.x, var_746_5.y, var_746_5.z)

				local var_746_6 = var_746_0.localEulerAngles

				var_746_6.z = 0
				var_746_6.x = 0
				var_746_0.localEulerAngles = var_746_6
			end

			if arg_743_1.time_ >= var_746_1 + var_746_2 and arg_743_1.time_ < var_746_1 + var_746_2 + arg_746_0 then
				var_746_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_746_7 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_7.x, var_746_7.y, var_746_7.z)

				local var_746_8 = var_746_0.localEulerAngles

				var_746_8.z = 0
				var_746_8.x = 0
				var_746_0.localEulerAngles = var_746_8
			end

			local var_746_9 = arg_743_1.actors_["1066ui_story"]
			local var_746_10 = 0

			if var_746_10 < arg_743_1.time_ and arg_743_1.time_ <= var_746_10 + arg_746_0 and arg_743_1.var_.characterEffect1066ui_story == nil then
				arg_743_1.var_.characterEffect1066ui_story = var_746_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_11 = 0.200000002980232

			if var_746_10 <= arg_743_1.time_ and arg_743_1.time_ < var_746_10 + var_746_11 then
				local var_746_12 = (arg_743_1.time_ - var_746_10) / var_746_11

				if arg_743_1.var_.characterEffect1066ui_story then
					arg_743_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_743_1.time_ >= var_746_10 + var_746_11 and arg_743_1.time_ < var_746_10 + var_746_11 + arg_746_0 and arg_743_1.var_.characterEffect1066ui_story then
				arg_743_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_746_13 = 0

			if var_746_13 < arg_743_1.time_ and arg_743_1.time_ <= var_746_13 + arg_746_0 then
				arg_743_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_746_14 = 0
			local var_746_15 = 0.525

			if var_746_14 < arg_743_1.time_ and arg_743_1.time_ <= var_746_14 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_16 = arg_743_1:FormatText(StoryNameCfg[32].name)

				arg_743_1.leftNameTxt_.text = var_746_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_17 = arg_743_1:GetWordFromCfg(1106605186)
				local var_746_18 = arg_743_1:FormatText(var_746_17.content)

				arg_743_1.text_.text = var_746_18

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_19 = 21
				local var_746_20 = utf8.len(var_746_18)
				local var_746_21 = var_746_19 <= 0 and var_746_15 or var_746_15 * (var_746_20 / var_746_19)

				if var_746_21 > 0 and var_746_15 < var_746_21 then
					arg_743_1.talkMaxDuration = var_746_21

					if var_746_21 + var_746_14 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_21 + var_746_14
					end
				end

				arg_743_1.text_.text = var_746_18
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605186", "story_v_side_new_1106605.awb") ~= 0 then
					local var_746_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605186", "story_v_side_new_1106605.awb") / 1000

					if var_746_22 + var_746_14 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_22 + var_746_14
					end

					if var_746_17.prefab_name ~= "" and arg_743_1.actors_[var_746_17.prefab_name] ~= nil then
						local var_746_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_743_1.actors_[var_746_17.prefab_name].transform, "story_v_side_new_1106605", "1106605186", "story_v_side_new_1106605.awb")

						arg_743_1:RecordAudio("1106605186", var_746_23)
						arg_743_1:RecordAudio("1106605186", var_746_23)
					else
						arg_743_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605186", "story_v_side_new_1106605.awb")
					end

					arg_743_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605186", "story_v_side_new_1106605.awb")
				end

				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_24 = math.max(var_746_15, arg_743_1.talkMaxDuration)

			if var_746_14 <= arg_743_1.time_ and arg_743_1.time_ < var_746_14 + var_746_24 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_14) / var_746_24

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_14 + var_746_24 and arg_743_1.time_ < var_746_14 + var_746_24 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605187 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 1106605187
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play1106605188(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = arg_747_1.actors_["1066ui_story"]
			local var_750_1 = 0

			if var_750_1 < arg_747_1.time_ and arg_747_1.time_ <= var_750_1 + arg_750_0 and arg_747_1.var_.characterEffect1066ui_story == nil then
				arg_747_1.var_.characterEffect1066ui_story = var_750_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_2 = 0.200000002980232

			if var_750_1 <= arg_747_1.time_ and arg_747_1.time_ < var_750_1 + var_750_2 then
				local var_750_3 = (arg_747_1.time_ - var_750_1) / var_750_2

				if arg_747_1.var_.characterEffect1066ui_story then
					local var_750_4 = Mathf.Lerp(0, 0.5, var_750_3)

					arg_747_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_747_1.var_.characterEffect1066ui_story.fillRatio = var_750_4
				end
			end

			if arg_747_1.time_ >= var_750_1 + var_750_2 and arg_747_1.time_ < var_750_1 + var_750_2 + arg_750_0 and arg_747_1.var_.characterEffect1066ui_story then
				local var_750_5 = 0.5

				arg_747_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_747_1.var_.characterEffect1066ui_story.fillRatio = var_750_5
			end

			local var_750_6 = 0
			local var_750_7 = 1.225

			if var_750_6 < arg_747_1.time_ and arg_747_1.time_ <= var_750_6 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_8 = arg_747_1:FormatText(StoryNameCfg[7].name)

				arg_747_1.leftNameTxt_.text = var_750_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_9 = arg_747_1:GetWordFromCfg(1106605187)
				local var_750_10 = arg_747_1:FormatText(var_750_9.content)

				arg_747_1.text_.text = var_750_10

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_11 = 49
				local var_750_12 = utf8.len(var_750_10)
				local var_750_13 = var_750_11 <= 0 and var_750_7 or var_750_7 * (var_750_12 / var_750_11)

				if var_750_13 > 0 and var_750_7 < var_750_13 then
					arg_747_1.talkMaxDuration = var_750_13

					if var_750_13 + var_750_6 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_13 + var_750_6
					end
				end

				arg_747_1.text_.text = var_750_10
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_14 = math.max(var_750_7, arg_747_1.talkMaxDuration)

			if var_750_6 <= arg_747_1.time_ and arg_747_1.time_ < var_750_6 + var_750_14 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_6) / var_750_14

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_6 + var_750_14 and arg_747_1.time_ < var_750_6 + var_750_14 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605188 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 1106605188
		arg_751_1.duration_ = 2.166

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play1106605189(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = arg_751_1.actors_["1066ui_story"].transform
			local var_754_1 = 0

			if var_754_1 < arg_751_1.time_ and arg_751_1.time_ <= var_754_1 + arg_754_0 then
				arg_751_1.var_.moveOldPos1066ui_story = var_754_0.localPosition
			end

			local var_754_2 = 0.001

			if var_754_1 <= arg_751_1.time_ and arg_751_1.time_ < var_754_1 + var_754_2 then
				local var_754_3 = (arg_751_1.time_ - var_754_1) / var_754_2
				local var_754_4 = Vector3.New(0, -0.77, -6.1)

				var_754_0.localPosition = Vector3.Lerp(arg_751_1.var_.moveOldPos1066ui_story, var_754_4, var_754_3)

				local var_754_5 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_5.x, var_754_5.y, var_754_5.z)

				local var_754_6 = var_754_0.localEulerAngles

				var_754_6.z = 0
				var_754_6.x = 0
				var_754_0.localEulerAngles = var_754_6
			end

			if arg_751_1.time_ >= var_754_1 + var_754_2 and arg_751_1.time_ < var_754_1 + var_754_2 + arg_754_0 then
				var_754_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_754_7 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_7.x, var_754_7.y, var_754_7.z)

				local var_754_8 = var_754_0.localEulerAngles

				var_754_8.z = 0
				var_754_8.x = 0
				var_754_0.localEulerAngles = var_754_8
			end

			local var_754_9 = arg_751_1.actors_["1066ui_story"]
			local var_754_10 = 0

			if var_754_10 < arg_751_1.time_ and arg_751_1.time_ <= var_754_10 + arg_754_0 and arg_751_1.var_.characterEffect1066ui_story == nil then
				arg_751_1.var_.characterEffect1066ui_story = var_754_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_11 = 0.200000002980232

			if var_754_10 <= arg_751_1.time_ and arg_751_1.time_ < var_754_10 + var_754_11 then
				local var_754_12 = (arg_751_1.time_ - var_754_10) / var_754_11

				if arg_751_1.var_.characterEffect1066ui_story then
					arg_751_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_751_1.time_ >= var_754_10 + var_754_11 and arg_751_1.time_ < var_754_10 + var_754_11 + arg_754_0 and arg_751_1.var_.characterEffect1066ui_story then
				arg_751_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_754_13 = 0

			if var_754_13 < arg_751_1.time_ and arg_751_1.time_ <= var_754_13 + arg_754_0 then
				arg_751_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_754_14 = 0
			local var_754_15 = 0.275

			if var_754_14 < arg_751_1.time_ and arg_751_1.time_ <= var_754_14 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				local var_754_16 = arg_751_1:FormatText(StoryNameCfg[32].name)

				arg_751_1.leftNameTxt_.text = var_754_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_17 = arg_751_1:GetWordFromCfg(1106605188)
				local var_754_18 = arg_751_1:FormatText(var_754_17.content)

				arg_751_1.text_.text = var_754_18

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_19 = 11
				local var_754_20 = utf8.len(var_754_18)
				local var_754_21 = var_754_19 <= 0 and var_754_15 or var_754_15 * (var_754_20 / var_754_19)

				if var_754_21 > 0 and var_754_15 < var_754_21 then
					arg_751_1.talkMaxDuration = var_754_21

					if var_754_21 + var_754_14 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_21 + var_754_14
					end
				end

				arg_751_1.text_.text = var_754_18
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605188", "story_v_side_new_1106605.awb") ~= 0 then
					local var_754_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605188", "story_v_side_new_1106605.awb") / 1000

					if var_754_22 + var_754_14 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_22 + var_754_14
					end

					if var_754_17.prefab_name ~= "" and arg_751_1.actors_[var_754_17.prefab_name] ~= nil then
						local var_754_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_17.prefab_name].transform, "story_v_side_new_1106605", "1106605188", "story_v_side_new_1106605.awb")

						arg_751_1:RecordAudio("1106605188", var_754_23)
						arg_751_1:RecordAudio("1106605188", var_754_23)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605188", "story_v_side_new_1106605.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605188", "story_v_side_new_1106605.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_24 = math.max(var_754_15, arg_751_1.talkMaxDuration)

			if var_754_14 <= arg_751_1.time_ and arg_751_1.time_ < var_754_14 + var_754_24 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_14) / var_754_24

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_14 + var_754_24 and arg_751_1.time_ < var_754_14 + var_754_24 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605189 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 1106605189
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play1106605190(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = arg_755_1.actors_["1066ui_story"]
			local var_758_1 = 0

			if var_758_1 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 and arg_755_1.var_.characterEffect1066ui_story == nil then
				arg_755_1.var_.characterEffect1066ui_story = var_758_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_2 = 0.200000002980232

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_2 then
				local var_758_3 = (arg_755_1.time_ - var_758_1) / var_758_2

				if arg_755_1.var_.characterEffect1066ui_story then
					local var_758_4 = Mathf.Lerp(0, 0.5, var_758_3)

					arg_755_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_755_1.var_.characterEffect1066ui_story.fillRatio = var_758_4
				end
			end

			if arg_755_1.time_ >= var_758_1 + var_758_2 and arg_755_1.time_ < var_758_1 + var_758_2 + arg_758_0 and arg_755_1.var_.characterEffect1066ui_story then
				local var_758_5 = 0.5

				arg_755_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_755_1.var_.characterEffect1066ui_story.fillRatio = var_758_5
			end

			local var_758_6 = 0
			local var_758_7 = 0.9

			if var_758_6 < arg_755_1.time_ and arg_755_1.time_ <= var_758_6 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				local var_758_8 = arg_755_1:FormatText(StoryNameCfg[7].name)

				arg_755_1.leftNameTxt_.text = var_758_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_9 = arg_755_1:GetWordFromCfg(1106605189)
				local var_758_10 = arg_755_1:FormatText(var_758_9.content)

				arg_755_1.text_.text = var_758_10

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_11 = 36
				local var_758_12 = utf8.len(var_758_10)
				local var_758_13 = var_758_11 <= 0 and var_758_7 or var_758_7 * (var_758_12 / var_758_11)

				if var_758_13 > 0 and var_758_7 < var_758_13 then
					arg_755_1.talkMaxDuration = var_758_13

					if var_758_13 + var_758_6 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_13 + var_758_6
					end
				end

				arg_755_1.text_.text = var_758_10
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_14 = math.max(var_758_7, arg_755_1.talkMaxDuration)

			if var_758_6 <= arg_755_1.time_ and arg_755_1.time_ < var_758_6 + var_758_14 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_6) / var_758_14

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_6 + var_758_14 and arg_755_1.time_ < var_758_6 + var_758_14 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605190 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 1106605190
		arg_759_1.duration_ = 1.999999999999

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play1106605191(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = arg_759_1.actors_["1066ui_story"].transform
			local var_762_1 = 0

			if var_762_1 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				arg_759_1.var_.moveOldPos1066ui_story = var_762_0.localPosition
			end

			local var_762_2 = 0.001

			if var_762_1 <= arg_759_1.time_ and arg_759_1.time_ < var_762_1 + var_762_2 then
				local var_762_3 = (arg_759_1.time_ - var_762_1) / var_762_2
				local var_762_4 = Vector3.New(0, -0.77, -6.1)

				var_762_0.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1066ui_story, var_762_4, var_762_3)

				local var_762_5 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_5.x, var_762_5.y, var_762_5.z)

				local var_762_6 = var_762_0.localEulerAngles

				var_762_6.z = 0
				var_762_6.x = 0
				var_762_0.localEulerAngles = var_762_6
			end

			if arg_759_1.time_ >= var_762_1 + var_762_2 and arg_759_1.time_ < var_762_1 + var_762_2 + arg_762_0 then
				var_762_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_762_7 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_7.x, var_762_7.y, var_762_7.z)

				local var_762_8 = var_762_0.localEulerAngles

				var_762_8.z = 0
				var_762_8.x = 0
				var_762_0.localEulerAngles = var_762_8
			end

			local var_762_9 = arg_759_1.actors_["1066ui_story"]
			local var_762_10 = 0

			if var_762_10 < arg_759_1.time_ and arg_759_1.time_ <= var_762_10 + arg_762_0 and arg_759_1.var_.characterEffect1066ui_story == nil then
				arg_759_1.var_.characterEffect1066ui_story = var_762_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_11 = 0.200000002980232

			if var_762_10 <= arg_759_1.time_ and arg_759_1.time_ < var_762_10 + var_762_11 then
				local var_762_12 = (arg_759_1.time_ - var_762_10) / var_762_11

				if arg_759_1.var_.characterEffect1066ui_story then
					arg_759_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_759_1.time_ >= var_762_10 + var_762_11 and arg_759_1.time_ < var_762_10 + var_762_11 + arg_762_0 and arg_759_1.var_.characterEffect1066ui_story then
				arg_759_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_762_13 = 0

			if var_762_13 < arg_759_1.time_ and arg_759_1.time_ <= var_762_13 + arg_762_0 then
				arg_759_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_1")
			end

			local var_762_14 = 0

			if var_762_14 < arg_759_1.time_ and arg_759_1.time_ <= var_762_14 + arg_762_0 then
				arg_759_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_762_15 = 0
			local var_762_16 = 0.2

			if var_762_15 < arg_759_1.time_ and arg_759_1.time_ <= var_762_15 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				local var_762_17 = arg_759_1:FormatText(StoryNameCfg[32].name)

				arg_759_1.leftNameTxt_.text = var_762_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_18 = arg_759_1:GetWordFromCfg(1106605190)
				local var_762_19 = arg_759_1:FormatText(var_762_18.content)

				arg_759_1.text_.text = var_762_19

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_20 = 8
				local var_762_21 = utf8.len(var_762_19)
				local var_762_22 = var_762_20 <= 0 and var_762_16 or var_762_16 * (var_762_21 / var_762_20)

				if var_762_22 > 0 and var_762_16 < var_762_22 then
					arg_759_1.talkMaxDuration = var_762_22

					if var_762_22 + var_762_15 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_22 + var_762_15
					end
				end

				arg_759_1.text_.text = var_762_19
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605190", "story_v_side_new_1106605.awb") ~= 0 then
					local var_762_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605190", "story_v_side_new_1106605.awb") / 1000

					if var_762_23 + var_762_15 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_23 + var_762_15
					end

					if var_762_18.prefab_name ~= "" and arg_759_1.actors_[var_762_18.prefab_name] ~= nil then
						local var_762_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_759_1.actors_[var_762_18.prefab_name].transform, "story_v_side_new_1106605", "1106605190", "story_v_side_new_1106605.awb")

						arg_759_1:RecordAudio("1106605190", var_762_24)
						arg_759_1:RecordAudio("1106605190", var_762_24)
					else
						arg_759_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605190", "story_v_side_new_1106605.awb")
					end

					arg_759_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605190", "story_v_side_new_1106605.awb")
				end

				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_25 = math.max(var_762_16, arg_759_1.talkMaxDuration)

			if var_762_15 <= arg_759_1.time_ and arg_759_1.time_ < var_762_15 + var_762_25 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_15) / var_762_25

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_15 + var_762_25 and arg_759_1.time_ < var_762_15 + var_762_25 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605191 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 1106605191
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play1106605192(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = arg_763_1.actors_["1066ui_story"]
			local var_766_1 = 0

			if var_766_1 < arg_763_1.time_ and arg_763_1.time_ <= var_766_1 + arg_766_0 and arg_763_1.var_.characterEffect1066ui_story == nil then
				arg_763_1.var_.characterEffect1066ui_story = var_766_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_2 = 0.200000002980232

			if var_766_1 <= arg_763_1.time_ and arg_763_1.time_ < var_766_1 + var_766_2 then
				local var_766_3 = (arg_763_1.time_ - var_766_1) / var_766_2

				if arg_763_1.var_.characterEffect1066ui_story then
					local var_766_4 = Mathf.Lerp(0, 0.5, var_766_3)

					arg_763_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_763_1.var_.characterEffect1066ui_story.fillRatio = var_766_4
				end
			end

			if arg_763_1.time_ >= var_766_1 + var_766_2 and arg_763_1.time_ < var_766_1 + var_766_2 + arg_766_0 and arg_763_1.var_.characterEffect1066ui_story then
				local var_766_5 = 0.5

				arg_763_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_763_1.var_.characterEffect1066ui_story.fillRatio = var_766_5
			end

			local var_766_6 = 0
			local var_766_7 = 0.575

			if var_766_6 < arg_763_1.time_ and arg_763_1.time_ <= var_766_6 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				local var_766_8 = arg_763_1:FormatText(StoryNameCfg[7].name)

				arg_763_1.leftNameTxt_.text = var_766_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_9 = arg_763_1:GetWordFromCfg(1106605191)
				local var_766_10 = arg_763_1:FormatText(var_766_9.content)

				arg_763_1.text_.text = var_766_10

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_11 = 23
				local var_766_12 = utf8.len(var_766_10)
				local var_766_13 = var_766_11 <= 0 and var_766_7 or var_766_7 * (var_766_12 / var_766_11)

				if var_766_13 > 0 and var_766_7 < var_766_13 then
					arg_763_1.talkMaxDuration = var_766_13

					if var_766_13 + var_766_6 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_13 + var_766_6
					end
				end

				arg_763_1.text_.text = var_766_10
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_14 = math.max(var_766_7, arg_763_1.talkMaxDuration)

			if var_766_6 <= arg_763_1.time_ and arg_763_1.time_ < var_766_6 + var_766_14 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_6) / var_766_14

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_6 + var_766_14 and arg_763_1.time_ < var_766_6 + var_766_14 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605192 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 1106605192
		arg_767_1.duration_ = 6.366

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play1106605193(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = arg_767_1.actors_["1066ui_story"].transform
			local var_770_1 = 0

			if var_770_1 < arg_767_1.time_ and arg_767_1.time_ <= var_770_1 + arg_770_0 then
				arg_767_1.var_.moveOldPos1066ui_story = var_770_0.localPosition
			end

			local var_770_2 = 0.001

			if var_770_1 <= arg_767_1.time_ and arg_767_1.time_ < var_770_1 + var_770_2 then
				local var_770_3 = (arg_767_1.time_ - var_770_1) / var_770_2
				local var_770_4 = Vector3.New(0, -0.77, -6.1)

				var_770_0.localPosition = Vector3.Lerp(arg_767_1.var_.moveOldPos1066ui_story, var_770_4, var_770_3)

				local var_770_5 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_5.x, var_770_5.y, var_770_5.z)

				local var_770_6 = var_770_0.localEulerAngles

				var_770_6.z = 0
				var_770_6.x = 0
				var_770_0.localEulerAngles = var_770_6
			end

			if arg_767_1.time_ >= var_770_1 + var_770_2 and arg_767_1.time_ < var_770_1 + var_770_2 + arg_770_0 then
				var_770_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_770_7 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_7.x, var_770_7.y, var_770_7.z)

				local var_770_8 = var_770_0.localEulerAngles

				var_770_8.z = 0
				var_770_8.x = 0
				var_770_0.localEulerAngles = var_770_8
			end

			local var_770_9 = arg_767_1.actors_["1066ui_story"]
			local var_770_10 = 0

			if var_770_10 < arg_767_1.time_ and arg_767_1.time_ <= var_770_10 + arg_770_0 and arg_767_1.var_.characterEffect1066ui_story == nil then
				arg_767_1.var_.characterEffect1066ui_story = var_770_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_11 = 0.200000002980232

			if var_770_10 <= arg_767_1.time_ and arg_767_1.time_ < var_770_10 + var_770_11 then
				local var_770_12 = (arg_767_1.time_ - var_770_10) / var_770_11

				if arg_767_1.var_.characterEffect1066ui_story then
					arg_767_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_767_1.time_ >= var_770_10 + var_770_11 and arg_767_1.time_ < var_770_10 + var_770_11 + arg_770_0 and arg_767_1.var_.characterEffect1066ui_story then
				arg_767_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_770_13 = 0

			if var_770_13 < arg_767_1.time_ and arg_767_1.time_ <= var_770_13 + arg_770_0 then
				arg_767_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action437")
			end

			local var_770_14 = 0

			if var_770_14 < arg_767_1.time_ and arg_767_1.time_ <= var_770_14 + arg_770_0 then
				arg_767_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_770_15 = 0
			local var_770_16 = 0.725

			if var_770_15 < arg_767_1.time_ and arg_767_1.time_ <= var_770_15 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				local var_770_17 = arg_767_1:FormatText(StoryNameCfg[32].name)

				arg_767_1.leftNameTxt_.text = var_770_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_18 = arg_767_1:GetWordFromCfg(1106605192)
				local var_770_19 = arg_767_1:FormatText(var_770_18.content)

				arg_767_1.text_.text = var_770_19

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_20 = 29
				local var_770_21 = utf8.len(var_770_19)
				local var_770_22 = var_770_20 <= 0 and var_770_16 or var_770_16 * (var_770_21 / var_770_20)

				if var_770_22 > 0 and var_770_16 < var_770_22 then
					arg_767_1.talkMaxDuration = var_770_22

					if var_770_22 + var_770_15 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_22 + var_770_15
					end
				end

				arg_767_1.text_.text = var_770_19
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605192", "story_v_side_new_1106605.awb") ~= 0 then
					local var_770_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605192", "story_v_side_new_1106605.awb") / 1000

					if var_770_23 + var_770_15 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_23 + var_770_15
					end

					if var_770_18.prefab_name ~= "" and arg_767_1.actors_[var_770_18.prefab_name] ~= nil then
						local var_770_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_767_1.actors_[var_770_18.prefab_name].transform, "story_v_side_new_1106605", "1106605192", "story_v_side_new_1106605.awb")

						arg_767_1:RecordAudio("1106605192", var_770_24)
						arg_767_1:RecordAudio("1106605192", var_770_24)
					else
						arg_767_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605192", "story_v_side_new_1106605.awb")
					end

					arg_767_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605192", "story_v_side_new_1106605.awb")
				end

				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_25 = math.max(var_770_16, arg_767_1.talkMaxDuration)

			if var_770_15 <= arg_767_1.time_ and arg_767_1.time_ < var_770_15 + var_770_25 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_15) / var_770_25

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_15 + var_770_25 and arg_767_1.time_ < var_770_15 + var_770_25 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605193 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 1106605193
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play1106605194(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = arg_771_1.actors_["1066ui_story"]
			local var_774_1 = 0

			if var_774_1 < arg_771_1.time_ and arg_771_1.time_ <= var_774_1 + arg_774_0 and arg_771_1.var_.characterEffect1066ui_story == nil then
				arg_771_1.var_.characterEffect1066ui_story = var_774_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_774_2 = 0.200000002980232

			if var_774_1 <= arg_771_1.time_ and arg_771_1.time_ < var_774_1 + var_774_2 then
				local var_774_3 = (arg_771_1.time_ - var_774_1) / var_774_2

				if arg_771_1.var_.characterEffect1066ui_story then
					local var_774_4 = Mathf.Lerp(0, 0.5, var_774_3)

					arg_771_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_771_1.var_.characterEffect1066ui_story.fillRatio = var_774_4
				end
			end

			if arg_771_1.time_ >= var_774_1 + var_774_2 and arg_771_1.time_ < var_774_1 + var_774_2 + arg_774_0 and arg_771_1.var_.characterEffect1066ui_story then
				local var_774_5 = 0.5

				arg_771_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_771_1.var_.characterEffect1066ui_story.fillRatio = var_774_5
			end

			local var_774_6 = 0
			local var_774_7 = 1.1

			if var_774_6 < arg_771_1.time_ and arg_771_1.time_ <= var_774_6 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_8 = arg_771_1:GetWordFromCfg(1106605193)
				local var_774_9 = arg_771_1:FormatText(var_774_8.content)

				arg_771_1.text_.text = var_774_9

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_10 = 44
				local var_774_11 = utf8.len(var_774_9)
				local var_774_12 = var_774_10 <= 0 and var_774_7 or var_774_7 * (var_774_11 / var_774_10)

				if var_774_12 > 0 and var_774_7 < var_774_12 then
					arg_771_1.talkMaxDuration = var_774_12

					if var_774_12 + var_774_6 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_12 + var_774_6
					end
				end

				arg_771_1.text_.text = var_774_9
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_13 = math.max(var_774_7, arg_771_1.talkMaxDuration)

			if var_774_6 <= arg_771_1.time_ and arg_771_1.time_ < var_774_6 + var_774_13 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_6) / var_774_13

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_6 + var_774_13 and arg_771_1.time_ < var_774_6 + var_774_13 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605194 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 1106605194
		arg_775_1.duration_ = 5

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play1106605195(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			local var_778_0 = 0
			local var_778_1 = 0.675

			if var_778_0 < arg_775_1.time_ and arg_775_1.time_ <= var_778_0 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, true)

				local var_778_2 = arg_775_1:FormatText(StoryNameCfg[7].name)

				arg_775_1.leftNameTxt_.text = var_778_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_775_1.leftNameTxt_.transform)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1.leftNameTxt_.text)
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_3 = arg_775_1:GetWordFromCfg(1106605194)
				local var_778_4 = arg_775_1:FormatText(var_778_3.content)

				arg_775_1.text_.text = var_778_4

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_5 = 27
				local var_778_6 = utf8.len(var_778_4)
				local var_778_7 = var_778_5 <= 0 and var_778_1 or var_778_1 * (var_778_6 / var_778_5)

				if var_778_7 > 0 and var_778_1 < var_778_7 then
					arg_775_1.talkMaxDuration = var_778_7

					if var_778_7 + var_778_0 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_7 + var_778_0
					end
				end

				arg_775_1.text_.text = var_778_4
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)
				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_8 = math.max(var_778_1, arg_775_1.talkMaxDuration)

			if var_778_0 <= arg_775_1.time_ and arg_775_1.time_ < var_778_0 + var_778_8 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_0) / var_778_8

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_0 + var_778_8 and arg_775_1.time_ < var_778_0 + var_778_8 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605195 = function(arg_779_0, arg_779_1)
		arg_779_1.time_ = 0
		arg_779_1.frameCnt_ = 0
		arg_779_1.state_ = "playing"
		arg_779_1.curTalkId_ = 1106605195
		arg_779_1.duration_ = 5

		SetActive(arg_779_1.tipsGo_, false)

		function arg_779_1.onSingleLineFinish_()
			arg_779_1.onSingleLineUpdate_ = nil
			arg_779_1.onSingleLineFinish_ = nil
			arg_779_1.state_ = "waiting"
		end

		function arg_779_1.playNext_(arg_781_0)
			if arg_781_0 == 1 then
				arg_779_0:Play1106605196(arg_779_1)
			end
		end

		function arg_779_1.onSingleLineUpdate_(arg_782_0)
			local var_782_0 = arg_779_1.actors_["1066ui_story"].transform
			local var_782_1 = 0

			if var_782_1 < arg_779_1.time_ and arg_779_1.time_ <= var_782_1 + arg_782_0 then
				arg_779_1.var_.moveOldPos1066ui_story = var_782_0.localPosition
			end

			local var_782_2 = 0.001

			if var_782_1 <= arg_779_1.time_ and arg_779_1.time_ < var_782_1 + var_782_2 then
				local var_782_3 = (arg_779_1.time_ - var_782_1) / var_782_2
				local var_782_4 = Vector3.New(0, 100, 0)

				var_782_0.localPosition = Vector3.Lerp(arg_779_1.var_.moveOldPos1066ui_story, var_782_4, var_782_3)

				local var_782_5 = manager.ui.mainCamera.transform.position - var_782_0.position

				var_782_0.forward = Vector3.New(var_782_5.x, var_782_5.y, var_782_5.z)

				local var_782_6 = var_782_0.localEulerAngles

				var_782_6.z = 0
				var_782_6.x = 0
				var_782_0.localEulerAngles = var_782_6
			end

			if arg_779_1.time_ >= var_782_1 + var_782_2 and arg_779_1.time_ < var_782_1 + var_782_2 + arg_782_0 then
				var_782_0.localPosition = Vector3.New(0, 100, 0)

				local var_782_7 = manager.ui.mainCamera.transform.position - var_782_0.position

				var_782_0.forward = Vector3.New(var_782_7.x, var_782_7.y, var_782_7.z)

				local var_782_8 = var_782_0.localEulerAngles

				var_782_8.z = 0
				var_782_8.x = 0
				var_782_0.localEulerAngles = var_782_8
			end

			local var_782_9 = 0
			local var_782_10 = 1.45

			if var_782_9 < arg_779_1.time_ and arg_779_1.time_ <= var_782_9 + arg_782_0 then
				arg_779_1.talkMaxDuration = 0
				arg_779_1.dialogCg_.alpha = 1

				arg_779_1.dialog_:SetActive(true)
				SetActive(arg_779_1.leftNameGo_, false)

				arg_779_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_779_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_779_1:RecordName(arg_779_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_779_1.iconTrs_.gameObject, false)
				arg_779_1.callingController_:SetSelectedState("normal")

				local var_782_11 = arg_779_1:GetWordFromCfg(1106605195)
				local var_782_12 = arg_779_1:FormatText(var_782_11.content)

				arg_779_1.text_.text = var_782_12

				LuaForUtil.ClearLinePrefixSymbol(arg_779_1.text_)

				local var_782_13 = 58
				local var_782_14 = utf8.len(var_782_12)
				local var_782_15 = var_782_13 <= 0 and var_782_10 or var_782_10 * (var_782_14 / var_782_13)

				if var_782_15 > 0 and var_782_10 < var_782_15 then
					arg_779_1.talkMaxDuration = var_782_15

					if var_782_15 + var_782_9 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_15 + var_782_9
					end
				end

				arg_779_1.text_.text = var_782_12
				arg_779_1.typewritter.percent = 0

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(false)
				arg_779_1:RecordContent(arg_779_1.text_.text)
			end

			local var_782_16 = math.max(var_782_10, arg_779_1.talkMaxDuration)

			if var_782_9 <= arg_779_1.time_ and arg_779_1.time_ < var_782_9 + var_782_16 then
				arg_779_1.typewritter.percent = (arg_779_1.time_ - var_782_9) / var_782_16

				arg_779_1.typewritter:SetDirty()
			end

			if arg_779_1.time_ >= var_782_9 + var_782_16 and arg_779_1.time_ < var_782_9 + var_782_16 + arg_782_0 then
				arg_779_1.typewritter.percent = 1

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605196 = function(arg_783_0, arg_783_1)
		arg_783_1.time_ = 0
		arg_783_1.frameCnt_ = 0
		arg_783_1.state_ = "playing"
		arg_783_1.curTalkId_ = 1106605196
		arg_783_1.duration_ = 3.766

		SetActive(arg_783_1.tipsGo_, false)

		function arg_783_1.onSingleLineFinish_()
			arg_783_1.onSingleLineUpdate_ = nil
			arg_783_1.onSingleLineFinish_ = nil
			arg_783_1.state_ = "waiting"
		end

		function arg_783_1.playNext_(arg_785_0)
			if arg_785_0 == 1 then
				arg_783_0:Play1106605197(arg_783_1)
			end
		end

		function arg_783_1.onSingleLineUpdate_(arg_786_0)
			local var_786_0 = arg_783_1.actors_["1066ui_story"].transform
			local var_786_1 = 0

			if var_786_1 < arg_783_1.time_ and arg_783_1.time_ <= var_786_1 + arg_786_0 then
				arg_783_1.var_.moveOldPos1066ui_story = var_786_0.localPosition
			end

			local var_786_2 = 0.001

			if var_786_1 <= arg_783_1.time_ and arg_783_1.time_ < var_786_1 + var_786_2 then
				local var_786_3 = (arg_783_1.time_ - var_786_1) / var_786_2
				local var_786_4 = Vector3.New(0, -0.77, -6.1)

				var_786_0.localPosition = Vector3.Lerp(arg_783_1.var_.moveOldPos1066ui_story, var_786_4, var_786_3)

				local var_786_5 = manager.ui.mainCamera.transform.position - var_786_0.position

				var_786_0.forward = Vector3.New(var_786_5.x, var_786_5.y, var_786_5.z)

				local var_786_6 = var_786_0.localEulerAngles

				var_786_6.z = 0
				var_786_6.x = 0
				var_786_0.localEulerAngles = var_786_6
			end

			if arg_783_1.time_ >= var_786_1 + var_786_2 and arg_783_1.time_ < var_786_1 + var_786_2 + arg_786_0 then
				var_786_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_786_7 = manager.ui.mainCamera.transform.position - var_786_0.position

				var_786_0.forward = Vector3.New(var_786_7.x, var_786_7.y, var_786_7.z)

				local var_786_8 = var_786_0.localEulerAngles

				var_786_8.z = 0
				var_786_8.x = 0
				var_786_0.localEulerAngles = var_786_8
			end

			local var_786_9 = arg_783_1.actors_["1066ui_story"]
			local var_786_10 = 0

			if var_786_10 < arg_783_1.time_ and arg_783_1.time_ <= var_786_10 + arg_786_0 and arg_783_1.var_.characterEffect1066ui_story == nil then
				arg_783_1.var_.characterEffect1066ui_story = var_786_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_11 = 0.200000002980232

			if var_786_10 <= arg_783_1.time_ and arg_783_1.time_ < var_786_10 + var_786_11 then
				local var_786_12 = (arg_783_1.time_ - var_786_10) / var_786_11

				if arg_783_1.var_.characterEffect1066ui_story then
					arg_783_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_783_1.time_ >= var_786_10 + var_786_11 and arg_783_1.time_ < var_786_10 + var_786_11 + arg_786_0 and arg_783_1.var_.characterEffect1066ui_story then
				arg_783_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_786_13 = 0

			if var_786_13 < arg_783_1.time_ and arg_783_1.time_ <= var_786_13 + arg_786_0 then
				arg_783_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action5_1")
			end

			local var_786_14 = 0

			if var_786_14 < arg_783_1.time_ and arg_783_1.time_ <= var_786_14 + arg_786_0 then
				arg_783_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_786_15 = 0
			local var_786_16 = 0.3

			if var_786_15 < arg_783_1.time_ and arg_783_1.time_ <= var_786_15 + arg_786_0 then
				arg_783_1.talkMaxDuration = 0
				arg_783_1.dialogCg_.alpha = 1

				arg_783_1.dialog_:SetActive(true)
				SetActive(arg_783_1.leftNameGo_, true)

				local var_786_17 = arg_783_1:FormatText(StoryNameCfg[32].name)

				arg_783_1.leftNameTxt_.text = var_786_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_783_1.leftNameTxt_.transform)

				arg_783_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_783_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_783_1:RecordName(arg_783_1.leftNameTxt_.text)
				SetActive(arg_783_1.iconTrs_.gameObject, false)
				arg_783_1.callingController_:SetSelectedState("normal")

				local var_786_18 = arg_783_1:GetWordFromCfg(1106605196)
				local var_786_19 = arg_783_1:FormatText(var_786_18.content)

				arg_783_1.text_.text = var_786_19

				LuaForUtil.ClearLinePrefixSymbol(arg_783_1.text_)

				local var_786_20 = 12
				local var_786_21 = utf8.len(var_786_19)
				local var_786_22 = var_786_20 <= 0 and var_786_16 or var_786_16 * (var_786_21 / var_786_20)

				if var_786_22 > 0 and var_786_16 < var_786_22 then
					arg_783_1.talkMaxDuration = var_786_22

					if var_786_22 + var_786_15 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_22 + var_786_15
					end
				end

				arg_783_1.text_.text = var_786_19
				arg_783_1.typewritter.percent = 0

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605196", "story_v_side_new_1106605.awb") ~= 0 then
					local var_786_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605196", "story_v_side_new_1106605.awb") / 1000

					if var_786_23 + var_786_15 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_23 + var_786_15
					end

					if var_786_18.prefab_name ~= "" and arg_783_1.actors_[var_786_18.prefab_name] ~= nil then
						local var_786_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_783_1.actors_[var_786_18.prefab_name].transform, "story_v_side_new_1106605", "1106605196", "story_v_side_new_1106605.awb")

						arg_783_1:RecordAudio("1106605196", var_786_24)
						arg_783_1:RecordAudio("1106605196", var_786_24)
					else
						arg_783_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605196", "story_v_side_new_1106605.awb")
					end

					arg_783_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605196", "story_v_side_new_1106605.awb")
				end

				arg_783_1:RecordContent(arg_783_1.text_.text)
			end

			local var_786_25 = math.max(var_786_16, arg_783_1.talkMaxDuration)

			if var_786_15 <= arg_783_1.time_ and arg_783_1.time_ < var_786_15 + var_786_25 then
				arg_783_1.typewritter.percent = (arg_783_1.time_ - var_786_15) / var_786_25

				arg_783_1.typewritter:SetDirty()
			end

			if arg_783_1.time_ >= var_786_15 + var_786_25 and arg_783_1.time_ < var_786_15 + var_786_25 + arg_786_0 then
				arg_783_1.typewritter.percent = 1

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605197 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 1106605197
		arg_787_1.duration_ = 0.999999999999

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"

			SetActive(arg_787_1.choicesGo_, true)

			for iter_788_0, iter_788_1 in ipairs(arg_787_1.choices_) do
				local var_788_0 = iter_788_0 <= 2

				SetActive(iter_788_1.go, var_788_0)
			end

			arg_787_1.choices_[1].txt.text = arg_787_1:FormatText(StoryChoiceCfg[554].name)
			arg_787_1.choices_[2].txt.text = arg_787_1:FormatText(StoryChoiceCfg[555].name)
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play1106605198(arg_787_1)
			end

			if arg_789_0 == 2 then
				arg_787_0:Play1106605199(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			local var_790_0 = arg_787_1.actors_["1066ui_story"]
			local var_790_1 = 0

			if var_790_1 < arg_787_1.time_ and arg_787_1.time_ <= var_790_1 + arg_790_0 and arg_787_1.var_.characterEffect1066ui_story == nil then
				arg_787_1.var_.characterEffect1066ui_story = var_790_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_790_2 = 0.200000002980232

			if var_790_1 <= arg_787_1.time_ and arg_787_1.time_ < var_790_1 + var_790_2 then
				local var_790_3 = (arg_787_1.time_ - var_790_1) / var_790_2

				if arg_787_1.var_.characterEffect1066ui_story then
					local var_790_4 = Mathf.Lerp(0, 0.5, var_790_3)

					arg_787_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_787_1.var_.characterEffect1066ui_story.fillRatio = var_790_4
				end
			end

			if arg_787_1.time_ >= var_790_1 + var_790_2 and arg_787_1.time_ < var_790_1 + var_790_2 + arg_790_0 and arg_787_1.var_.characterEffect1066ui_story then
				local var_790_5 = 0.5

				arg_787_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_787_1.var_.characterEffect1066ui_story.fillRatio = var_790_5
			end

			local var_790_6 = 0

			if var_790_6 < arg_787_1.time_ and arg_787_1.time_ <= var_790_6 + arg_790_0 then
				arg_787_1.allBtn_.enabled = false
			end

			local var_790_7 = 0.5

			if arg_787_1.time_ >= var_790_6 + var_790_7 and arg_787_1.time_ < var_790_6 + var_790_7 + arg_790_0 then
				arg_787_1.allBtn_.enabled = true
			end
		end
	end,
	Play1106605198 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 1106605198
		arg_791_1.duration_ = 2.733

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play1106605200(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			local var_794_0 = arg_791_1.actors_["1066ui_story"].transform
			local var_794_1 = 0

			if var_794_1 < arg_791_1.time_ and arg_791_1.time_ <= var_794_1 + arg_794_0 then
				arg_791_1.var_.moveOldPos1066ui_story = var_794_0.localPosition
			end

			local var_794_2 = 0.001

			if var_794_1 <= arg_791_1.time_ and arg_791_1.time_ < var_794_1 + var_794_2 then
				local var_794_3 = (arg_791_1.time_ - var_794_1) / var_794_2
				local var_794_4 = Vector3.New(0, -0.77, -6.1)

				var_794_0.localPosition = Vector3.Lerp(arg_791_1.var_.moveOldPos1066ui_story, var_794_4, var_794_3)

				local var_794_5 = manager.ui.mainCamera.transform.position - var_794_0.position

				var_794_0.forward = Vector3.New(var_794_5.x, var_794_5.y, var_794_5.z)

				local var_794_6 = var_794_0.localEulerAngles

				var_794_6.z = 0
				var_794_6.x = 0
				var_794_0.localEulerAngles = var_794_6
			end

			if arg_791_1.time_ >= var_794_1 + var_794_2 and arg_791_1.time_ < var_794_1 + var_794_2 + arg_794_0 then
				var_794_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_794_7 = manager.ui.mainCamera.transform.position - var_794_0.position

				var_794_0.forward = Vector3.New(var_794_7.x, var_794_7.y, var_794_7.z)

				local var_794_8 = var_794_0.localEulerAngles

				var_794_8.z = 0
				var_794_8.x = 0
				var_794_0.localEulerAngles = var_794_8
			end

			local var_794_9 = arg_791_1.actors_["1066ui_story"]
			local var_794_10 = 0

			if var_794_10 < arg_791_1.time_ and arg_791_1.time_ <= var_794_10 + arg_794_0 and arg_791_1.var_.characterEffect1066ui_story == nil then
				arg_791_1.var_.characterEffect1066ui_story = var_794_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_11 = 0.200000002980232

			if var_794_10 <= arg_791_1.time_ and arg_791_1.time_ < var_794_10 + var_794_11 then
				local var_794_12 = (arg_791_1.time_ - var_794_10) / var_794_11

				if arg_791_1.var_.characterEffect1066ui_story then
					arg_791_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_791_1.time_ >= var_794_10 + var_794_11 and arg_791_1.time_ < var_794_10 + var_794_11 + arg_794_0 and arg_791_1.var_.characterEffect1066ui_story then
				arg_791_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_794_13 = 0

			if var_794_13 < arg_791_1.time_ and arg_791_1.time_ <= var_794_13 + arg_794_0 then
				arg_791_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action456")
			end

			local var_794_14 = 0

			if var_794_14 < arg_791_1.time_ and arg_791_1.time_ <= var_794_14 + arg_794_0 then
				arg_791_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_794_15 = 0
			local var_794_16 = 0.325

			if var_794_15 < arg_791_1.time_ and arg_791_1.time_ <= var_794_15 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				local var_794_17 = arg_791_1:FormatText(StoryNameCfg[32].name)

				arg_791_1.leftNameTxt_.text = var_794_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, false)
				arg_791_1.callingController_:SetSelectedState("normal")

				local var_794_18 = arg_791_1:GetWordFromCfg(1106605198)
				local var_794_19 = arg_791_1:FormatText(var_794_18.content)

				arg_791_1.text_.text = var_794_19

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_20 = 13
				local var_794_21 = utf8.len(var_794_19)
				local var_794_22 = var_794_20 <= 0 and var_794_16 or var_794_16 * (var_794_21 / var_794_20)

				if var_794_22 > 0 and var_794_16 < var_794_22 then
					arg_791_1.talkMaxDuration = var_794_22

					if var_794_22 + var_794_15 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_22 + var_794_15
					end
				end

				arg_791_1.text_.text = var_794_19
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605198", "story_v_side_new_1106605.awb") ~= 0 then
					local var_794_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605198", "story_v_side_new_1106605.awb") / 1000

					if var_794_23 + var_794_15 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_23 + var_794_15
					end

					if var_794_18.prefab_name ~= "" and arg_791_1.actors_[var_794_18.prefab_name] ~= nil then
						local var_794_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_791_1.actors_[var_794_18.prefab_name].transform, "story_v_side_new_1106605", "1106605198", "story_v_side_new_1106605.awb")

						arg_791_1:RecordAudio("1106605198", var_794_24)
						arg_791_1:RecordAudio("1106605198", var_794_24)
					else
						arg_791_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605198", "story_v_side_new_1106605.awb")
					end

					arg_791_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605198", "story_v_side_new_1106605.awb")
				end

				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_25 = math.max(var_794_16, arg_791_1.talkMaxDuration)

			if var_794_15 <= arg_791_1.time_ and arg_791_1.time_ < var_794_15 + var_794_25 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_15) / var_794_25

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_15 + var_794_25 and arg_791_1.time_ < var_794_15 + var_794_25 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605200 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 1106605200
		arg_795_1.duration_ = 2.8

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play1106605201(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = arg_795_1.actors_["1066ui_story"].transform
			local var_798_1 = 0

			if var_798_1 < arg_795_1.time_ and arg_795_1.time_ <= var_798_1 + arg_798_0 then
				arg_795_1.var_.moveOldPos1066ui_story = var_798_0.localPosition
			end

			local var_798_2 = 0.001

			if var_798_1 <= arg_795_1.time_ and arg_795_1.time_ < var_798_1 + var_798_2 then
				local var_798_3 = (arg_795_1.time_ - var_798_1) / var_798_2
				local var_798_4 = Vector3.New(0, -0.77, -6.1)

				var_798_0.localPosition = Vector3.Lerp(arg_795_1.var_.moveOldPos1066ui_story, var_798_4, var_798_3)

				local var_798_5 = manager.ui.mainCamera.transform.position - var_798_0.position

				var_798_0.forward = Vector3.New(var_798_5.x, var_798_5.y, var_798_5.z)

				local var_798_6 = var_798_0.localEulerAngles

				var_798_6.z = 0
				var_798_6.x = 0
				var_798_0.localEulerAngles = var_798_6
			end

			if arg_795_1.time_ >= var_798_1 + var_798_2 and arg_795_1.time_ < var_798_1 + var_798_2 + arg_798_0 then
				var_798_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_798_7 = manager.ui.mainCamera.transform.position - var_798_0.position

				var_798_0.forward = Vector3.New(var_798_7.x, var_798_7.y, var_798_7.z)

				local var_798_8 = var_798_0.localEulerAngles

				var_798_8.z = 0
				var_798_8.x = 0
				var_798_0.localEulerAngles = var_798_8
			end

			local var_798_9 = arg_795_1.actors_["1066ui_story"]
			local var_798_10 = 0

			if var_798_10 < arg_795_1.time_ and arg_795_1.time_ <= var_798_10 + arg_798_0 and arg_795_1.var_.characterEffect1066ui_story == nil then
				arg_795_1.var_.characterEffect1066ui_story = var_798_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_798_11 = 0.200000002980232

			if var_798_10 <= arg_795_1.time_ and arg_795_1.time_ < var_798_10 + var_798_11 then
				local var_798_12 = (arg_795_1.time_ - var_798_10) / var_798_11

				if arg_795_1.var_.characterEffect1066ui_story then
					arg_795_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_795_1.time_ >= var_798_10 + var_798_11 and arg_795_1.time_ < var_798_10 + var_798_11 + arg_798_0 and arg_795_1.var_.characterEffect1066ui_story then
				arg_795_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_798_13 = 0

			if var_798_13 < arg_795_1.time_ and arg_795_1.time_ <= var_798_13 + arg_798_0 then
				arg_795_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_2")
			end

			local var_798_14 = 0

			if var_798_14 < arg_795_1.time_ and arg_795_1.time_ <= var_798_14 + arg_798_0 then
				arg_795_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_798_15 = 0
			local var_798_16 = 0.225

			if var_798_15 < arg_795_1.time_ and arg_795_1.time_ <= var_798_15 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				local var_798_17 = arg_795_1:FormatText(StoryNameCfg[32].name)

				arg_795_1.leftNameTxt_.text = var_798_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_18 = arg_795_1:GetWordFromCfg(1106605200)
				local var_798_19 = arg_795_1:FormatText(var_798_18.content)

				arg_795_1.text_.text = var_798_19

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_20 = 9
				local var_798_21 = utf8.len(var_798_19)
				local var_798_22 = var_798_20 <= 0 and var_798_16 or var_798_16 * (var_798_21 / var_798_20)

				if var_798_22 > 0 and var_798_16 < var_798_22 then
					arg_795_1.talkMaxDuration = var_798_22

					if var_798_22 + var_798_15 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_22 + var_798_15
					end
				end

				arg_795_1.text_.text = var_798_19
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605200", "story_v_side_new_1106605.awb") ~= 0 then
					local var_798_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605200", "story_v_side_new_1106605.awb") / 1000

					if var_798_23 + var_798_15 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_23 + var_798_15
					end

					if var_798_18.prefab_name ~= "" and arg_795_1.actors_[var_798_18.prefab_name] ~= nil then
						local var_798_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_795_1.actors_[var_798_18.prefab_name].transform, "story_v_side_new_1106605", "1106605200", "story_v_side_new_1106605.awb")

						arg_795_1:RecordAudio("1106605200", var_798_24)
						arg_795_1:RecordAudio("1106605200", var_798_24)
					else
						arg_795_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605200", "story_v_side_new_1106605.awb")
					end

					arg_795_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605200", "story_v_side_new_1106605.awb")
				end

				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_25 = math.max(var_798_16, arg_795_1.talkMaxDuration)

			if var_798_15 <= arg_795_1.time_ and arg_795_1.time_ < var_798_15 + var_798_25 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_15) / var_798_25

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_15 + var_798_25 and arg_795_1.time_ < var_798_15 + var_798_25 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605201 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 1106605201
		arg_799_1.duration_ = 5

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play1106605202(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = arg_799_1.actors_["1066ui_story"]
			local var_802_1 = 0

			if var_802_1 < arg_799_1.time_ and arg_799_1.time_ <= var_802_1 + arg_802_0 and arg_799_1.var_.characterEffect1066ui_story == nil then
				arg_799_1.var_.characterEffect1066ui_story = var_802_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_2 = 0.200000002980232

			if var_802_1 <= arg_799_1.time_ and arg_799_1.time_ < var_802_1 + var_802_2 then
				local var_802_3 = (arg_799_1.time_ - var_802_1) / var_802_2

				if arg_799_1.var_.characterEffect1066ui_story then
					local var_802_4 = Mathf.Lerp(0, 0.5, var_802_3)

					arg_799_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_799_1.var_.characterEffect1066ui_story.fillRatio = var_802_4
				end
			end

			if arg_799_1.time_ >= var_802_1 + var_802_2 and arg_799_1.time_ < var_802_1 + var_802_2 + arg_802_0 and arg_799_1.var_.characterEffect1066ui_story then
				local var_802_5 = 0.5

				arg_799_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_799_1.var_.characterEffect1066ui_story.fillRatio = var_802_5
			end

			local var_802_6 = 0
			local var_802_7 = 0.225

			if var_802_6 < arg_799_1.time_ and arg_799_1.time_ <= var_802_6 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				local var_802_8 = arg_799_1:FormatText(StoryNameCfg[7].name)

				arg_799_1.leftNameTxt_.text = var_802_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_9 = arg_799_1:GetWordFromCfg(1106605201)
				local var_802_10 = arg_799_1:FormatText(var_802_9.content)

				arg_799_1.text_.text = var_802_10

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_11 = 9
				local var_802_12 = utf8.len(var_802_10)
				local var_802_13 = var_802_11 <= 0 and var_802_7 or var_802_7 * (var_802_12 / var_802_11)

				if var_802_13 > 0 and var_802_7 < var_802_13 then
					arg_799_1.talkMaxDuration = var_802_13

					if var_802_13 + var_802_6 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_13 + var_802_6
					end
				end

				arg_799_1.text_.text = var_802_10
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)
				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_14 = math.max(var_802_7, arg_799_1.talkMaxDuration)

			if var_802_6 <= arg_799_1.time_ and arg_799_1.time_ < var_802_6 + var_802_14 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_6) / var_802_14

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_6 + var_802_14 and arg_799_1.time_ < var_802_6 + var_802_14 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605202 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 1106605202
		arg_803_1.duration_ = 5

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play1106605203(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = 0
			local var_806_1 = 0.75

			if var_806_0 < arg_803_1.time_ and arg_803_1.time_ <= var_806_0 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, false)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_2 = arg_803_1:GetWordFromCfg(1106605202)
				local var_806_3 = arg_803_1:FormatText(var_806_2.content)

				arg_803_1.text_.text = var_806_3

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_4 = 30
				local var_806_5 = utf8.len(var_806_3)
				local var_806_6 = var_806_4 <= 0 and var_806_1 or var_806_1 * (var_806_5 / var_806_4)

				if var_806_6 > 0 and var_806_1 < var_806_6 then
					arg_803_1.talkMaxDuration = var_806_6

					if var_806_6 + var_806_0 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_6 + var_806_0
					end
				end

				arg_803_1.text_.text = var_806_3
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)
				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_7 = math.max(var_806_1, arg_803_1.talkMaxDuration)

			if var_806_0 <= arg_803_1.time_ and arg_803_1.time_ < var_806_0 + var_806_7 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_0) / var_806_7

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_0 + var_806_7 and arg_803_1.time_ < var_806_0 + var_806_7 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605203 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 1106605203
		arg_807_1.duration_ = 3.433

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play1106605204(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			local var_810_0 = arg_807_1.actors_["1066ui_story"].transform
			local var_810_1 = 0

			if var_810_1 < arg_807_1.time_ and arg_807_1.time_ <= var_810_1 + arg_810_0 then
				arg_807_1.var_.moveOldPos1066ui_story = var_810_0.localPosition
			end

			local var_810_2 = 0.001

			if var_810_1 <= arg_807_1.time_ and arg_807_1.time_ < var_810_1 + var_810_2 then
				local var_810_3 = (arg_807_1.time_ - var_810_1) / var_810_2
				local var_810_4 = Vector3.New(0, -0.77, -6.1)

				var_810_0.localPosition = Vector3.Lerp(arg_807_1.var_.moveOldPos1066ui_story, var_810_4, var_810_3)

				local var_810_5 = manager.ui.mainCamera.transform.position - var_810_0.position

				var_810_0.forward = Vector3.New(var_810_5.x, var_810_5.y, var_810_5.z)

				local var_810_6 = var_810_0.localEulerAngles

				var_810_6.z = 0
				var_810_6.x = 0
				var_810_0.localEulerAngles = var_810_6
			end

			if arg_807_1.time_ >= var_810_1 + var_810_2 and arg_807_1.time_ < var_810_1 + var_810_2 + arg_810_0 then
				var_810_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_810_7 = manager.ui.mainCamera.transform.position - var_810_0.position

				var_810_0.forward = Vector3.New(var_810_7.x, var_810_7.y, var_810_7.z)

				local var_810_8 = var_810_0.localEulerAngles

				var_810_8.z = 0
				var_810_8.x = 0
				var_810_0.localEulerAngles = var_810_8
			end

			local var_810_9 = arg_807_1.actors_["1066ui_story"]
			local var_810_10 = 0

			if var_810_10 < arg_807_1.time_ and arg_807_1.time_ <= var_810_10 + arg_810_0 and arg_807_1.var_.characterEffect1066ui_story == nil then
				arg_807_1.var_.characterEffect1066ui_story = var_810_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_810_11 = 0.200000002980232

			if var_810_10 <= arg_807_1.time_ and arg_807_1.time_ < var_810_10 + var_810_11 then
				local var_810_12 = (arg_807_1.time_ - var_810_10) / var_810_11

				if arg_807_1.var_.characterEffect1066ui_story then
					arg_807_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_807_1.time_ >= var_810_10 + var_810_11 and arg_807_1.time_ < var_810_10 + var_810_11 + arg_810_0 and arg_807_1.var_.characterEffect1066ui_story then
				arg_807_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_810_13 = 0

			if var_810_13 < arg_807_1.time_ and arg_807_1.time_ <= var_810_13 + arg_810_0 then
				arg_807_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_810_14 = 0

			if var_810_14 < arg_807_1.time_ and arg_807_1.time_ <= var_810_14 + arg_810_0 then
				arg_807_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_810_15 = 0
			local var_810_16 = 0.2

			if var_810_15 < arg_807_1.time_ and arg_807_1.time_ <= var_810_15 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				local var_810_17 = arg_807_1:FormatText(StoryNameCfg[32].name)

				arg_807_1.leftNameTxt_.text = var_810_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, false)
				arg_807_1.callingController_:SetSelectedState("normal")

				local var_810_18 = arg_807_1:GetWordFromCfg(1106605203)
				local var_810_19 = arg_807_1:FormatText(var_810_18.content)

				arg_807_1.text_.text = var_810_19

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_20 = 8
				local var_810_21 = utf8.len(var_810_19)
				local var_810_22 = var_810_20 <= 0 and var_810_16 or var_810_16 * (var_810_21 / var_810_20)

				if var_810_22 > 0 and var_810_16 < var_810_22 then
					arg_807_1.talkMaxDuration = var_810_22

					if var_810_22 + var_810_15 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_22 + var_810_15
					end
				end

				arg_807_1.text_.text = var_810_19
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605203", "story_v_side_new_1106605.awb") ~= 0 then
					local var_810_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605203", "story_v_side_new_1106605.awb") / 1000

					if var_810_23 + var_810_15 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_23 + var_810_15
					end

					if var_810_18.prefab_name ~= "" and arg_807_1.actors_[var_810_18.prefab_name] ~= nil then
						local var_810_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_807_1.actors_[var_810_18.prefab_name].transform, "story_v_side_new_1106605", "1106605203", "story_v_side_new_1106605.awb")

						arg_807_1:RecordAudio("1106605203", var_810_24)
						arg_807_1:RecordAudio("1106605203", var_810_24)
					else
						arg_807_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605203", "story_v_side_new_1106605.awb")
					end

					arg_807_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605203", "story_v_side_new_1106605.awb")
				end

				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_25 = math.max(var_810_16, arg_807_1.talkMaxDuration)

			if var_810_15 <= arg_807_1.time_ and arg_807_1.time_ < var_810_15 + var_810_25 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_15) / var_810_25

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_15 + var_810_25 and arg_807_1.time_ < var_810_15 + var_810_25 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605204 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 1106605204
		arg_811_1.duration_ = 5

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play1106605205(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			local var_814_0 = arg_811_1.actors_["1066ui_story"]
			local var_814_1 = 0

			if var_814_1 < arg_811_1.time_ and arg_811_1.time_ <= var_814_1 + arg_814_0 and arg_811_1.var_.characterEffect1066ui_story == nil then
				arg_811_1.var_.characterEffect1066ui_story = var_814_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_814_2 = 0.200000002980232

			if var_814_1 <= arg_811_1.time_ and arg_811_1.time_ < var_814_1 + var_814_2 then
				local var_814_3 = (arg_811_1.time_ - var_814_1) / var_814_2

				if arg_811_1.var_.characterEffect1066ui_story then
					local var_814_4 = Mathf.Lerp(0, 0.5, var_814_3)

					arg_811_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_811_1.var_.characterEffect1066ui_story.fillRatio = var_814_4
				end
			end

			if arg_811_1.time_ >= var_814_1 + var_814_2 and arg_811_1.time_ < var_814_1 + var_814_2 + arg_814_0 and arg_811_1.var_.characterEffect1066ui_story then
				local var_814_5 = 0.5

				arg_811_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_811_1.var_.characterEffect1066ui_story.fillRatio = var_814_5
			end

			local var_814_6 = 0
			local var_814_7 = 1.2

			if var_814_6 < arg_811_1.time_ and arg_811_1.time_ <= var_814_6 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, false)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_8 = arg_811_1:GetWordFromCfg(1106605204)
				local var_814_9 = arg_811_1:FormatText(var_814_8.content)

				arg_811_1.text_.text = var_814_9

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_10 = 48
				local var_814_11 = utf8.len(var_814_9)
				local var_814_12 = var_814_10 <= 0 and var_814_7 or var_814_7 * (var_814_11 / var_814_10)

				if var_814_12 > 0 and var_814_7 < var_814_12 then
					arg_811_1.talkMaxDuration = var_814_12

					if var_814_12 + var_814_6 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_12 + var_814_6
					end
				end

				arg_811_1.text_.text = var_814_9
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)
				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_13 = math.max(var_814_7, arg_811_1.talkMaxDuration)

			if var_814_6 <= arg_811_1.time_ and arg_811_1.time_ < var_814_6 + var_814_13 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_6) / var_814_13

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_6 + var_814_13 and arg_811_1.time_ < var_814_6 + var_814_13 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605205 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 1106605205
		arg_815_1.duration_ = 5

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
		end

		function arg_815_1.playNext_(arg_817_0)
			if arg_817_0 == 1 then
				arg_815_0:Play1106605206(arg_815_1)
			end
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			local var_818_0 = 0
			local var_818_1 = 0.5

			if var_818_0 < arg_815_1.time_ and arg_815_1.time_ <= var_818_0 + arg_818_0 then
				arg_815_1.talkMaxDuration = 0
				arg_815_1.dialogCg_.alpha = 1

				arg_815_1.dialog_:SetActive(true)
				SetActive(arg_815_1.leftNameGo_, true)

				local var_818_2 = arg_815_1:FormatText(StoryNameCfg[7].name)

				arg_815_1.leftNameTxt_.text = var_818_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_815_1.leftNameTxt_.transform)

				arg_815_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_815_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_815_1:RecordName(arg_815_1.leftNameTxt_.text)
				SetActive(arg_815_1.iconTrs_.gameObject, false)
				arg_815_1.callingController_:SetSelectedState("normal")

				local var_818_3 = arg_815_1:GetWordFromCfg(1106605205)
				local var_818_4 = arg_815_1:FormatText(var_818_3.content)

				arg_815_1.text_.text = var_818_4

				LuaForUtil.ClearLinePrefixSymbol(arg_815_1.text_)

				local var_818_5 = 20
				local var_818_6 = utf8.len(var_818_4)
				local var_818_7 = var_818_5 <= 0 and var_818_1 or var_818_1 * (var_818_6 / var_818_5)

				if var_818_7 > 0 and var_818_1 < var_818_7 then
					arg_815_1.talkMaxDuration = var_818_7

					if var_818_7 + var_818_0 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_7 + var_818_0
					end
				end

				arg_815_1.text_.text = var_818_4
				arg_815_1.typewritter.percent = 0

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(false)
				arg_815_1:RecordContent(arg_815_1.text_.text)
			end

			local var_818_8 = math.max(var_818_1, arg_815_1.talkMaxDuration)

			if var_818_0 <= arg_815_1.time_ and arg_815_1.time_ < var_818_0 + var_818_8 then
				arg_815_1.typewritter.percent = (arg_815_1.time_ - var_818_0) / var_818_8

				arg_815_1.typewritter:SetDirty()
			end

			if arg_815_1.time_ >= var_818_0 + var_818_8 and arg_815_1.time_ < var_818_0 + var_818_8 + arg_818_0 then
				arg_815_1.typewritter.percent = 1

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605206 = function(arg_819_0, arg_819_1)
		arg_819_1.time_ = 0
		arg_819_1.frameCnt_ = 0
		arg_819_1.state_ = "playing"
		arg_819_1.curTalkId_ = 1106605206
		arg_819_1.duration_ = 5

		SetActive(arg_819_1.tipsGo_, false)

		function arg_819_1.onSingleLineFinish_()
			arg_819_1.onSingleLineUpdate_ = nil
			arg_819_1.onSingleLineFinish_ = nil
			arg_819_1.state_ = "waiting"
		end

		function arg_819_1.playNext_(arg_821_0)
			if arg_821_0 == 1 then
				arg_819_0:Play1106605207(arg_819_1)
			end
		end

		function arg_819_1.onSingleLineUpdate_(arg_822_0)
			local var_822_0 = 0
			local var_822_1 = 0.35

			if var_822_0 < arg_819_1.time_ and arg_819_1.time_ <= var_822_0 + arg_822_0 then
				arg_819_1.talkMaxDuration = 0
				arg_819_1.dialogCg_.alpha = 1

				arg_819_1.dialog_:SetActive(true)
				SetActive(arg_819_1.leftNameGo_, true)

				local var_822_2 = arg_819_1:FormatText(StoryNameCfg[7].name)

				arg_819_1.leftNameTxt_.text = var_822_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_819_1.leftNameTxt_.transform)

				arg_819_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_819_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_819_1:RecordName(arg_819_1.leftNameTxt_.text)
				SetActive(arg_819_1.iconTrs_.gameObject, false)
				arg_819_1.callingController_:SetSelectedState("normal")

				local var_822_3 = arg_819_1:GetWordFromCfg(1106605206)
				local var_822_4 = arg_819_1:FormatText(var_822_3.content)

				arg_819_1.text_.text = var_822_4

				LuaForUtil.ClearLinePrefixSymbol(arg_819_1.text_)

				local var_822_5 = 14
				local var_822_6 = utf8.len(var_822_4)
				local var_822_7 = var_822_5 <= 0 and var_822_1 or var_822_1 * (var_822_6 / var_822_5)

				if var_822_7 > 0 and var_822_1 < var_822_7 then
					arg_819_1.talkMaxDuration = var_822_7

					if var_822_7 + var_822_0 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_7 + var_822_0
					end
				end

				arg_819_1.text_.text = var_822_4
				arg_819_1.typewritter.percent = 0

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(false)
				arg_819_1:RecordContent(arg_819_1.text_.text)
			end

			local var_822_8 = math.max(var_822_1, arg_819_1.talkMaxDuration)

			if var_822_0 <= arg_819_1.time_ and arg_819_1.time_ < var_822_0 + var_822_8 then
				arg_819_1.typewritter.percent = (arg_819_1.time_ - var_822_0) / var_822_8

				arg_819_1.typewritter:SetDirty()
			end

			if arg_819_1.time_ >= var_822_0 + var_822_8 and arg_819_1.time_ < var_822_0 + var_822_8 + arg_822_0 then
				arg_819_1.typewritter.percent = 1

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605207 = function(arg_823_0, arg_823_1)
		arg_823_1.time_ = 0
		arg_823_1.frameCnt_ = 0
		arg_823_1.state_ = "playing"
		arg_823_1.curTalkId_ = 1106605207
		arg_823_1.duration_ = 3.666

		SetActive(arg_823_1.tipsGo_, false)

		function arg_823_1.onSingleLineFinish_()
			arg_823_1.onSingleLineUpdate_ = nil
			arg_823_1.onSingleLineFinish_ = nil
			arg_823_1.state_ = "waiting"
		end

		function arg_823_1.playNext_(arg_825_0)
			if arg_825_0 == 1 then
				arg_823_0:Play1106605208(arg_823_1)
			end
		end

		function arg_823_1.onSingleLineUpdate_(arg_826_0)
			local var_826_0 = arg_823_1.actors_["1066ui_story"].transform
			local var_826_1 = 0

			if var_826_1 < arg_823_1.time_ and arg_823_1.time_ <= var_826_1 + arg_826_0 then
				arg_823_1.var_.moveOldPos1066ui_story = var_826_0.localPosition
			end

			local var_826_2 = 0.001

			if var_826_1 <= arg_823_1.time_ and arg_823_1.time_ < var_826_1 + var_826_2 then
				local var_826_3 = (arg_823_1.time_ - var_826_1) / var_826_2
				local var_826_4 = Vector3.New(0, -0.77, -6.1)

				var_826_0.localPosition = Vector3.Lerp(arg_823_1.var_.moveOldPos1066ui_story, var_826_4, var_826_3)

				local var_826_5 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_5.x, var_826_5.y, var_826_5.z)

				local var_826_6 = var_826_0.localEulerAngles

				var_826_6.z = 0
				var_826_6.x = 0
				var_826_0.localEulerAngles = var_826_6
			end

			if arg_823_1.time_ >= var_826_1 + var_826_2 and arg_823_1.time_ < var_826_1 + var_826_2 + arg_826_0 then
				var_826_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_826_7 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_7.x, var_826_7.y, var_826_7.z)

				local var_826_8 = var_826_0.localEulerAngles

				var_826_8.z = 0
				var_826_8.x = 0
				var_826_0.localEulerAngles = var_826_8
			end

			local var_826_9 = arg_823_1.actors_["1066ui_story"]
			local var_826_10 = 0

			if var_826_10 < arg_823_1.time_ and arg_823_1.time_ <= var_826_10 + arg_826_0 and arg_823_1.var_.characterEffect1066ui_story == nil then
				arg_823_1.var_.characterEffect1066ui_story = var_826_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_826_11 = 0.200000002980232

			if var_826_10 <= arg_823_1.time_ and arg_823_1.time_ < var_826_10 + var_826_11 then
				local var_826_12 = (arg_823_1.time_ - var_826_10) / var_826_11

				if arg_823_1.var_.characterEffect1066ui_story then
					arg_823_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_823_1.time_ >= var_826_10 + var_826_11 and arg_823_1.time_ < var_826_10 + var_826_11 + arg_826_0 and arg_823_1.var_.characterEffect1066ui_story then
				arg_823_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_826_13 = 0

			if var_826_13 < arg_823_1.time_ and arg_823_1.time_ <= var_826_13 + arg_826_0 then
				arg_823_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_826_14 = 0
			local var_826_15 = 0.425

			if var_826_14 < arg_823_1.time_ and arg_823_1.time_ <= var_826_14 + arg_826_0 then
				arg_823_1.talkMaxDuration = 0
				arg_823_1.dialogCg_.alpha = 1

				arg_823_1.dialog_:SetActive(true)
				SetActive(arg_823_1.leftNameGo_, true)

				local var_826_16 = arg_823_1:FormatText(StoryNameCfg[32].name)

				arg_823_1.leftNameTxt_.text = var_826_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_823_1.leftNameTxt_.transform)

				arg_823_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_823_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_823_1:RecordName(arg_823_1.leftNameTxt_.text)
				SetActive(arg_823_1.iconTrs_.gameObject, false)
				arg_823_1.callingController_:SetSelectedState("normal")

				local var_826_17 = arg_823_1:GetWordFromCfg(1106605207)
				local var_826_18 = arg_823_1:FormatText(var_826_17.content)

				arg_823_1.text_.text = var_826_18

				LuaForUtil.ClearLinePrefixSymbol(arg_823_1.text_)

				local var_826_19 = 17
				local var_826_20 = utf8.len(var_826_18)
				local var_826_21 = var_826_19 <= 0 and var_826_15 or var_826_15 * (var_826_20 / var_826_19)

				if var_826_21 > 0 and var_826_15 < var_826_21 then
					arg_823_1.talkMaxDuration = var_826_21

					if var_826_21 + var_826_14 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_21 + var_826_14
					end
				end

				arg_823_1.text_.text = var_826_18
				arg_823_1.typewritter.percent = 0

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605207", "story_v_side_new_1106605.awb") ~= 0 then
					local var_826_22 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605207", "story_v_side_new_1106605.awb") / 1000

					if var_826_22 + var_826_14 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_22 + var_826_14
					end

					if var_826_17.prefab_name ~= "" and arg_823_1.actors_[var_826_17.prefab_name] ~= nil then
						local var_826_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_823_1.actors_[var_826_17.prefab_name].transform, "story_v_side_new_1106605", "1106605207", "story_v_side_new_1106605.awb")

						arg_823_1:RecordAudio("1106605207", var_826_23)
						arg_823_1:RecordAudio("1106605207", var_826_23)
					else
						arg_823_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605207", "story_v_side_new_1106605.awb")
					end

					arg_823_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605207", "story_v_side_new_1106605.awb")
				end

				arg_823_1:RecordContent(arg_823_1.text_.text)
			end

			local var_826_24 = math.max(var_826_15, arg_823_1.talkMaxDuration)

			if var_826_14 <= arg_823_1.time_ and arg_823_1.time_ < var_826_14 + var_826_24 then
				arg_823_1.typewritter.percent = (arg_823_1.time_ - var_826_14) / var_826_24

				arg_823_1.typewritter:SetDirty()
			end

			if arg_823_1.time_ >= var_826_14 + var_826_24 and arg_823_1.time_ < var_826_14 + var_826_24 + arg_826_0 then
				arg_823_1.typewritter.percent = 1

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605208 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 1106605208
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play1106605209(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = arg_827_1.actors_["1066ui_story"]
			local var_830_1 = 0

			if var_830_1 < arg_827_1.time_ and arg_827_1.time_ <= var_830_1 + arg_830_0 and arg_827_1.var_.characterEffect1066ui_story == nil then
				arg_827_1.var_.characterEffect1066ui_story = var_830_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_830_2 = 0.200000002980232

			if var_830_1 <= arg_827_1.time_ and arg_827_1.time_ < var_830_1 + var_830_2 then
				local var_830_3 = (arg_827_1.time_ - var_830_1) / var_830_2

				if arg_827_1.var_.characterEffect1066ui_story then
					local var_830_4 = Mathf.Lerp(0, 0.5, var_830_3)

					arg_827_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_827_1.var_.characterEffect1066ui_story.fillRatio = var_830_4
				end
			end

			if arg_827_1.time_ >= var_830_1 + var_830_2 and arg_827_1.time_ < var_830_1 + var_830_2 + arg_830_0 and arg_827_1.var_.characterEffect1066ui_story then
				local var_830_5 = 0.5

				arg_827_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_827_1.var_.characterEffect1066ui_story.fillRatio = var_830_5
			end

			local var_830_6 = 0
			local var_830_7 = 1.15

			if var_830_6 < arg_827_1.time_ and arg_827_1.time_ <= var_830_6 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, false)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_827_1.iconTrs_.gameObject, false)
				arg_827_1.callingController_:SetSelectedState("normal")

				local var_830_8 = arg_827_1:GetWordFromCfg(1106605208)
				local var_830_9 = arg_827_1:FormatText(var_830_8.content)

				arg_827_1.text_.text = var_830_9

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_10 = 46
				local var_830_11 = utf8.len(var_830_9)
				local var_830_12 = var_830_10 <= 0 and var_830_7 or var_830_7 * (var_830_11 / var_830_10)

				if var_830_12 > 0 and var_830_7 < var_830_12 then
					arg_827_1.talkMaxDuration = var_830_12

					if var_830_12 + var_830_6 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_12 + var_830_6
					end
				end

				arg_827_1.text_.text = var_830_9
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_13 = math.max(var_830_7, arg_827_1.talkMaxDuration)

			if var_830_6 <= arg_827_1.time_ and arg_827_1.time_ < var_830_6 + var_830_13 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - var_830_6) / var_830_13

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= var_830_6 + var_830_13 and arg_827_1.time_ < var_830_6 + var_830_13 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605209 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 1106605209
		arg_831_1.duration_ = 5

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play1106605210(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			local var_834_0 = 0
			local var_834_1 = 0.35

			if var_834_0 < arg_831_1.time_ and arg_831_1.time_ <= var_834_0 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, false)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_2 = arg_831_1:GetWordFromCfg(1106605209)
				local var_834_3 = arg_831_1:FormatText(var_834_2.content)

				arg_831_1.text_.text = var_834_3

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_4 = 14
				local var_834_5 = utf8.len(var_834_3)
				local var_834_6 = var_834_4 <= 0 and var_834_1 or var_834_1 * (var_834_5 / var_834_4)

				if var_834_6 > 0 and var_834_1 < var_834_6 then
					arg_831_1.talkMaxDuration = var_834_6

					if var_834_6 + var_834_0 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_6 + var_834_0
					end
				end

				arg_831_1.text_.text = var_834_3
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)
				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_7 = math.max(var_834_1, arg_831_1.talkMaxDuration)

			if var_834_0 <= arg_831_1.time_ and arg_831_1.time_ < var_834_0 + var_834_7 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_0) / var_834_7

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_0 + var_834_7 and arg_831_1.time_ < var_834_0 + var_834_7 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605210 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 1106605210
		arg_835_1.duration_ = 4.066

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play1106605211(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = arg_835_1.actors_["1066ui_story"].transform
			local var_838_1 = 0

			if var_838_1 < arg_835_1.time_ and arg_835_1.time_ <= var_838_1 + arg_838_0 then
				arg_835_1.var_.moveOldPos1066ui_story = var_838_0.localPosition
			end

			local var_838_2 = 0.001

			if var_838_1 <= arg_835_1.time_ and arg_835_1.time_ < var_838_1 + var_838_2 then
				local var_838_3 = (arg_835_1.time_ - var_838_1) / var_838_2
				local var_838_4 = Vector3.New(0, -0.77, -6.1)

				var_838_0.localPosition = Vector3.Lerp(arg_835_1.var_.moveOldPos1066ui_story, var_838_4, var_838_3)

				local var_838_5 = manager.ui.mainCamera.transform.position - var_838_0.position

				var_838_0.forward = Vector3.New(var_838_5.x, var_838_5.y, var_838_5.z)

				local var_838_6 = var_838_0.localEulerAngles

				var_838_6.z = 0
				var_838_6.x = 0
				var_838_0.localEulerAngles = var_838_6
			end

			if arg_835_1.time_ >= var_838_1 + var_838_2 and arg_835_1.time_ < var_838_1 + var_838_2 + arg_838_0 then
				var_838_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_838_7 = manager.ui.mainCamera.transform.position - var_838_0.position

				var_838_0.forward = Vector3.New(var_838_7.x, var_838_7.y, var_838_7.z)

				local var_838_8 = var_838_0.localEulerAngles

				var_838_8.z = 0
				var_838_8.x = 0
				var_838_0.localEulerAngles = var_838_8
			end

			local var_838_9 = arg_835_1.actors_["1066ui_story"]
			local var_838_10 = 0

			if var_838_10 < arg_835_1.time_ and arg_835_1.time_ <= var_838_10 + arg_838_0 and arg_835_1.var_.characterEffect1066ui_story == nil then
				arg_835_1.var_.characterEffect1066ui_story = var_838_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_838_11 = 0.200000002980232

			if var_838_10 <= arg_835_1.time_ and arg_835_1.time_ < var_838_10 + var_838_11 then
				local var_838_12 = (arg_835_1.time_ - var_838_10) / var_838_11

				if arg_835_1.var_.characterEffect1066ui_story then
					arg_835_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_835_1.time_ >= var_838_10 + var_838_11 and arg_835_1.time_ < var_838_10 + var_838_11 + arg_838_0 and arg_835_1.var_.characterEffect1066ui_story then
				arg_835_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_838_13 = 0

			if var_838_13 < arg_835_1.time_ and arg_835_1.time_ <= var_838_13 + arg_838_0 then
				arg_835_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_2")
			end

			local var_838_14 = 0

			if var_838_14 < arg_835_1.time_ and arg_835_1.time_ <= var_838_14 + arg_838_0 then
				arg_835_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_838_15 = 0
			local var_838_16 = 0.4

			if var_838_15 < arg_835_1.time_ and arg_835_1.time_ <= var_838_15 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				local var_838_17 = arg_835_1:FormatText(StoryNameCfg[32].name)

				arg_835_1.leftNameTxt_.text = var_838_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, false)
				arg_835_1.callingController_:SetSelectedState("normal")

				local var_838_18 = arg_835_1:GetWordFromCfg(1106605210)
				local var_838_19 = arg_835_1:FormatText(var_838_18.content)

				arg_835_1.text_.text = var_838_19

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_20 = 16
				local var_838_21 = utf8.len(var_838_19)
				local var_838_22 = var_838_20 <= 0 and var_838_16 or var_838_16 * (var_838_21 / var_838_20)

				if var_838_22 > 0 and var_838_16 < var_838_22 then
					arg_835_1.talkMaxDuration = var_838_22

					if var_838_22 + var_838_15 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_22 + var_838_15
					end
				end

				arg_835_1.text_.text = var_838_19
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605210", "story_v_side_new_1106605.awb") ~= 0 then
					local var_838_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605210", "story_v_side_new_1106605.awb") / 1000

					if var_838_23 + var_838_15 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_23 + var_838_15
					end

					if var_838_18.prefab_name ~= "" and arg_835_1.actors_[var_838_18.prefab_name] ~= nil then
						local var_838_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_835_1.actors_[var_838_18.prefab_name].transform, "story_v_side_new_1106605", "1106605210", "story_v_side_new_1106605.awb")

						arg_835_1:RecordAudio("1106605210", var_838_24)
						arg_835_1:RecordAudio("1106605210", var_838_24)
					else
						arg_835_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605210", "story_v_side_new_1106605.awb")
					end

					arg_835_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605210", "story_v_side_new_1106605.awb")
				end

				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_25 = math.max(var_838_16, arg_835_1.talkMaxDuration)

			if var_838_15 <= arg_835_1.time_ and arg_835_1.time_ < var_838_15 + var_838_25 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - var_838_15) / var_838_25

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= var_838_15 + var_838_25 and arg_835_1.time_ < var_838_15 + var_838_25 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605211 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 1106605211
		arg_839_1.duration_ = 2.033

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
		end

		function arg_839_1.playNext_(arg_841_0)
			if arg_841_0 == 1 then
				arg_839_0:Play1106605212(arg_839_1)
			end
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			local var_842_0 = arg_839_1.actors_["1066ui_story"].transform
			local var_842_1 = 0

			if var_842_1 < arg_839_1.time_ and arg_839_1.time_ <= var_842_1 + arg_842_0 then
				arg_839_1.var_.moveOldPos1066ui_story = var_842_0.localPosition
			end

			local var_842_2 = 0.001

			if var_842_1 <= arg_839_1.time_ and arg_839_1.time_ < var_842_1 + var_842_2 then
				local var_842_3 = (arg_839_1.time_ - var_842_1) / var_842_2
				local var_842_4 = Vector3.New(0, -0.77, -6.1)

				var_842_0.localPosition = Vector3.Lerp(arg_839_1.var_.moveOldPos1066ui_story, var_842_4, var_842_3)

				local var_842_5 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_5.x, var_842_5.y, var_842_5.z)

				local var_842_6 = var_842_0.localEulerAngles

				var_842_6.z = 0
				var_842_6.x = 0
				var_842_0.localEulerAngles = var_842_6
			end

			if arg_839_1.time_ >= var_842_1 + var_842_2 and arg_839_1.time_ < var_842_1 + var_842_2 + arg_842_0 then
				var_842_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_842_7 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_7.x, var_842_7.y, var_842_7.z)

				local var_842_8 = var_842_0.localEulerAngles

				var_842_8.z = 0
				var_842_8.x = 0
				var_842_0.localEulerAngles = var_842_8
			end

			local var_842_9 = arg_839_1.actors_["1066ui_story"]
			local var_842_10 = 0

			if var_842_10 < arg_839_1.time_ and arg_839_1.time_ <= var_842_10 + arg_842_0 and arg_839_1.var_.characterEffect1066ui_story == nil then
				arg_839_1.var_.characterEffect1066ui_story = var_842_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_11 = 0.200000002980232

			if var_842_10 <= arg_839_1.time_ and arg_839_1.time_ < var_842_10 + var_842_11 then
				local var_842_12 = (arg_839_1.time_ - var_842_10) / var_842_11

				if arg_839_1.var_.characterEffect1066ui_story then
					arg_839_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_839_1.time_ >= var_842_10 + var_842_11 and arg_839_1.time_ < var_842_10 + var_842_11 + arg_842_0 and arg_839_1.var_.characterEffect1066ui_story then
				arg_839_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_842_13 = 0
			local var_842_14 = 0.2

			if var_842_13 < arg_839_1.time_ and arg_839_1.time_ <= var_842_13 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				local var_842_15 = arg_839_1:FormatText(StoryNameCfg[579].name)

				arg_839_1.leftNameTxt_.text = var_842_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_16 = arg_839_1:GetWordFromCfg(1106605211)
				local var_842_17 = arg_839_1:FormatText(var_842_16.content)

				arg_839_1.text_.text = var_842_17

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_18 = 8
				local var_842_19 = utf8.len(var_842_17)
				local var_842_20 = var_842_18 <= 0 and var_842_14 or var_842_14 * (var_842_19 / var_842_18)

				if var_842_20 > 0 and var_842_14 < var_842_20 then
					arg_839_1.talkMaxDuration = var_842_20

					if var_842_20 + var_842_13 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_20 + var_842_13
					end
				end

				arg_839_1.text_.text = var_842_17
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605211", "story_v_side_new_1106605.awb") ~= 0 then
					local var_842_21 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605211", "story_v_side_new_1106605.awb") / 1000

					if var_842_21 + var_842_13 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_21 + var_842_13
					end

					if var_842_16.prefab_name ~= "" and arg_839_1.actors_[var_842_16.prefab_name] ~= nil then
						local var_842_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_839_1.actors_[var_842_16.prefab_name].transform, "story_v_side_new_1106605", "1106605211", "story_v_side_new_1106605.awb")

						arg_839_1:RecordAudio("1106605211", var_842_22)
						arg_839_1:RecordAudio("1106605211", var_842_22)
					else
						arg_839_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605211", "story_v_side_new_1106605.awb")
					end

					arg_839_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605211", "story_v_side_new_1106605.awb")
				end

				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_23 = math.max(var_842_14, arg_839_1.talkMaxDuration)

			if var_842_13 <= arg_839_1.time_ and arg_839_1.time_ < var_842_13 + var_842_23 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_13) / var_842_23

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_13 + var_842_23 and arg_839_1.time_ < var_842_13 + var_842_23 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605212 = function(arg_843_0, arg_843_1)
		arg_843_1.time_ = 0
		arg_843_1.frameCnt_ = 0
		arg_843_1.state_ = "playing"
		arg_843_1.curTalkId_ = 1106605212
		arg_843_1.duration_ = 5

		SetActive(arg_843_1.tipsGo_, false)

		function arg_843_1.onSingleLineFinish_()
			arg_843_1.onSingleLineUpdate_ = nil
			arg_843_1.onSingleLineFinish_ = nil
			arg_843_1.state_ = "waiting"
		end

		function arg_843_1.playNext_(arg_845_0)
			if arg_845_0 == 1 then
				arg_843_0:Play1106605213(arg_843_1)
			end
		end

		function arg_843_1.onSingleLineUpdate_(arg_846_0)
			local var_846_0 = arg_843_1.actors_["1066ui_story"]
			local var_846_1 = 0

			if var_846_1 < arg_843_1.time_ and arg_843_1.time_ <= var_846_1 + arg_846_0 and arg_843_1.var_.characterEffect1066ui_story == nil then
				arg_843_1.var_.characterEffect1066ui_story = var_846_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_846_2 = 0.200000002980232

			if var_846_1 <= arg_843_1.time_ and arg_843_1.time_ < var_846_1 + var_846_2 then
				local var_846_3 = (arg_843_1.time_ - var_846_1) / var_846_2

				if arg_843_1.var_.characterEffect1066ui_story then
					local var_846_4 = Mathf.Lerp(0, 0.5, var_846_3)

					arg_843_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_843_1.var_.characterEffect1066ui_story.fillRatio = var_846_4
				end
			end

			if arg_843_1.time_ >= var_846_1 + var_846_2 and arg_843_1.time_ < var_846_1 + var_846_2 + arg_846_0 and arg_843_1.var_.characterEffect1066ui_story then
				local var_846_5 = 0.5

				arg_843_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_843_1.var_.characterEffect1066ui_story.fillRatio = var_846_5
			end

			local var_846_6 = 0
			local var_846_7 = 0.125

			if var_846_6 < arg_843_1.time_ and arg_843_1.time_ <= var_846_6 + arg_846_0 then
				arg_843_1.talkMaxDuration = 0
				arg_843_1.dialogCg_.alpha = 1

				arg_843_1.dialog_:SetActive(true)
				SetActive(arg_843_1.leftNameGo_, true)

				local var_846_8 = arg_843_1:FormatText(StoryNameCfg[7].name)

				arg_843_1.leftNameTxt_.text = var_846_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_843_1.leftNameTxt_.transform)

				arg_843_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_843_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_843_1:RecordName(arg_843_1.leftNameTxt_.text)
				SetActive(arg_843_1.iconTrs_.gameObject, false)
				arg_843_1.callingController_:SetSelectedState("normal")

				local var_846_9 = arg_843_1:GetWordFromCfg(1106605212)
				local var_846_10 = arg_843_1:FormatText(var_846_9.content)

				arg_843_1.text_.text = var_846_10

				LuaForUtil.ClearLinePrefixSymbol(arg_843_1.text_)

				local var_846_11 = 5
				local var_846_12 = utf8.len(var_846_10)
				local var_846_13 = var_846_11 <= 0 and var_846_7 or var_846_7 * (var_846_12 / var_846_11)

				if var_846_13 > 0 and var_846_7 < var_846_13 then
					arg_843_1.talkMaxDuration = var_846_13

					if var_846_13 + var_846_6 > arg_843_1.duration_ then
						arg_843_1.duration_ = var_846_13 + var_846_6
					end
				end

				arg_843_1.text_.text = var_846_10
				arg_843_1.typewritter.percent = 0

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(false)
				arg_843_1:RecordContent(arg_843_1.text_.text)
			end

			local var_846_14 = math.max(var_846_7, arg_843_1.talkMaxDuration)

			if var_846_6 <= arg_843_1.time_ and arg_843_1.time_ < var_846_6 + var_846_14 then
				arg_843_1.typewritter.percent = (arg_843_1.time_ - var_846_6) / var_846_14

				arg_843_1.typewritter:SetDirty()
			end

			if arg_843_1.time_ >= var_846_6 + var_846_14 and arg_843_1.time_ < var_846_6 + var_846_14 + arg_846_0 then
				arg_843_1.typewritter.percent = 1

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605213 = function(arg_847_0, arg_847_1)
		arg_847_1.time_ = 0
		arg_847_1.frameCnt_ = 0
		arg_847_1.state_ = "playing"
		arg_847_1.curTalkId_ = 1106605213
		arg_847_1.duration_ = 5

		SetActive(arg_847_1.tipsGo_, false)

		function arg_847_1.onSingleLineFinish_()
			arg_847_1.onSingleLineUpdate_ = nil
			arg_847_1.onSingleLineFinish_ = nil
			arg_847_1.state_ = "waiting"
		end

		function arg_847_1.playNext_(arg_849_0)
			if arg_849_0 == 1 then
				arg_847_0:Play1106605214(arg_847_1)
			end
		end

		function arg_847_1.onSingleLineUpdate_(arg_850_0)
			local var_850_0 = 0
			local var_850_1 = 0.8

			if var_850_0 < arg_847_1.time_ and arg_847_1.time_ <= var_850_0 + arg_850_0 then
				arg_847_1.talkMaxDuration = 0
				arg_847_1.dialogCg_.alpha = 1

				arg_847_1.dialog_:SetActive(true)
				SetActive(arg_847_1.leftNameGo_, false)

				arg_847_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_847_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_847_1:RecordName(arg_847_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_847_1.iconTrs_.gameObject, false)
				arg_847_1.callingController_:SetSelectedState("normal")

				local var_850_2 = arg_847_1:GetWordFromCfg(1106605213)
				local var_850_3 = arg_847_1:FormatText(var_850_2.content)

				arg_847_1.text_.text = var_850_3

				LuaForUtil.ClearLinePrefixSymbol(arg_847_1.text_)

				local var_850_4 = 32
				local var_850_5 = utf8.len(var_850_3)
				local var_850_6 = var_850_4 <= 0 and var_850_1 or var_850_1 * (var_850_5 / var_850_4)

				if var_850_6 > 0 and var_850_1 < var_850_6 then
					arg_847_1.talkMaxDuration = var_850_6

					if var_850_6 + var_850_0 > arg_847_1.duration_ then
						arg_847_1.duration_ = var_850_6 + var_850_0
					end
				end

				arg_847_1.text_.text = var_850_3
				arg_847_1.typewritter.percent = 0

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(false)
				arg_847_1:RecordContent(arg_847_1.text_.text)
			end

			local var_850_7 = math.max(var_850_1, arg_847_1.talkMaxDuration)

			if var_850_0 <= arg_847_1.time_ and arg_847_1.time_ < var_850_0 + var_850_7 then
				arg_847_1.typewritter.percent = (arg_847_1.time_ - var_850_0) / var_850_7

				arg_847_1.typewritter:SetDirty()
			end

			if arg_847_1.time_ >= var_850_0 + var_850_7 and arg_847_1.time_ < var_850_0 + var_850_7 + arg_850_0 then
				arg_847_1.typewritter.percent = 1

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605214 = function(arg_851_0, arg_851_1)
		arg_851_1.time_ = 0
		arg_851_1.frameCnt_ = 0
		arg_851_1.state_ = "playing"
		arg_851_1.curTalkId_ = 1106605214
		arg_851_1.duration_ = 7.8

		SetActive(arg_851_1.tipsGo_, false)

		function arg_851_1.onSingleLineFinish_()
			arg_851_1.onSingleLineUpdate_ = nil
			arg_851_1.onSingleLineFinish_ = nil
			arg_851_1.state_ = "waiting"
		end

		function arg_851_1.playNext_(arg_853_0)
			if arg_853_0 == 1 then
				arg_851_0:Play1106605215(arg_851_1)
			end
		end

		function arg_851_1.onSingleLineUpdate_(arg_854_0)
			local var_854_0 = arg_851_1.actors_["1066ui_story"].transform
			local var_854_1 = 0

			if var_854_1 < arg_851_1.time_ and arg_851_1.time_ <= var_854_1 + arg_854_0 then
				arg_851_1.var_.moveOldPos1066ui_story = var_854_0.localPosition
			end

			local var_854_2 = 0.001

			if var_854_1 <= arg_851_1.time_ and arg_851_1.time_ < var_854_1 + var_854_2 then
				local var_854_3 = (arg_851_1.time_ - var_854_1) / var_854_2
				local var_854_4 = Vector3.New(0, -0.77, -6.1)

				var_854_0.localPosition = Vector3.Lerp(arg_851_1.var_.moveOldPos1066ui_story, var_854_4, var_854_3)

				local var_854_5 = manager.ui.mainCamera.transform.position - var_854_0.position

				var_854_0.forward = Vector3.New(var_854_5.x, var_854_5.y, var_854_5.z)

				local var_854_6 = var_854_0.localEulerAngles

				var_854_6.z = 0
				var_854_6.x = 0
				var_854_0.localEulerAngles = var_854_6
			end

			if arg_851_1.time_ >= var_854_1 + var_854_2 and arg_851_1.time_ < var_854_1 + var_854_2 + arg_854_0 then
				var_854_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_854_7 = manager.ui.mainCamera.transform.position - var_854_0.position

				var_854_0.forward = Vector3.New(var_854_7.x, var_854_7.y, var_854_7.z)

				local var_854_8 = var_854_0.localEulerAngles

				var_854_8.z = 0
				var_854_8.x = 0
				var_854_0.localEulerAngles = var_854_8
			end

			local var_854_9 = arg_851_1.actors_["1066ui_story"]
			local var_854_10 = 0

			if var_854_10 < arg_851_1.time_ and arg_851_1.time_ <= var_854_10 + arg_854_0 and arg_851_1.var_.characterEffect1066ui_story == nil then
				arg_851_1.var_.characterEffect1066ui_story = var_854_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_854_11 = 0.200000002980232

			if var_854_10 <= arg_851_1.time_ and arg_851_1.time_ < var_854_10 + var_854_11 then
				local var_854_12 = (arg_851_1.time_ - var_854_10) / var_854_11

				if arg_851_1.var_.characterEffect1066ui_story then
					arg_851_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_851_1.time_ >= var_854_10 + var_854_11 and arg_851_1.time_ < var_854_10 + var_854_11 + arg_854_0 and arg_851_1.var_.characterEffect1066ui_story then
				arg_851_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_854_13 = 0

			if var_854_13 < arg_851_1.time_ and arg_851_1.time_ <= var_854_13 + arg_854_0 then
				arg_851_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			local var_854_14 = 0

			if var_854_14 < arg_851_1.time_ and arg_851_1.time_ <= var_854_14 + arg_854_0 then
				arg_851_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_854_15 = 0
			local var_854_16 = 0.925

			if var_854_15 < arg_851_1.time_ and arg_851_1.time_ <= var_854_15 + arg_854_0 then
				arg_851_1.talkMaxDuration = 0
				arg_851_1.dialogCg_.alpha = 1

				arg_851_1.dialog_:SetActive(true)
				SetActive(arg_851_1.leftNameGo_, true)

				local var_854_17 = arg_851_1:FormatText(StoryNameCfg[32].name)

				arg_851_1.leftNameTxt_.text = var_854_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_851_1.leftNameTxt_.transform)

				arg_851_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_851_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_851_1:RecordName(arg_851_1.leftNameTxt_.text)
				SetActive(arg_851_1.iconTrs_.gameObject, false)
				arg_851_1.callingController_:SetSelectedState("normal")

				local var_854_18 = arg_851_1:GetWordFromCfg(1106605214)
				local var_854_19 = arg_851_1:FormatText(var_854_18.content)

				arg_851_1.text_.text = var_854_19

				LuaForUtil.ClearLinePrefixSymbol(arg_851_1.text_)

				local var_854_20 = 37
				local var_854_21 = utf8.len(var_854_19)
				local var_854_22 = var_854_20 <= 0 and var_854_16 or var_854_16 * (var_854_21 / var_854_20)

				if var_854_22 > 0 and var_854_16 < var_854_22 then
					arg_851_1.talkMaxDuration = var_854_22

					if var_854_22 + var_854_15 > arg_851_1.duration_ then
						arg_851_1.duration_ = var_854_22 + var_854_15
					end
				end

				arg_851_1.text_.text = var_854_19
				arg_851_1.typewritter.percent = 0

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605214", "story_v_side_new_1106605.awb") ~= 0 then
					local var_854_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605214", "story_v_side_new_1106605.awb") / 1000

					if var_854_23 + var_854_15 > arg_851_1.duration_ then
						arg_851_1.duration_ = var_854_23 + var_854_15
					end

					if var_854_18.prefab_name ~= "" and arg_851_1.actors_[var_854_18.prefab_name] ~= nil then
						local var_854_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_851_1.actors_[var_854_18.prefab_name].transform, "story_v_side_new_1106605", "1106605214", "story_v_side_new_1106605.awb")

						arg_851_1:RecordAudio("1106605214", var_854_24)
						arg_851_1:RecordAudio("1106605214", var_854_24)
					else
						arg_851_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605214", "story_v_side_new_1106605.awb")
					end

					arg_851_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605214", "story_v_side_new_1106605.awb")
				end

				arg_851_1:RecordContent(arg_851_1.text_.text)
			end

			local var_854_25 = math.max(var_854_16, arg_851_1.talkMaxDuration)

			if var_854_15 <= arg_851_1.time_ and arg_851_1.time_ < var_854_15 + var_854_25 then
				arg_851_1.typewritter.percent = (arg_851_1.time_ - var_854_15) / var_854_25

				arg_851_1.typewritter:SetDirty()
			end

			if arg_851_1.time_ >= var_854_15 + var_854_25 and arg_851_1.time_ < var_854_15 + var_854_25 + arg_854_0 then
				arg_851_1.typewritter.percent = 1

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605215 = function(arg_855_0, arg_855_1)
		arg_855_1.time_ = 0
		arg_855_1.frameCnt_ = 0
		arg_855_1.state_ = "playing"
		arg_855_1.curTalkId_ = 1106605215
		arg_855_1.duration_ = 5

		SetActive(arg_855_1.tipsGo_, false)

		function arg_855_1.onSingleLineFinish_()
			arg_855_1.onSingleLineUpdate_ = nil
			arg_855_1.onSingleLineFinish_ = nil
			arg_855_1.state_ = "waiting"
		end

		function arg_855_1.playNext_(arg_857_0)
			if arg_857_0 == 1 then
				arg_855_0:Play1106605216(arg_855_1)
			end
		end

		function arg_855_1.onSingleLineUpdate_(arg_858_0)
			local var_858_0 = arg_855_1.actors_["1066ui_story"]
			local var_858_1 = 0

			if var_858_1 < arg_855_1.time_ and arg_855_1.time_ <= var_858_1 + arg_858_0 and arg_855_1.var_.characterEffect1066ui_story == nil then
				arg_855_1.var_.characterEffect1066ui_story = var_858_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_858_2 = 0.200000002980232

			if var_858_1 <= arg_855_1.time_ and arg_855_1.time_ < var_858_1 + var_858_2 then
				local var_858_3 = (arg_855_1.time_ - var_858_1) / var_858_2

				if arg_855_1.var_.characterEffect1066ui_story then
					local var_858_4 = Mathf.Lerp(0, 0.5, var_858_3)

					arg_855_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_855_1.var_.characterEffect1066ui_story.fillRatio = var_858_4
				end
			end

			if arg_855_1.time_ >= var_858_1 + var_858_2 and arg_855_1.time_ < var_858_1 + var_858_2 + arg_858_0 and arg_855_1.var_.characterEffect1066ui_story then
				local var_858_5 = 0.5

				arg_855_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_855_1.var_.characterEffect1066ui_story.fillRatio = var_858_5
			end

			local var_858_6 = 0
			local var_858_7 = 0.125

			if var_858_6 < arg_855_1.time_ and arg_855_1.time_ <= var_858_6 + arg_858_0 then
				arg_855_1.talkMaxDuration = 0
				arg_855_1.dialogCg_.alpha = 1

				arg_855_1.dialog_:SetActive(true)
				SetActive(arg_855_1.leftNameGo_, true)

				local var_858_8 = arg_855_1:FormatText(StoryNameCfg[7].name)

				arg_855_1.leftNameTxt_.text = var_858_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_855_1.leftNameTxt_.transform)

				arg_855_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_855_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_855_1:RecordName(arg_855_1.leftNameTxt_.text)
				SetActive(arg_855_1.iconTrs_.gameObject, false)
				arg_855_1.callingController_:SetSelectedState("normal")

				local var_858_9 = arg_855_1:GetWordFromCfg(1106605215)
				local var_858_10 = arg_855_1:FormatText(var_858_9.content)

				arg_855_1.text_.text = var_858_10

				LuaForUtil.ClearLinePrefixSymbol(arg_855_1.text_)

				local var_858_11 = 5
				local var_858_12 = utf8.len(var_858_10)
				local var_858_13 = var_858_11 <= 0 and var_858_7 or var_858_7 * (var_858_12 / var_858_11)

				if var_858_13 > 0 and var_858_7 < var_858_13 then
					arg_855_1.talkMaxDuration = var_858_13

					if var_858_13 + var_858_6 > arg_855_1.duration_ then
						arg_855_1.duration_ = var_858_13 + var_858_6
					end
				end

				arg_855_1.text_.text = var_858_10
				arg_855_1.typewritter.percent = 0

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(false)
				arg_855_1:RecordContent(arg_855_1.text_.text)
			end

			local var_858_14 = math.max(var_858_7, arg_855_1.talkMaxDuration)

			if var_858_6 <= arg_855_1.time_ and arg_855_1.time_ < var_858_6 + var_858_14 then
				arg_855_1.typewritter.percent = (arg_855_1.time_ - var_858_6) / var_858_14

				arg_855_1.typewritter:SetDirty()
			end

			if arg_855_1.time_ >= var_858_6 + var_858_14 and arg_855_1.time_ < var_858_6 + var_858_14 + arg_858_0 then
				arg_855_1.typewritter.percent = 1

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605216 = function(arg_859_0, arg_859_1)
		arg_859_1.time_ = 0
		arg_859_1.frameCnt_ = 0
		arg_859_1.state_ = "playing"
		arg_859_1.curTalkId_ = 1106605216
		arg_859_1.duration_ = 5.433

		SetActive(arg_859_1.tipsGo_, false)

		function arg_859_1.onSingleLineFinish_()
			arg_859_1.onSingleLineUpdate_ = nil
			arg_859_1.onSingleLineFinish_ = nil
			arg_859_1.state_ = "waiting"
			arg_859_1.auto_ = false
		end

		function arg_859_1.playNext_(arg_861_0)
			arg_859_1.onStoryFinished_()
		end

		function arg_859_1.onSingleLineUpdate_(arg_862_0)
			local var_862_0 = arg_859_1.actors_["1066ui_story"].transform
			local var_862_1 = 0

			if var_862_1 < arg_859_1.time_ and arg_859_1.time_ <= var_862_1 + arg_862_0 then
				arg_859_1.var_.moveOldPos1066ui_story = var_862_0.localPosition
			end

			local var_862_2 = 0.001

			if var_862_1 <= arg_859_1.time_ and arg_859_1.time_ < var_862_1 + var_862_2 then
				local var_862_3 = (arg_859_1.time_ - var_862_1) / var_862_2
				local var_862_4 = Vector3.New(0, -0.77, -6.1)

				var_862_0.localPosition = Vector3.Lerp(arg_859_1.var_.moveOldPos1066ui_story, var_862_4, var_862_3)

				local var_862_5 = manager.ui.mainCamera.transform.position - var_862_0.position

				var_862_0.forward = Vector3.New(var_862_5.x, var_862_5.y, var_862_5.z)

				local var_862_6 = var_862_0.localEulerAngles

				var_862_6.z = 0
				var_862_6.x = 0
				var_862_0.localEulerAngles = var_862_6
			end

			if arg_859_1.time_ >= var_862_1 + var_862_2 and arg_859_1.time_ < var_862_1 + var_862_2 + arg_862_0 then
				var_862_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_862_7 = manager.ui.mainCamera.transform.position - var_862_0.position

				var_862_0.forward = Vector3.New(var_862_7.x, var_862_7.y, var_862_7.z)

				local var_862_8 = var_862_0.localEulerAngles

				var_862_8.z = 0
				var_862_8.x = 0
				var_862_0.localEulerAngles = var_862_8
			end

			local var_862_9 = arg_859_1.actors_["1066ui_story"]
			local var_862_10 = 0

			if var_862_10 < arg_859_1.time_ and arg_859_1.time_ <= var_862_10 + arg_862_0 and arg_859_1.var_.characterEffect1066ui_story == nil then
				arg_859_1.var_.characterEffect1066ui_story = var_862_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_862_11 = 0.200000002980232

			if var_862_10 <= arg_859_1.time_ and arg_859_1.time_ < var_862_10 + var_862_11 then
				local var_862_12 = (arg_859_1.time_ - var_862_10) / var_862_11

				if arg_859_1.var_.characterEffect1066ui_story then
					arg_859_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_859_1.time_ >= var_862_10 + var_862_11 and arg_859_1.time_ < var_862_10 + var_862_11 + arg_862_0 and arg_859_1.var_.characterEffect1066ui_story then
				arg_859_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_862_13 = 0

			if var_862_13 < arg_859_1.time_ and arg_859_1.time_ <= var_862_13 + arg_862_0 then
				arg_859_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_862_14 = 0
			local var_862_15 = 0.533333333333333

			if var_862_14 < arg_859_1.time_ and arg_859_1.time_ <= var_862_14 + arg_862_0 then
				local var_862_16 = "stop"
				local var_862_17 = "effect"

				arg_859_1:AudioAction(var_862_16, var_862_17, "se_story_side_1080", "se_story_1080_parkloop", "")
			end

			local var_862_18 = 0
			local var_862_19 = 0.55

			if var_862_18 < arg_859_1.time_ and arg_859_1.time_ <= var_862_18 + arg_862_0 then
				arg_859_1.talkMaxDuration = 0
				arg_859_1.dialogCg_.alpha = 1

				arg_859_1.dialog_:SetActive(true)
				SetActive(arg_859_1.leftNameGo_, true)

				local var_862_20 = arg_859_1:FormatText(StoryNameCfg[32].name)

				arg_859_1.leftNameTxt_.text = var_862_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_859_1.leftNameTxt_.transform)

				arg_859_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_859_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_859_1:RecordName(arg_859_1.leftNameTxt_.text)
				SetActive(arg_859_1.iconTrs_.gameObject, false)
				arg_859_1.callingController_:SetSelectedState("normal")

				local var_862_21 = arg_859_1:GetWordFromCfg(1106605216)
				local var_862_22 = arg_859_1:FormatText(var_862_21.content)

				arg_859_1.text_.text = var_862_22

				LuaForUtil.ClearLinePrefixSymbol(arg_859_1.text_)

				local var_862_23 = 22
				local var_862_24 = utf8.len(var_862_22)
				local var_862_25 = var_862_23 <= 0 and var_862_19 or var_862_19 * (var_862_24 / var_862_23)

				if var_862_25 > 0 and var_862_19 < var_862_25 then
					arg_859_1.talkMaxDuration = var_862_25

					if var_862_25 + var_862_18 > arg_859_1.duration_ then
						arg_859_1.duration_ = var_862_25 + var_862_18
					end
				end

				arg_859_1.text_.text = var_862_22
				arg_859_1.typewritter.percent = 0

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605216", "story_v_side_new_1106605.awb") ~= 0 then
					local var_862_26 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605216", "story_v_side_new_1106605.awb") / 1000

					if var_862_26 + var_862_18 > arg_859_1.duration_ then
						arg_859_1.duration_ = var_862_26 + var_862_18
					end

					if var_862_21.prefab_name ~= "" and arg_859_1.actors_[var_862_21.prefab_name] ~= nil then
						local var_862_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_859_1.actors_[var_862_21.prefab_name].transform, "story_v_side_new_1106605", "1106605216", "story_v_side_new_1106605.awb")

						arg_859_1:RecordAudio("1106605216", var_862_27)
						arg_859_1:RecordAudio("1106605216", var_862_27)
					else
						arg_859_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605216", "story_v_side_new_1106605.awb")
					end

					arg_859_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605216", "story_v_side_new_1106605.awb")
				end

				arg_859_1:RecordContent(arg_859_1.text_.text)
			end

			local var_862_28 = math.max(var_862_19, arg_859_1.talkMaxDuration)

			if var_862_18 <= arg_859_1.time_ and arg_859_1.time_ < var_862_18 + var_862_28 then
				arg_859_1.typewritter.percent = (arg_859_1.time_ - var_862_18) / var_862_28

				arg_859_1.typewritter:SetDirty()
			end

			if arg_859_1.time_ >= var_862_18 + var_862_28 and arg_859_1.time_ < var_862_18 + var_862_28 + arg_862_0 then
				arg_859_1.typewritter.percent = 1

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605199 = function(arg_863_0, arg_863_1)
		arg_863_1.time_ = 0
		arg_863_1.frameCnt_ = 0
		arg_863_1.state_ = "playing"
		arg_863_1.curTalkId_ = 1106605199
		arg_863_1.duration_ = 2.5

		SetActive(arg_863_1.tipsGo_, false)

		function arg_863_1.onSingleLineFinish_()
			arg_863_1.onSingleLineUpdate_ = nil
			arg_863_1.onSingleLineFinish_ = nil
			arg_863_1.state_ = "waiting"
		end

		function arg_863_1.playNext_(arg_865_0)
			if arg_865_0 == 1 then
				arg_863_0:Play1106605200(arg_863_1)
			end
		end

		function arg_863_1.onSingleLineUpdate_(arg_866_0)
			local var_866_0 = 0

			if var_866_0 < arg_863_1.time_ and arg_863_1.time_ <= var_866_0 + arg_866_0 then
				arg_863_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_866_1 = arg_863_1.actors_["1066ui_story"].transform
			local var_866_2 = 0

			if var_866_2 < arg_863_1.time_ and arg_863_1.time_ <= var_866_2 + arg_866_0 then
				arg_863_1.var_.moveOldPos1066ui_story = var_866_1.localPosition
			end

			local var_866_3 = 0.001

			if var_866_2 <= arg_863_1.time_ and arg_863_1.time_ < var_866_2 + var_866_3 then
				local var_866_4 = (arg_863_1.time_ - var_866_2) / var_866_3
				local var_866_5 = Vector3.New(0, -0.77, -6.1)

				var_866_1.localPosition = Vector3.Lerp(arg_863_1.var_.moveOldPos1066ui_story, var_866_5, var_866_4)

				local var_866_6 = manager.ui.mainCamera.transform.position - var_866_1.position

				var_866_1.forward = Vector3.New(var_866_6.x, var_866_6.y, var_866_6.z)

				local var_866_7 = var_866_1.localEulerAngles

				var_866_7.z = 0
				var_866_7.x = 0
				var_866_1.localEulerAngles = var_866_7
			end

			if arg_863_1.time_ >= var_866_2 + var_866_3 and arg_863_1.time_ < var_866_2 + var_866_3 + arg_866_0 then
				var_866_1.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_866_8 = manager.ui.mainCamera.transform.position - var_866_1.position

				var_866_1.forward = Vector3.New(var_866_8.x, var_866_8.y, var_866_8.z)

				local var_866_9 = var_866_1.localEulerAngles

				var_866_9.z = 0
				var_866_9.x = 0
				var_866_1.localEulerAngles = var_866_9
			end

			local var_866_10 = arg_863_1.actors_["1066ui_story"]
			local var_866_11 = 0

			if var_866_11 < arg_863_1.time_ and arg_863_1.time_ <= var_866_11 + arg_866_0 and arg_863_1.var_.characterEffect1066ui_story == nil then
				arg_863_1.var_.characterEffect1066ui_story = var_866_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_866_12 = 0.200000002980232

			if var_866_11 <= arg_863_1.time_ and arg_863_1.time_ < var_866_11 + var_866_12 then
				local var_866_13 = (arg_863_1.time_ - var_866_11) / var_866_12

				if arg_863_1.var_.characterEffect1066ui_story then
					arg_863_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_863_1.time_ >= var_866_11 + var_866_12 and arg_863_1.time_ < var_866_11 + var_866_12 + arg_866_0 and arg_863_1.var_.characterEffect1066ui_story then
				arg_863_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_866_14 = 0

			if var_866_14 < arg_863_1.time_ and arg_863_1.time_ <= var_866_14 + arg_866_0 then
				arg_863_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action456")
			end

			local var_866_15 = 0
			local var_866_16 = 0.25

			if var_866_15 < arg_863_1.time_ and arg_863_1.time_ <= var_866_15 + arg_866_0 then
				arg_863_1.talkMaxDuration = 0
				arg_863_1.dialogCg_.alpha = 1

				arg_863_1.dialog_:SetActive(true)
				SetActive(arg_863_1.leftNameGo_, true)

				local var_866_17 = arg_863_1:FormatText(StoryNameCfg[32].name)

				arg_863_1.leftNameTxt_.text = var_866_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_863_1.leftNameTxt_.transform)

				arg_863_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_863_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_863_1:RecordName(arg_863_1.leftNameTxt_.text)
				SetActive(arg_863_1.iconTrs_.gameObject, false)
				arg_863_1.callingController_:SetSelectedState("normal")

				local var_866_18 = arg_863_1:GetWordFromCfg(1106605199)
				local var_866_19 = arg_863_1:FormatText(var_866_18.content)

				arg_863_1.text_.text = var_866_19

				LuaForUtil.ClearLinePrefixSymbol(arg_863_1.text_)

				local var_866_20 = 10
				local var_866_21 = utf8.len(var_866_19)
				local var_866_22 = var_866_20 <= 0 and var_866_16 or var_866_16 * (var_866_21 / var_866_20)

				if var_866_22 > 0 and var_866_16 < var_866_22 then
					arg_863_1.talkMaxDuration = var_866_22

					if var_866_22 + var_866_15 > arg_863_1.duration_ then
						arg_863_1.duration_ = var_866_22 + var_866_15
					end
				end

				arg_863_1.text_.text = var_866_19
				arg_863_1.typewritter.percent = 0

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605199", "story_v_side_new_1106605.awb") ~= 0 then
					local var_866_23 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605199", "story_v_side_new_1106605.awb") / 1000

					if var_866_23 + var_866_15 > arg_863_1.duration_ then
						arg_863_1.duration_ = var_866_23 + var_866_15
					end

					if var_866_18.prefab_name ~= "" and arg_863_1.actors_[var_866_18.prefab_name] ~= nil then
						local var_866_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_863_1.actors_[var_866_18.prefab_name].transform, "story_v_side_new_1106605", "1106605199", "story_v_side_new_1106605.awb")

						arg_863_1:RecordAudio("1106605199", var_866_24)
						arg_863_1:RecordAudio("1106605199", var_866_24)
					else
						arg_863_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605199", "story_v_side_new_1106605.awb")
					end

					arg_863_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605199", "story_v_side_new_1106605.awb")
				end

				arg_863_1:RecordContent(arg_863_1.text_.text)
			end

			local var_866_25 = math.max(var_866_16, arg_863_1.talkMaxDuration)

			if var_866_15 <= arg_863_1.time_ and arg_863_1.time_ < var_866_15 + var_866_25 then
				arg_863_1.typewritter.percent = (arg_863_1.time_ - var_866_15) / var_866_25

				arg_863_1.typewritter:SetDirty()
			end

			if arg_863_1.time_ >= var_866_15 + var_866_25 and arg_863_1.time_ < var_866_15 + var_866_25 + arg_866_0 then
				arg_863_1.typewritter.percent = 1

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605082 = function(arg_867_0, arg_867_1)
		arg_867_1.time_ = 0
		arg_867_1.frameCnt_ = 0
		arg_867_1.state_ = "playing"
		arg_867_1.curTalkId_ = 1106605082
		arg_867_1.duration_ = 5.766

		SetActive(arg_867_1.tipsGo_, false)

		function arg_867_1.onSingleLineFinish_()
			arg_867_1.onSingleLineUpdate_ = nil
			arg_867_1.onSingleLineFinish_ = nil
			arg_867_1.state_ = "waiting"
		end

		function arg_867_1.playNext_(arg_869_0)
			if arg_869_0 == 1 then
				arg_867_0:Play1106605083(arg_867_1)
			end
		end

		function arg_867_1.onSingleLineUpdate_(arg_870_0)
			local var_870_0 = arg_867_1.actors_["106603ui_story"].transform
			local var_870_1 = 0

			if var_870_1 < arg_867_1.time_ and arg_867_1.time_ <= var_870_1 + arg_870_0 then
				arg_867_1.var_.moveOldPos106603ui_story = var_870_0.localPosition
			end

			local var_870_2 = 0.001

			if var_870_1 <= arg_867_1.time_ and arg_867_1.time_ < var_870_1 + var_870_2 then
				local var_870_3 = (arg_867_1.time_ - var_870_1) / var_870_2
				local var_870_4 = Vector3.New(0, -0.77, -6.25)

				var_870_0.localPosition = Vector3.Lerp(arg_867_1.var_.moveOldPos106603ui_story, var_870_4, var_870_3)

				local var_870_5 = manager.ui.mainCamera.transform.position - var_870_0.position

				var_870_0.forward = Vector3.New(var_870_5.x, var_870_5.y, var_870_5.z)

				local var_870_6 = var_870_0.localEulerAngles

				var_870_6.z = 0
				var_870_6.x = 0
				var_870_0.localEulerAngles = var_870_6
			end

			if arg_867_1.time_ >= var_870_1 + var_870_2 and arg_867_1.time_ < var_870_1 + var_870_2 + arg_870_0 then
				var_870_0.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_870_7 = manager.ui.mainCamera.transform.position - var_870_0.position

				var_870_0.forward = Vector3.New(var_870_7.x, var_870_7.y, var_870_7.z)

				local var_870_8 = var_870_0.localEulerAngles

				var_870_8.z = 0
				var_870_8.x = 0
				var_870_0.localEulerAngles = var_870_8
			end

			local var_870_9 = arg_867_1.actors_["106603ui_story"]
			local var_870_10 = 0

			if var_870_10 < arg_867_1.time_ and arg_867_1.time_ <= var_870_10 + arg_870_0 and arg_867_1.var_.characterEffect106603ui_story == nil then
				arg_867_1.var_.characterEffect106603ui_story = var_870_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_870_11 = 0.200000002980232

			if var_870_10 <= arg_867_1.time_ and arg_867_1.time_ < var_870_10 + var_870_11 then
				local var_870_12 = (arg_867_1.time_ - var_870_10) / var_870_11

				if arg_867_1.var_.characterEffect106603ui_story then
					arg_867_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_867_1.time_ >= var_870_10 + var_870_11 and arg_867_1.time_ < var_870_10 + var_870_11 + arg_870_0 and arg_867_1.var_.characterEffect106603ui_story then
				arg_867_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_870_13 = 0

			if var_870_13 < arg_867_1.time_ and arg_867_1.time_ <= var_870_13 + arg_870_0 then
				arg_867_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action6_1")
			end

			local var_870_14 = 0

			if var_870_14 < arg_867_1.time_ and arg_867_1.time_ <= var_870_14 + arg_870_0 then
				arg_867_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_870_15 = 0

			if var_870_15 < arg_867_1.time_ and arg_867_1.time_ <= var_870_15 + arg_870_0 then
				arg_867_1.allBtn_.enabled = false
			end

			local var_870_16 = 2.36666666666667

			if arg_867_1.time_ >= var_870_15 + var_870_16 and arg_867_1.time_ < var_870_15 + var_870_16 + arg_870_0 then
				arg_867_1.allBtn_.enabled = true
			end

			local var_870_17 = 0
			local var_870_18 = 0.7

			if var_870_17 < arg_867_1.time_ and arg_867_1.time_ <= var_870_17 + arg_870_0 then
				arg_867_1.talkMaxDuration = 0
				arg_867_1.dialogCg_.alpha = 1

				arg_867_1.dialog_:SetActive(true)
				SetActive(arg_867_1.leftNameGo_, true)

				local var_870_19 = arg_867_1:FormatText(StoryNameCfg[32].name)

				arg_867_1.leftNameTxt_.text = var_870_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_867_1.leftNameTxt_.transform)

				arg_867_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_867_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_867_1:RecordName(arg_867_1.leftNameTxt_.text)
				SetActive(arg_867_1.iconTrs_.gameObject, false)
				arg_867_1.callingController_:SetSelectedState("normal")

				local var_870_20 = arg_867_1:GetWordFromCfg(1106605082)
				local var_870_21 = arg_867_1:FormatText(var_870_20.content)

				arg_867_1.text_.text = var_870_21

				LuaForUtil.ClearLinePrefixSymbol(arg_867_1.text_)

				local var_870_22 = 28
				local var_870_23 = utf8.len(var_870_21)
				local var_870_24 = var_870_22 <= 0 and var_870_18 or var_870_18 * (var_870_23 / var_870_22)

				if var_870_24 > 0 and var_870_18 < var_870_24 then
					arg_867_1.talkMaxDuration = var_870_24

					if var_870_24 + var_870_17 > arg_867_1.duration_ then
						arg_867_1.duration_ = var_870_24 + var_870_17
					end
				end

				arg_867_1.text_.text = var_870_21
				arg_867_1.typewritter.percent = 0

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605082", "story_v_side_new_1106605.awb") ~= 0 then
					local var_870_25 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605082", "story_v_side_new_1106605.awb") / 1000

					if var_870_25 + var_870_17 > arg_867_1.duration_ then
						arg_867_1.duration_ = var_870_25 + var_870_17
					end

					if var_870_20.prefab_name ~= "" and arg_867_1.actors_[var_870_20.prefab_name] ~= nil then
						local var_870_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_867_1.actors_[var_870_20.prefab_name].transform, "story_v_side_new_1106605", "1106605082", "story_v_side_new_1106605.awb")

						arg_867_1:RecordAudio("1106605082", var_870_26)
						arg_867_1:RecordAudio("1106605082", var_870_26)
					else
						arg_867_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605082", "story_v_side_new_1106605.awb")
					end

					arg_867_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605082", "story_v_side_new_1106605.awb")
				end

				arg_867_1:RecordContent(arg_867_1.text_.text)
			end

			local var_870_27 = math.max(var_870_18, arg_867_1.talkMaxDuration)

			if var_870_17 <= arg_867_1.time_ and arg_867_1.time_ < var_870_17 + var_870_27 then
				arg_867_1.typewritter.percent = (arg_867_1.time_ - var_870_17) / var_870_27

				arg_867_1.typewritter:SetDirty()
			end

			if arg_867_1.time_ >= var_870_17 + var_870_27 and arg_867_1.time_ < var_870_17 + var_870_27 + arg_870_0 then
				arg_867_1.typewritter.percent = 1

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605074 = function(arg_871_0, arg_871_1)
		arg_871_1.time_ = 0
		arg_871_1.frameCnt_ = 0
		arg_871_1.state_ = "playing"
		arg_871_1.curTalkId_ = 1106605074
		arg_871_1.duration_ = 5

		SetActive(arg_871_1.tipsGo_, false)

		function arg_871_1.onSingleLineFinish_()
			arg_871_1.onSingleLineUpdate_ = nil
			arg_871_1.onSingleLineFinish_ = nil
			arg_871_1.state_ = "waiting"
		end

		function arg_871_1.playNext_(arg_873_0)
			if arg_873_0 == 1 then
				arg_871_0:Play1106605075(arg_871_1)
			end
		end

		function arg_871_1.onSingleLineUpdate_(arg_874_0)
			local var_874_0 = "ST15_blur"

			if arg_871_1.bgs_[var_874_0] == nil then
				local var_874_1 = Object.Instantiate(arg_871_1.paintGo_)

				var_874_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_874_0)
				var_874_1.name = var_874_0
				var_874_1.transform.parent = arg_871_1.stage_.transform
				var_874_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_871_1.bgs_[var_874_0] = var_874_1
			end

			local var_874_2 = 0

			if var_874_2 < arg_871_1.time_ and arg_871_1.time_ <= var_874_2 + arg_874_0 then
				local var_874_3 = manager.ui.mainCamera.transform.localPosition
				local var_874_4 = Vector3.New(0, 0, 10) + Vector3.New(var_874_3.x, var_874_3.y, 0)
				local var_874_5 = arg_871_1.bgs_.ST15_blur

				var_874_5.transform.localPosition = var_874_4
				var_874_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_874_6 = var_874_5:GetComponent("SpriteRenderer")

				if var_874_6 and var_874_6.sprite then
					local var_874_7 = (var_874_5.transform.localPosition - var_874_3).z
					local var_874_8 = manager.ui.mainCameraCom_
					local var_874_9 = 2 * var_874_7 * Mathf.Tan(var_874_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_874_10 = var_874_9 * var_874_8.aspect
					local var_874_11 = var_874_6.sprite.bounds.size.x
					local var_874_12 = var_874_6.sprite.bounds.size.y
					local var_874_13 = var_874_10 / var_874_11
					local var_874_14 = var_874_9 / var_874_12
					local var_874_15 = var_874_14 < var_874_13 and var_874_13 or var_874_14

					var_874_5.transform.localScale = Vector3.New(var_874_15, var_874_15, 0)
				end

				for iter_874_0, iter_874_1 in pairs(arg_871_1.bgs_) do
					if iter_874_0 ~= "ST15_blur" then
						iter_874_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_874_16 = "ST15"

			if arg_871_1.bgs_[var_874_16] == nil then
				local var_874_17 = Object.Instantiate(arg_871_1.blurPaintGo_)
				local var_874_18 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_874_16)

				var_874_17:GetComponent("SpriteRenderer").sprite = var_874_18
				var_874_17.name = var_874_16
				var_874_17.transform.parent = arg_871_1.stage_.transform
				var_874_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_871_1.bgs_[var_874_16] = var_874_17
			end

			local var_874_19 = 0
			local var_874_20 = arg_871_1.bgs_[var_874_16]

			if var_874_19 < arg_871_1.time_ and arg_871_1.time_ <= var_874_19 + arg_874_0 then
				local var_874_21 = manager.ui.mainCamera.transform.localPosition
				local var_874_22 = Vector3.New(0, 0, 10) + Vector3.New(var_874_21.x, var_874_21.y, 0)

				var_874_20.transform.localPosition = var_874_22
				var_874_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_874_23 = var_874_20:GetComponent("SpriteRenderer")

				if var_874_23 and var_874_23.sprite then
					local var_874_24 = (var_874_20.transform.localPosition - var_874_21).z
					local var_874_25 = manager.ui.mainCameraCom_
					local var_874_26 = 2 * var_874_24 * Mathf.Tan(var_874_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_874_27 = var_874_26 * var_874_25.aspect
					local var_874_28 = var_874_23.sprite.bounds.size.x
					local var_874_29 = var_874_23.sprite.bounds.size.y
					local var_874_30 = var_874_27 / var_874_28
					local var_874_31 = var_874_26 / var_874_29
					local var_874_32 = var_874_31 < var_874_30 and var_874_30 or var_874_31

					var_874_20.transform.localScale = Vector3.New(var_874_32, var_874_32, 0)
				end
			end

			local var_874_33 = 2

			if var_874_19 <= arg_871_1.time_ and arg_871_1.time_ < var_874_19 + var_874_33 then
				local var_874_34 = (arg_871_1.time_ - var_874_19) / var_874_33
				local var_874_35 = Color.New(1, 1, 1)

				var_874_35.a = Mathf.Lerp(0, 1, var_874_34)

				var_874_20:GetComponent("SpriteRenderer").material:SetColor("_Color", var_874_35)
			end

			local var_874_36 = 0
			local var_874_37 = 1.725

			if var_874_36 < arg_871_1.time_ and arg_871_1.time_ <= var_874_36 + arg_874_0 then
				arg_871_1.talkMaxDuration = 0
				arg_871_1.dialogCg_.alpha = 1

				arg_871_1.dialog_:SetActive(true)
				SetActive(arg_871_1.leftNameGo_, false)

				arg_871_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_871_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_871_1:RecordName(arg_871_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_871_1.iconTrs_.gameObject, false)
				arg_871_1.callingController_:SetSelectedState("normal")

				local var_874_38 = arg_871_1:GetWordFromCfg(1106605074)
				local var_874_39 = arg_871_1:FormatText(var_874_38.content)

				arg_871_1.text_.text = var_874_39

				LuaForUtil.ClearLinePrefixSymbol(arg_871_1.text_)

				local var_874_40 = 69
				local var_874_41 = utf8.len(var_874_39)
				local var_874_42 = var_874_40 <= 0 and var_874_37 or var_874_37 * (var_874_41 / var_874_40)

				if var_874_42 > 0 and var_874_37 < var_874_42 then
					arg_871_1.talkMaxDuration = var_874_42

					if var_874_42 + var_874_36 > arg_871_1.duration_ then
						arg_871_1.duration_ = var_874_42 + var_874_36
					end
				end

				arg_871_1.text_.text = var_874_39
				arg_871_1.typewritter.percent = 0

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(false)
				arg_871_1:RecordContent(arg_871_1.text_.text)
			end

			local var_874_43 = math.max(var_874_37, arg_871_1.talkMaxDuration)

			if var_874_36 <= arg_871_1.time_ and arg_871_1.time_ < var_874_36 + var_874_43 then
				arg_871_1.typewritter.percent = (arg_871_1.time_ - var_874_36) / var_874_43

				arg_871_1.typewritter:SetDirty()
			end

			if arg_871_1.time_ >= var_874_36 + var_874_43 and arg_871_1.time_ < var_874_36 + var_874_43 + arg_874_0 then
				arg_871_1.typewritter.percent = 1

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(true)
			end
		end
	end,
	Play1106605075 = function(arg_875_0, arg_875_1)
		arg_875_1.time_ = 0
		arg_875_1.frameCnt_ = 0
		arg_875_1.state_ = "playing"
		arg_875_1.curTalkId_ = 1106605075
		arg_875_1.duration_ = 4.833

		SetActive(arg_875_1.tipsGo_, false)

		function arg_875_1.onSingleLineFinish_()
			arg_875_1.onSingleLineUpdate_ = nil
			arg_875_1.onSingleLineFinish_ = nil
			arg_875_1.state_ = "waiting"
		end

		function arg_875_1.playNext_(arg_877_0)
			if arg_877_0 == 1 then
				arg_875_0:Play1106605076(arg_875_1)
			end
		end

		function arg_875_1.onSingleLineUpdate_(arg_878_0)
			local var_878_0 = 0

			if var_878_0 < arg_875_1.time_ and arg_875_1.time_ <= var_878_0 + arg_878_0 then
				local var_878_1 = manager.ui.mainCamera.transform.localPosition
				local var_878_2 = Vector3.New(0, 0, 10) + Vector3.New(var_878_1.x, var_878_1.y, 0)
				local var_878_3 = arg_875_1.bgs_.ST15

				var_878_3.transform.localPosition = var_878_2
				var_878_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_878_4 = var_878_3:GetComponent("SpriteRenderer")

				if var_878_4 and var_878_4.sprite then
					local var_878_5 = (var_878_3.transform.localPosition - var_878_1).z
					local var_878_6 = manager.ui.mainCameraCom_
					local var_878_7 = 2 * var_878_5 * Mathf.Tan(var_878_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_878_8 = var_878_7 * var_878_6.aspect
					local var_878_9 = var_878_4.sprite.bounds.size.x
					local var_878_10 = var_878_4.sprite.bounds.size.y
					local var_878_11 = var_878_8 / var_878_9
					local var_878_12 = var_878_7 / var_878_10
					local var_878_13 = var_878_12 < var_878_11 and var_878_11 or var_878_12

					var_878_3.transform.localScale = Vector3.New(var_878_13, var_878_13, 0)
				end

				for iter_878_0, iter_878_1 in pairs(arg_875_1.bgs_) do
					if iter_878_0 ~= "ST15" then
						iter_878_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_878_14 = arg_875_1.actors_["106603ui_story"].transform
			local var_878_15 = 0

			if var_878_15 < arg_875_1.time_ and arg_875_1.time_ <= var_878_15 + arg_878_0 then
				arg_875_1.var_.moveOldPos106603ui_story = var_878_14.localPosition
			end

			local var_878_16 = 0.001

			if var_878_15 <= arg_875_1.time_ and arg_875_1.time_ < var_878_15 + var_878_16 then
				local var_878_17 = (arg_875_1.time_ - var_878_15) / var_878_16
				local var_878_18 = Vector3.New(0, -0.77, -6.25)

				var_878_14.localPosition = Vector3.Lerp(arg_875_1.var_.moveOldPos106603ui_story, var_878_18, var_878_17)

				local var_878_19 = manager.ui.mainCamera.transform.position - var_878_14.position

				var_878_14.forward = Vector3.New(var_878_19.x, var_878_19.y, var_878_19.z)

				local var_878_20 = var_878_14.localEulerAngles

				var_878_20.z = 0
				var_878_20.x = 0
				var_878_14.localEulerAngles = var_878_20
			end

			if arg_875_1.time_ >= var_878_15 + var_878_16 and arg_875_1.time_ < var_878_15 + var_878_16 + arg_878_0 then
				var_878_14.localPosition = Vector3.New(0, -0.77, -6.25)

				local var_878_21 = manager.ui.mainCamera.transform.position - var_878_14.position

				var_878_14.forward = Vector3.New(var_878_21.x, var_878_21.y, var_878_21.z)

				local var_878_22 = var_878_14.localEulerAngles

				var_878_22.z = 0
				var_878_22.x = 0
				var_878_14.localEulerAngles = var_878_22
			end

			local var_878_23 = arg_875_1.actors_["106603ui_story"]
			local var_878_24 = 0

			if var_878_24 < arg_875_1.time_ and arg_875_1.time_ <= var_878_24 + arg_878_0 and arg_875_1.var_.characterEffect106603ui_story == nil then
				arg_875_1.var_.characterEffect106603ui_story = var_878_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_878_25 = 0.200000002980232

			if var_878_24 <= arg_875_1.time_ and arg_875_1.time_ < var_878_24 + var_878_25 then
				local var_878_26 = (arg_875_1.time_ - var_878_24) / var_878_25

				if arg_875_1.var_.characterEffect106603ui_story then
					arg_875_1.var_.characterEffect106603ui_story.fillFlat = false
				end
			end

			if arg_875_1.time_ >= var_878_24 + var_878_25 and arg_875_1.time_ < var_878_24 + var_878_25 + arg_878_0 and arg_875_1.var_.characterEffect106603ui_story then
				arg_875_1.var_.characterEffect106603ui_story.fillFlat = false
			end

			local var_878_27 = 0

			if var_878_27 < arg_875_1.time_ and arg_875_1.time_ <= var_878_27 + arg_878_0 then
				arg_875_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			local var_878_28 = 0

			if var_878_28 < arg_875_1.time_ and arg_875_1.time_ <= var_878_28 + arg_878_0 then
				arg_875_1:PlayTimeline("106603ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_878_29 = 0
			local var_878_30 = 0.55

			if var_878_29 < arg_875_1.time_ and arg_875_1.time_ <= var_878_29 + arg_878_0 then
				arg_875_1.talkMaxDuration = 0
				arg_875_1.dialogCg_.alpha = 1

				arg_875_1.dialog_:SetActive(true)
				SetActive(arg_875_1.leftNameGo_, true)

				local var_878_31 = arg_875_1:FormatText(StoryNameCfg[32].name)

				arg_875_1.leftNameTxt_.text = var_878_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_875_1.leftNameTxt_.transform)

				arg_875_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_875_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_875_1:RecordName(arg_875_1.leftNameTxt_.text)
				SetActive(arg_875_1.iconTrs_.gameObject, false)
				arg_875_1.callingController_:SetSelectedState("normal")

				local var_878_32 = arg_875_1:GetWordFromCfg(1106605075)
				local var_878_33 = arg_875_1:FormatText(var_878_32.content)

				arg_875_1.text_.text = var_878_33

				LuaForUtil.ClearLinePrefixSymbol(arg_875_1.text_)

				local var_878_34 = 22
				local var_878_35 = utf8.len(var_878_33)
				local var_878_36 = var_878_34 <= 0 and var_878_30 or var_878_30 * (var_878_35 / var_878_34)

				if var_878_36 > 0 and var_878_30 < var_878_36 then
					arg_875_1.talkMaxDuration = var_878_36

					if var_878_36 + var_878_29 > arg_875_1.duration_ then
						arg_875_1.duration_ = var_878_36 + var_878_29
					end
				end

				arg_875_1.text_.text = var_878_33
				arg_875_1.typewritter.percent = 0

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605075", "story_v_side_new_1106605.awb") ~= 0 then
					local var_878_37 = manager.audio:GetVoiceLength("story_v_side_new_1106605", "1106605075", "story_v_side_new_1106605.awb") / 1000

					if var_878_37 + var_878_29 > arg_875_1.duration_ then
						arg_875_1.duration_ = var_878_37 + var_878_29
					end

					if var_878_32.prefab_name ~= "" and arg_875_1.actors_[var_878_32.prefab_name] ~= nil then
						local var_878_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_875_1.actors_[var_878_32.prefab_name].transform, "story_v_side_new_1106605", "1106605075", "story_v_side_new_1106605.awb")

						arg_875_1:RecordAudio("1106605075", var_878_38)
						arg_875_1:RecordAudio("1106605075", var_878_38)
					else
						arg_875_1:AudioAction("play", "voice", "story_v_side_new_1106605", "1106605075", "story_v_side_new_1106605.awb")
					end

					arg_875_1:RecordHistoryTalkVoice("story_v_side_new_1106605", "1106605075", "story_v_side_new_1106605.awb")
				end

				arg_875_1:RecordContent(arg_875_1.text_.text)
			end

			local var_878_39 = math.max(var_878_30, arg_875_1.talkMaxDuration)

			if var_878_29 <= arg_875_1.time_ and arg_875_1.time_ < var_878_29 + var_878_39 then
				arg_875_1.typewritter.percent = (arg_875_1.time_ - var_878_29) / var_878_39

				arg_875_1.typewritter:SetDirty()
			end

			if arg_875_1.time_ >= var_878_29 + var_878_39 and arg_875_1.time_ < var_878_29 + var_878_39 + arg_878_0 then
				arg_875_1.typewritter.percent = 1

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST12",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST01",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST15",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST02",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST17",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST28",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST15_blur"
	},
	voices = {
		"story_v_side_new_1106605.awb"
	}
}
