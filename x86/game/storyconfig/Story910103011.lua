return {
	Play910110001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910110001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910110002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I03"

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
				local var_4_5 = arg_1_1.bgs_.I03

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
					if iter_4_0 ~= "I03" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.85

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_25 = arg_1_1:FormatText(StoryNameCfg[352].name)

				arg_1_1.leftNameTxt_.text = var_4_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(910110001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 34
				local var_4_29 = utf8.len(var_4_27)
				local var_4_30 = var_4_28 <= 0 and var_4_23 or var_4_23 * (var_4_29 / var_4_28)

				if var_4_30 > 0 and var_4_23 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_22 = var_4_22 + 0.3

					if var_4_30 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play910110002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910110002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910110003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.1

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[353].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:GetWordFromCfg(910110002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 44
				local var_10_6 = utf8.len(var_10_4)
				local var_10_7 = var_10_5 <= 0 and var_10_1 or var_10_1 * (var_10_6 / var_10_5)

				if var_10_7 > 0 and var_10_1 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_8 and arg_7_1.time_ < var_10_0 + var_10_8 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play910110003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910110003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910110004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 0.625

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_2 = arg_11_1:FormatText(StoryNameCfg[352].name)

				arg_11_1.leftNameTxt_.text = var_14_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:GetWordFromCfg(910110003)
				local var_14_4 = arg_11_1:FormatText(var_14_3.content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 25
				local var_14_6 = utf8.len(var_14_4)
				local var_14_7 = var_14_5 <= 0 and var_14_1 or var_14_1 * (var_14_6 / var_14_5)

				if var_14_7 > 0 and var_14_1 < var_14_7 then
					arg_11_1.talkMaxDuration = var_14_7

					if var_14_7 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_7 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_4
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_8 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_8 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_8

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_8 and arg_11_1.time_ < var_14_0 + var_14_8 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play910110004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910110004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910110005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.725

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[353].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(910110004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 29
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_8 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_8 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_8

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_8 and arg_15_1.time_ < var_18_0 + var_18_8 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play910110005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910110005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910110006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 1.125

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

				local var_22_2 = arg_19_1:GetWordFromCfg(910110005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_4 = 45
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
	Play910110006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910110006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910110007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1.45

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(910110006)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 58
				local var_26_5 = utf8.len(var_26_3)
				local var_26_6 = var_26_4 <= 0 and var_26_1 or var_26_1 * (var_26_5 / var_26_4)

				if var_26_6 > 0 and var_26_1 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_7 and arg_23_1.time_ < var_26_0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play910110007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910110007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910110008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.325

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[352].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(910110007)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 13
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play910110008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910110008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910110009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.05

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[7].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(910110008)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 2
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_8 and arg_31_1.time_ < var_34_0 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	Play910110009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910110009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910110010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.325

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(910110009)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 13
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play910110010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910110010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910110011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.375

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[352].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(910110010)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 15
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play910110011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910110011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910110012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 1.2

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(910110011)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 48
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play910110012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910110012
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910110013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "ST34"

			if arg_47_1.bgs_[var_50_0] == nil then
				local var_50_1 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_0)
				var_50_1.name = var_50_0
				var_50_1.transform.parent = arg_47_1.stage_.transform
				var_50_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_0] = var_50_1
			end

			local var_50_2 = 2

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				local var_50_3 = manager.ui.mainCamera.transform.localPosition
				local var_50_4 = Vector3.New(0, 0, 10) + Vector3.New(var_50_3.x, var_50_3.y, 0)
				local var_50_5 = arg_47_1.bgs_.ST34

				var_50_5.transform.localPosition = var_50_4
				var_50_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_6 = var_50_5:GetComponent("SpriteRenderer")

				if var_50_6 and var_50_6.sprite then
					local var_50_7 = (var_50_5.transform.localPosition - var_50_3).z
					local var_50_8 = manager.ui.mainCameraCom_
					local var_50_9 = 2 * var_50_7 * Mathf.Tan(var_50_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_10 = var_50_9 * var_50_8.aspect
					local var_50_11 = var_50_6.sprite.bounds.size.x
					local var_50_12 = var_50_6.sprite.bounds.size.y
					local var_50_13 = var_50_10 / var_50_11
					local var_50_14 = var_50_9 / var_50_12
					local var_50_15 = var_50_14 < var_50_13 and var_50_13 or var_50_14

					var_50_5.transform.localScale = Vector3.New(var_50_15, var_50_15, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST34" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_17 = 2

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17
				local var_50_19 = Color.New(0, 0, 0)

				var_50_19.a = Mathf.Lerp(0, 1, var_50_18)
				arg_47_1.mask_.color = var_50_19
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 then
				local var_50_20 = Color.New(0, 0, 0)

				var_50_20.a = 1
				arg_47_1.mask_.color = var_50_20
			end

			local var_50_21 = 2

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_22 = 2

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_22 then
				local var_50_23 = (arg_47_1.time_ - var_50_21) / var_50_22
				local var_50_24 = Color.New(0, 0, 0)

				var_50_24.a = Mathf.Lerp(1, 0, var_50_23)
				arg_47_1.mask_.color = var_50_24
			end

			if arg_47_1.time_ >= var_50_21 + var_50_22 and arg_47_1.time_ < var_50_21 + var_50_22 + arg_50_0 then
				local var_50_25 = Color.New(0, 0, 0)
				local var_50_26 = 0

				arg_47_1.mask_.enabled = false
				var_50_25.a = var_50_26
				arg_47_1.mask_.color = var_50_25
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_27 = 4
			local var_50_28 = 1.375

			if var_50_27 < arg_47_1.time_ and arg_47_1.time_ <= var_50_27 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				local var_50_29 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_29:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_30 = arg_47_1:GetWordFromCfg(910110012)
				local var_50_31 = arg_47_1:FormatText(var_50_30.content)

				arg_47_1.text_.text = var_50_31

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_32 = 55
				local var_50_33 = utf8.len(var_50_31)
				local var_50_34 = var_50_32 <= 0 and var_50_28 or var_50_28 * (var_50_33 / var_50_32)

				if var_50_34 > 0 and var_50_28 < var_50_34 then
					arg_47_1.talkMaxDuration = var_50_34
					var_50_27 = var_50_27 + 0.3

					if var_50_34 + var_50_27 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_34 + var_50_27
					end
				end

				arg_47_1.text_.text = var_50_31
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_35 = var_50_27 + 0.3
			local var_50_36 = math.max(var_50_28, arg_47_1.talkMaxDuration)

			if var_50_35 <= arg_47_1.time_ and arg_47_1.time_ < var_50_35 + var_50_36 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_35) / var_50_36

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_35 + var_50_36 and arg_47_1.time_ < var_50_35 + var_50_36 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end
	end,
	Play910110013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 910110013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play910110014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.675

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(910110013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 27
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end
	end,
	Play910110014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 910110014
		arg_57_1.duration_ = 7

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play910110015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "1066"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_60_0), arg_57_1.canvasGo_.transform)

				var_60_1.transform:SetSiblingIndex(1)

				var_60_1.name = var_60_0
				var_60_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_57_1.actors_[var_60_0] = var_60_1
			end

			local var_60_2 = arg_57_1.actors_["1066"].transform
			local var_60_3 = 2

			if var_60_3 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.var_.moveOldPos1066 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1066", 3)

				local var_60_4 = var_60_2.childCount

				for iter_60_0 = 0, var_60_4 - 1 do
					local var_60_5 = var_60_2:GetChild(iter_60_0)

					if var_60_5.name == "split_1" or not string.find(var_60_5.name, "split") then
						var_60_5.gameObject:SetActive(true)
					else
						var_60_5.gameObject:SetActive(false)
					end
				end
			end

			local var_60_6 = 0.001

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_6 then
				local var_60_7 = (arg_57_1.time_ - var_60_3) / var_60_6
				local var_60_8 = Vector3.New(0, -350, -180)

				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1066, var_60_8, var_60_7)
			end

			if arg_57_1.time_ >= var_60_3 + var_60_6 and arg_57_1.time_ < var_60_3 + var_60_6 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_60_9 = arg_57_1.actors_["1066"]
			local var_60_10 = 2

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and arg_57_1.var_.actorSpriteComps1066 == nil then
				arg_57_1.var_.actorSpriteComps1066 = var_60_9:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_11 = 0.2

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.actorSpriteComps1066 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_60_2 then
							local var_60_13 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_12)

							iter_60_2.color = Color.New(var_60_13, var_60_13, var_60_13)
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and arg_57_1.var_.actorSpriteComps1066 then
				local var_60_14 = 1

				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = Color.New(var_60_14, var_60_14, var_60_14)
					end
				end

				arg_57_1.var_.actorSpriteComps1066 = nil
			end

			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_16 = 2

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_16 then
				local var_60_17 = (arg_57_1.time_ - var_60_15) / var_60_16
				local var_60_18 = Color.New(1, 1, 1)

				var_60_18.a = Mathf.Lerp(1, 0, var_60_17)
				arg_57_1.mask_.color = var_60_18
			end

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 then
				local var_60_19 = Color.New(1, 1, 1)
				local var_60_20 = 0

				arg_57_1.mask_.enabled = false
				var_60_19.a = var_60_20
				arg_57_1.mask_.color = var_60_19
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_21 = 2
			local var_60_22 = 1.35

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				local var_60_23 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_23:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_24 = arg_57_1:FormatText(StoryNameCfg[32].name)

				arg_57_1.leftNameTxt_.text = var_60_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_25 = arg_57_1:GetWordFromCfg(910110014)
				local var_60_26 = arg_57_1:FormatText(var_60_25.content)

				arg_57_1.text_.text = var_60_26

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_27 = 54
				local var_60_28 = utf8.len(var_60_26)
				local var_60_29 = var_60_27 <= 0 and var_60_22 or var_60_22 * (var_60_28 / var_60_27)

				if var_60_29 > 0 and var_60_22 < var_60_29 then
					arg_57_1.talkMaxDuration = var_60_29
					var_60_21 = var_60_21 + 0.3

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_26
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_30 = var_60_21 + 0.3
			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_31 and arg_57_1.time_ < var_60_30 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end
	end,
	Play910110015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910110015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910110016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1066"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and arg_63_1.var_.actorSpriteComps1066 == nil then
				arg_63_1.var_.actorSpriteComps1066 = var_66_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.actorSpriteComps1066 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_66_1 then
							local var_66_4 = Mathf.Lerp(iter_66_1.color.r, 0.5, var_66_3)

							iter_66_1.color = Color.New(var_66_4, var_66_4, var_66_4)
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and arg_63_1.var_.actorSpriteComps1066 then
				local var_66_5 = 0.5

				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = Color.New(var_66_5, var_66_5, var_66_5)
					end
				end

				arg_63_1.var_.actorSpriteComps1066 = nil
			end

			local var_66_6 = 0
			local var_66_7 = 0.65

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[355].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(910110015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 26
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end
	end,
	Play910110016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910110016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910110017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.65

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[355].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(910110016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 26
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
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play910110017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910110017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play910110018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 1.05

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[355].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(910110017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 42
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_8 and arg_71_1.time_ < var_74_0 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play910110018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910110018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play910110019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.275

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(910110018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 11
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
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play910110019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 910110019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play910110020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1066"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and arg_79_1.var_.actorSpriteComps1066 == nil then
				arg_79_1.var_.actorSpriteComps1066 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1066 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_82_1 then
							local var_82_4 = Mathf.Lerp(iter_82_1.color.r, 1, var_82_3)

							iter_82_1.color = Color.New(var_82_4, var_82_4, var_82_4)
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and arg_79_1.var_.actorSpriteComps1066 then
				local var_82_5 = 1

				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = Color.New(var_82_5, var_82_5, var_82_5)
					end
				end

				arg_79_1.var_.actorSpriteComps1066 = nil
			end

			local var_82_6 = 0.375
			local var_82_7 = 0.625

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				local var_82_8 = "play"
				local var_82_9 = "effect"

				arg_79_1:AudioAction(var_82_8, var_82_9, "se_story_16", "se_story_16_door02", "")
			end

			local var_82_10 = manager.ui.mainCamera.transform
			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.var_.shakeOldPos = var_82_10.localPosition
			end

			local var_82_12 = 0.6

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_11) / 0.066
				local var_82_14, var_82_15 = math.modf(var_82_13)

				var_82_10.localPosition = Vector3.New(var_82_15 * 0.13, var_82_15 * 0.13, var_82_15 * 0.13) + arg_79_1.var_.shakeOldPos
			end

			if arg_79_1.time_ >= var_82_11 + var_82_12 and arg_79_1.time_ < var_82_11 + var_82_12 + arg_82_0 then
				var_82_10.localPosition = arg_79_1.var_.shakeOldPos
			end

			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_17 = 0.6

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_18 = 0
			local var_82_19 = 0.375

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_20 = arg_79_1:FormatText(StoryNameCfg[32].name)

				arg_79_1.leftNameTxt_.text = var_82_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_21 = arg_79_1:GetWordFromCfg(910110019)
				local var_82_22 = arg_79_1:FormatText(var_82_21.content)

				arg_79_1.text_.text = var_82_22

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_23 = 15
				local var_82_24 = utf8.len(var_82_22)
				local var_82_25 = var_82_23 <= 0 and var_82_19 or var_82_19 * (var_82_24 / var_82_23)

				if var_82_25 > 0 and var_82_19 < var_82_25 then
					arg_79_1.talkMaxDuration = var_82_25

					if var_82_25 + var_82_18 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_25 + var_82_18
					end
				end

				arg_79_1.text_.text = var_82_22
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_26 = math.max(var_82_19, arg_79_1.talkMaxDuration)

			if var_82_18 <= arg_79_1.time_ and arg_79_1.time_ < var_82_18 + var_82_26 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_18) / var_82_26

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_18 + var_82_26 and arg_79_1.time_ < var_82_18 + var_82_26 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play910110020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 910110020
		arg_83_1.duration_ = 9

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play910110021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "ST17"

			if arg_83_1.bgs_[var_86_0] == nil then
				local var_86_1 = Object.Instantiate(arg_83_1.paintGo_)

				var_86_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_86_0)
				var_86_1.name = var_86_0
				var_86_1.transform.parent = arg_83_1.stage_.transform
				var_86_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.bgs_[var_86_0] = var_86_1
			end

			local var_86_2 = 2

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				local var_86_3 = manager.ui.mainCamera.transform.localPosition
				local var_86_4 = Vector3.New(0, 0, 10) + Vector3.New(var_86_3.x, var_86_3.y, 0)
				local var_86_5 = arg_83_1.bgs_.ST17

				var_86_5.transform.localPosition = var_86_4
				var_86_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_6 = var_86_5:GetComponent("SpriteRenderer")

				if var_86_6 and var_86_6.sprite then
					local var_86_7 = (var_86_5.transform.localPosition - var_86_3).z
					local var_86_8 = manager.ui.mainCameraCom_
					local var_86_9 = 2 * var_86_7 * Mathf.Tan(var_86_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_86_10 = var_86_9 * var_86_8.aspect
					local var_86_11 = var_86_6.sprite.bounds.size.x
					local var_86_12 = var_86_6.sprite.bounds.size.y
					local var_86_13 = var_86_10 / var_86_11
					local var_86_14 = var_86_9 / var_86_12
					local var_86_15 = var_86_14 < var_86_13 and var_86_13 or var_86_14

					var_86_5.transform.localScale = Vector3.New(var_86_15, var_86_15, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "ST17" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_17 = 2

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17
				local var_86_19 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_19.a = Mathf.Lerp(0, 1, var_86_18)
				arg_83_1.mask_.color = var_86_19
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 then
				local var_86_20 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_20.a = 1
				arg_83_1.mask_.color = var_86_20
			end

			local var_86_21 = 2

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_22 = 2

			if var_86_21 <= arg_83_1.time_ and arg_83_1.time_ < var_86_21 + var_86_22 then
				local var_86_23 = (arg_83_1.time_ - var_86_21) / var_86_22
				local var_86_24 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_86_24.a = Mathf.Lerp(1, 0, var_86_23)
				arg_83_1.mask_.color = var_86_24
			end

			if arg_83_1.time_ >= var_86_21 + var_86_22 and arg_83_1.time_ < var_86_21 + var_86_22 + arg_86_0 then
				local var_86_25 = Color.New(0.01886791, 0.01886791, 0.01886791)
				local var_86_26 = 0

				arg_83_1.mask_.enabled = false
				var_86_25.a = var_86_26
				arg_83_1.mask_.color = var_86_25
			end

			local var_86_27 = arg_83_1.actors_["1066"].transform
			local var_86_28 = 0

			if var_86_28 < arg_83_1.time_ and arg_83_1.time_ <= var_86_28 + arg_86_0 then
				arg_83_1.var_.moveOldPos1066 = var_86_27.localPosition
				var_86_27.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1066", 7)

				local var_86_29 = var_86_27.childCount

				for iter_86_2 = 0, var_86_29 - 1 do
					local var_86_30 = var_86_27:GetChild(iter_86_2)

					if var_86_30.name == "split_1" or not string.find(var_86_30.name, "split") then
						var_86_30.gameObject:SetActive(true)
					else
						var_86_30.gameObject:SetActive(false)
					end
				end
			end

			local var_86_31 = 0.001

			if var_86_28 <= arg_83_1.time_ and arg_83_1.time_ < var_86_28 + var_86_31 then
				local var_86_32 = (arg_83_1.time_ - var_86_28) / var_86_31
				local var_86_33 = Vector3.New(0, -2000, -180)

				var_86_27.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1066, var_86_33, var_86_32)
			end

			if arg_83_1.time_ >= var_86_28 + var_86_31 and arg_83_1.time_ < var_86_28 + var_86_31 + arg_86_0 then
				var_86_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_34 = 4
			local var_86_35 = 0.975

			if var_86_34 < arg_83_1.time_ and arg_83_1.time_ <= var_86_34 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				local var_86_36 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_36:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_37 = arg_83_1:GetWordFromCfg(910110020)
				local var_86_38 = arg_83_1:FormatText(var_86_37.content)

				arg_83_1.text_.text = var_86_38

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_39 = 39
				local var_86_40 = utf8.len(var_86_38)
				local var_86_41 = var_86_39 <= 0 and var_86_35 or var_86_35 * (var_86_40 / var_86_39)

				if var_86_41 > 0 and var_86_35 < var_86_41 then
					arg_83_1.talkMaxDuration = var_86_41
					var_86_34 = var_86_34 + 0.3

					if var_86_41 + var_86_34 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_41 + var_86_34
					end
				end

				arg_83_1.text_.text = var_86_38
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_42 = var_86_34 + 0.3
			local var_86_43 = math.max(var_86_35, arg_83_1.talkMaxDuration)

			if var_86_42 <= arg_83_1.time_ and arg_83_1.time_ < var_86_42 + var_86_43 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_42) / var_86_43

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_42 + var_86_43 and arg_83_1.time_ < var_86_42 + var_86_43 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end
	end,
	Play910110021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910110021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910110022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "1070"

			if arg_89_1.actors_[var_92_0] == nil then
				local var_92_1 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_92_0), arg_89_1.canvasGo_.transform)

				var_92_1.transform:SetSiblingIndex(1)

				var_92_1.name = var_92_0
				var_92_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_89_1.actors_[var_92_0] = var_92_1
			end

			local var_92_2 = arg_89_1.actors_["1070"]
			local var_92_3 = 0

			if var_92_3 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 and arg_89_1.var_.actorSpriteComps1070 == nil then
				arg_89_1.var_.actorSpriteComps1070 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_4 = 0.2

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_3) / var_92_4

				if arg_89_1.var_.actorSpriteComps1070 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_92_1 then
							local var_92_6 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_5)

							iter_92_1.color = Color.New(var_92_6, var_92_6, var_92_6)
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_3 + var_92_4 and arg_89_1.time_ < var_92_3 + var_92_4 + arg_92_0 and arg_89_1.var_.actorSpriteComps1070 then
				local var_92_7 = 1

				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = Color.New(var_92_7, var_92_7, var_92_7)
					end
				end

				arg_89_1.var_.actorSpriteComps1070 = nil
			end

			local var_92_8 = arg_89_1.actors_["1070"].transform
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.var_.moveOldPos1070 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1070", 3)

				local var_92_10 = var_92_8.childCount

				for iter_92_4 = 0, var_92_10 - 1 do
					local var_92_11 = var_92_8:GetChild(iter_92_4)

					if var_92_11.name == "split_3" or not string.find(var_92_11.name, "split") then
						var_92_11.gameObject:SetActive(true)
					else
						var_92_11.gameObject:SetActive(false)
					end
				end
			end

			local var_92_12 = 0.001

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_12 then
				local var_92_13 = (arg_89_1.time_ - var_92_9) / var_92_12
				local var_92_14 = Vector3.New(0, -350, -180)

				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1070, var_92_14, var_92_13)
			end

			if arg_89_1.time_ >= var_92_9 + var_92_12 and arg_89_1.time_ < var_92_9 + var_92_12 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(0, -350, -180)
			end

			local var_92_15 = arg_89_1.actors_["1070"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				local var_92_17 = var_92_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_92_17 then
					arg_89_1.var_.alphaOldValue1070 = var_92_17.alpha
					arg_89_1.var_.characterEffect1070 = var_92_17
				end

				arg_89_1.var_.alphaOldValue1070 = 0
			end

			local var_92_18 = 0.5

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_18 then
				local var_92_19 = (arg_89_1.time_ - var_92_16) / var_92_18
				local var_92_20 = Mathf.Lerp(arg_89_1.var_.alphaOldValue1070, 1, var_92_19)

				if arg_89_1.var_.characterEffect1070 then
					arg_89_1.var_.characterEffect1070.alpha = var_92_20
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_18 and arg_89_1.time_ < var_92_16 + var_92_18 + arg_92_0 and arg_89_1.var_.characterEffect1070 then
				arg_89_1.var_.characterEffect1070.alpha = 1
			end

			local var_92_21 = 0
			local var_92_22 = 0.925

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_23 = arg_89_1:FormatText(StoryNameCfg[318].name)

				arg_89_1.leftNameTxt_.text = var_92_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_24 = arg_89_1:GetWordFromCfg(910110021)
				local var_92_25 = arg_89_1:FormatText(var_92_24.content)

				arg_89_1.text_.text = var_92_25

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_26 = 37
				local var_92_27 = utf8.len(var_92_25)
				local var_92_28 = var_92_26 <= 0 and var_92_22 or var_92_22 * (var_92_27 / var_92_26)

				if var_92_28 > 0 and var_92_22 < var_92_28 then
					arg_89_1.talkMaxDuration = var_92_28

					if var_92_28 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_21
					end
				end

				arg_89_1.text_.text = var_92_25
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_29 = math.max(var_92_22, arg_89_1.talkMaxDuration)

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_29 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_21) / var_92_29

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_21 + var_92_29 and arg_89_1.time_ < var_92_21 + var_92_29 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end
	end,
	Play910110022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910110022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910110023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1070"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and arg_93_1.var_.actorSpriteComps1070 == nil then
				arg_93_1.var_.actorSpriteComps1070 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps1070 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_96_1 then
							local var_96_4 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

							iter_96_1.color = Color.New(var_96_4, var_96_4, var_96_4)
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and arg_93_1.var_.actorSpriteComps1070 then
				local var_96_5 = 0.5

				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = Color.New(var_96_5, var_96_5, var_96_5)
					end
				end

				arg_93_1.var_.actorSpriteComps1070 = nil
			end

			local var_96_6 = 0
			local var_96_7 = 0.3

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[358].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(910110022)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 12
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
	Play910110023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910110023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910110024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.8

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[358].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(910110023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 32
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end
	end,
	Play910110024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910110024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910110025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.25

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[357].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(910110024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 10
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end
	end,
	Play910110025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910110025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910110026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1070"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and arg_105_1.var_.actorSpriteComps1070 == nil then
				arg_105_1.var_.actorSpriteComps1070 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps1070 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_108_1 then
							local var_108_4 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

							iter_108_1.color = Color.New(var_108_4, var_108_4, var_108_4)
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and arg_105_1.var_.actorSpriteComps1070 then
				local var_108_5 = 1

				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = Color.New(var_108_5, var_108_5, var_108_5)
					end
				end

				arg_105_1.var_.actorSpriteComps1070 = nil
			end

			local var_108_6 = arg_105_1.actors_["1070"].transform
			local var_108_7 = 0

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.var_.moveOldPos1070 = var_108_6.localPosition
				var_108_6.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1070", 3)

				local var_108_8 = var_108_6.childCount

				for iter_108_4 = 0, var_108_8 - 1 do
					local var_108_9 = var_108_6:GetChild(iter_108_4)

					if var_108_9.name == "split_2" or not string.find(var_108_9.name, "split") then
						var_108_9.gameObject:SetActive(true)
					else
						var_108_9.gameObject:SetActive(false)
					end
				end
			end

			local var_108_10 = 0.001

			if var_108_7 <= arg_105_1.time_ and arg_105_1.time_ < var_108_7 + var_108_10 then
				local var_108_11 = (arg_105_1.time_ - var_108_7) / var_108_10
				local var_108_12 = Vector3.New(0, -350, -180)

				var_108_6.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1070, var_108_12, var_108_11)
			end

			if arg_105_1.time_ >= var_108_7 + var_108_10 and arg_105_1.time_ < var_108_7 + var_108_10 + arg_108_0 then
				var_108_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_108_13 = 0
			local var_108_14 = 0.475

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_15 = arg_105_1:FormatText(StoryNameCfg[318].name)

				arg_105_1.leftNameTxt_.text = var_108_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_16 = arg_105_1:GetWordFromCfg(910110025)
				local var_108_17 = arg_105_1:FormatText(var_108_16.content)

				arg_105_1.text_.text = var_108_17

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_18 = 19
				local var_108_19 = utf8.len(var_108_17)
				local var_108_20 = var_108_18 <= 0 and var_108_14 or var_108_14 * (var_108_19 / var_108_18)

				if var_108_20 > 0 and var_108_14 < var_108_20 then
					arg_105_1.talkMaxDuration = var_108_20

					if var_108_20 + var_108_13 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_13
					end
				end

				arg_105_1.text_.text = var_108_17
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_21 = math.max(var_108_14, arg_105_1.talkMaxDuration)

			if var_108_13 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_21 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_13) / var_108_21

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_13 + var_108_21 and arg_105_1.time_ < var_108_13 + var_108_21 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end
	end,
	Play910110026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910110026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910110027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1070"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and arg_109_1.var_.actorSpriteComps1070 == nil then
				arg_109_1.var_.actorSpriteComps1070 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps1070 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_112_1 then
							local var_112_4 = Mathf.Lerp(iter_112_1.color.r, 0.5, var_112_3)

							iter_112_1.color = Color.New(var_112_4, var_112_4, var_112_4)
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and arg_109_1.var_.actorSpriteComps1070 then
				local var_112_5 = 0.5

				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = Color.New(var_112_5, var_112_5, var_112_5)
					end
				end

				arg_109_1.var_.actorSpriteComps1070 = nil
			end

			local var_112_6 = 0
			local var_112_7 = 0.625

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[359].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(910110026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 25
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end
	end,
	Play910110027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910110027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910110028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.075

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(910110027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 3
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end
	end,
	Play910110028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910110028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910110029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1070"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1070 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1070", 3)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_1" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(0, -350, -180)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1070, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_120_7 = arg_117_1.actors_["1070"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and arg_117_1.var_.actorSpriteComps1070 == nil then
				arg_117_1.var_.actorSpriteComps1070 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 0.2

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps1070 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_120_2 then
							local var_120_11 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

							iter_120_2.color = Color.New(var_120_11, var_120_11, var_120_11)
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and arg_117_1.var_.actorSpriteComps1070 then
				local var_120_12 = 1

				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = Color.New(var_120_12, var_120_12, var_120_12)
					end
				end

				arg_117_1.var_.actorSpriteComps1070 = nil
			end

			local var_120_13 = 0
			local var_120_14 = 0.425

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_15 = arg_117_1:FormatText(StoryNameCfg[318].name)

				arg_117_1.leftNameTxt_.text = var_120_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_16 = arg_117_1:GetWordFromCfg(910110028)
				local var_120_17 = arg_117_1:FormatText(var_120_16.content)

				arg_117_1.text_.text = var_120_17

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_18 = 17
				local var_120_19 = utf8.len(var_120_17)
				local var_120_20 = var_120_18 <= 0 and var_120_14 or var_120_14 * (var_120_19 / var_120_18)

				if var_120_20 > 0 and var_120_14 < var_120_20 then
					arg_117_1.talkMaxDuration = var_120_20

					if var_120_20 + var_120_13 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_13
					end
				end

				arg_117_1.text_.text = var_120_17
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = math.max(var_120_14, arg_117_1.talkMaxDuration)

			if var_120_13 <= arg_117_1.time_ and arg_117_1.time_ < var_120_13 + var_120_21 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_13) / var_120_21

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_13 + var_120_21 and arg_117_1.time_ < var_120_13 + var_120_21 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end
	end,
	Play910110029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910110029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910110030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1070"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and arg_121_1.var_.actorSpriteComps1070 == nil then
				arg_121_1.var_.actorSpriteComps1070 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps1070 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_124_1 then
							local var_124_4 = Mathf.Lerp(iter_124_1.color.r, 0.5, var_124_3)

							iter_124_1.color = Color.New(var_124_4, var_124_4, var_124_4)
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and arg_121_1.var_.actorSpriteComps1070 then
				local var_124_5 = 0.5

				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = Color.New(var_124_5, var_124_5, var_124_5)
					end
				end

				arg_121_1.var_.actorSpriteComps1070 = nil
			end

			local var_124_6 = 0
			local var_124_7 = 0.075

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[355].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(910110029)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 3
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end
	end,
	Play910110030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910110030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910110031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.525

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[355].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(910110030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 21
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end
	end,
	Play910110031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910110031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910110032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1070"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and arg_129_1.var_.actorSpriteComps1070 == nil then
				arg_129_1.var_.actorSpriteComps1070 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps1070 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_132_1 then
							local var_132_4 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

							iter_132_1.color = Color.New(var_132_4, var_132_4, var_132_4)
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and arg_129_1.var_.actorSpriteComps1070 then
				local var_132_5 = 1

				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = Color.New(var_132_5, var_132_5, var_132_5)
					end
				end

				arg_129_1.var_.actorSpriteComps1070 = nil
			end

			local var_132_6 = arg_129_1.actors_["1070"].transform
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.var_.moveOldPos1070 = var_132_6.localPosition
				var_132_6.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("1070", 3)

				local var_132_8 = var_132_6.childCount

				for iter_132_4 = 0, var_132_8 - 1 do
					local var_132_9 = var_132_6:GetChild(iter_132_4)

					if var_132_9.name == "split_2" or not string.find(var_132_9.name, "split") then
						var_132_9.gameObject:SetActive(true)
					else
						var_132_9.gameObject:SetActive(false)
					end
				end
			end

			local var_132_10 = 0.001

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_10 then
				local var_132_11 = (arg_129_1.time_ - var_132_7) / var_132_10
				local var_132_12 = Vector3.New(0, -350, -180)

				var_132_6.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1070, var_132_12, var_132_11)
			end

			if arg_129_1.time_ >= var_132_7 + var_132_10 and arg_129_1.time_ < var_132_7 + var_132_10 + arg_132_0 then
				var_132_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_132_13 = 0
			local var_132_14 = 0.45

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_15 = arg_129_1:FormatText(StoryNameCfg[318].name)

				arg_129_1.leftNameTxt_.text = var_132_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_16 = arg_129_1:GetWordFromCfg(910110031)
				local var_132_17 = arg_129_1:FormatText(var_132_16.content)

				arg_129_1.text_.text = var_132_17

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_18 = 18
				local var_132_19 = utf8.len(var_132_17)
				local var_132_20 = var_132_18 <= 0 and var_132_14 or var_132_14 * (var_132_19 / var_132_18)

				if var_132_20 > 0 and var_132_14 < var_132_20 then
					arg_129_1.talkMaxDuration = var_132_20

					if var_132_20 + var_132_13 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_20 + var_132_13
					end
				end

				arg_129_1.text_.text = var_132_17
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_14, arg_129_1.talkMaxDuration)

			if var_132_13 <= arg_129_1.time_ and arg_129_1.time_ < var_132_13 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_13) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_13 + var_132_21 and arg_129_1.time_ < var_132_13 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end
	end,
	Play910110032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910110032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910110033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1070"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and arg_133_1.var_.actorSpriteComps1070 == nil then
				arg_133_1.var_.actorSpriteComps1070 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps1070 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_136_1 then
							local var_136_4 = Mathf.Lerp(iter_136_1.color.r, 0.5, var_136_3)

							iter_136_1.color = Color.New(var_136_4, var_136_4, var_136_4)
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and arg_133_1.var_.actorSpriteComps1070 then
				local var_136_5 = 0.5

				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = Color.New(var_136_5, var_136_5, var_136_5)
					end
				end

				arg_133_1.var_.actorSpriteComps1070 = nil
			end

			local var_136_6 = 0
			local var_136_7 = 0.6

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[355].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(910110032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 24
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end
	end,
	Play910110033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910110033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910110034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1070"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1070 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1070", 7)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_2" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(0, -2000, -180)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1070, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_140_7 = 0
			local var_140_8 = 0.725

			if var_140_7 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(910110033)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 29
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_8 or var_140_8 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_8 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_7 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_7
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_8, arg_137_1.talkMaxDuration)

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_7) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_7 + var_140_14 and arg_137_1.time_ < var_140_7 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end
	end,
	Play910110034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910110034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910110035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				local var_144_2 = "play"
				local var_144_3 = "effect"

				arg_141_1:AudioAction(var_144_2, var_144_3, "se_story_9", "se_story_9_hit02", "")
			end

			local var_144_4 = manager.ui.mainCamera.transform
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_4.localPosition
			end

			local var_144_6 = 0.6

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / 0.066
				local var_144_8, var_144_9 = math.modf(var_144_7)

				var_144_4.localPosition = Vector3.New(var_144_9 * 0.13, var_144_9 * 0.13, var_144_9 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 then
				var_144_4.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_11 = 0.6

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_12 = 0
			local var_144_13 = 1.325

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_14 = arg_141_1:GetWordFromCfg(910110034)
				local var_144_15 = arg_141_1:FormatText(var_144_14.content)

				arg_141_1.text_.text = var_144_15

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 53
				local var_144_17 = utf8.len(var_144_15)
				local var_144_18 = var_144_16 <= 0 and var_144_13 or var_144_13 * (var_144_17 / var_144_16)

				if var_144_18 > 0 and var_144_13 < var_144_18 then
					arg_141_1.talkMaxDuration = var_144_18

					if var_144_18 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_15
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_19 and arg_141_1.time_ < var_144_12 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end
	end,
	Play910110035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910110035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910110036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1070"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1070 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1070", 3)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_9" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(0, -350, -180)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1070, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_148_7 = arg_145_1.actors_["1070"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and arg_145_1.var_.actorSpriteComps1070 == nil then
				arg_145_1.var_.actorSpriteComps1070 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.0166666666666667

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps1070 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_148_2 then
							local var_148_11 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

							iter_148_2.color = Color.New(var_148_11, var_148_11, var_148_11)
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and arg_145_1.var_.actorSpriteComps1070 then
				local var_148_12 = 1

				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = Color.New(var_148_12, var_148_12, var_148_12)
					end
				end

				arg_145_1.var_.actorSpriteComps1070 = nil
			end

			local var_148_13 = arg_145_1.actors_["1070"]
			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				local var_148_15 = var_148_13:GetComponentInChildren(typeof(CanvasGroup))

				if var_148_15 then
					arg_145_1.var_.alphaOldValue1070 = var_148_15.alpha
					arg_145_1.var_.characterEffect1070 = var_148_15
				end

				arg_145_1.var_.alphaOldValue1070 = 0
			end

			local var_148_16 = 0.5

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_16 then
				local var_148_17 = (arg_145_1.time_ - var_148_14) / var_148_16
				local var_148_18 = Mathf.Lerp(arg_145_1.var_.alphaOldValue1070, 1, var_148_17)

				if arg_145_1.var_.characterEffect1070 then
					arg_145_1.var_.characterEffect1070.alpha = var_148_18
				end
			end

			if arg_145_1.time_ >= var_148_14 + var_148_16 and arg_145_1.time_ < var_148_14 + var_148_16 + arg_148_0 and arg_145_1.var_.characterEffect1070 then
				arg_145_1.var_.characterEffect1070.alpha = 1
			end

			local var_148_19 = 0
			local var_148_20 = 0.425

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_21 = arg_145_1:FormatText(StoryNameCfg[318].name)

				arg_145_1.leftNameTxt_.text = var_148_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_22 = arg_145_1:GetWordFromCfg(910110035)
				local var_148_23 = arg_145_1:FormatText(var_148_22.content)

				arg_145_1.text_.text = var_148_23

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_24 = 17
				local var_148_25 = utf8.len(var_148_23)
				local var_148_26 = var_148_24 <= 0 and var_148_20 or var_148_20 * (var_148_25 / var_148_24)

				if var_148_26 > 0 and var_148_20 < var_148_26 then
					arg_145_1.talkMaxDuration = var_148_26

					if var_148_26 + var_148_19 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_26 + var_148_19
					end
				end

				arg_145_1.text_.text = var_148_23
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_27 = math.max(var_148_20, arg_145_1.talkMaxDuration)

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_27 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_19) / var_148_27

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_19 + var_148_27 and arg_145_1.time_ < var_148_19 + var_148_27 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end
	end,
	Play910110036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910110036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910110037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1070"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and arg_149_1.var_.actorSpriteComps1070 == nil then
				arg_149_1.var_.actorSpriteComps1070 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1070 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_152_1 then
							local var_152_4 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

							iter_152_1.color = Color.New(var_152_4, var_152_4, var_152_4)
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and arg_149_1.var_.actorSpriteComps1070 then
				local var_152_5 = 0.5

				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = Color.New(var_152_5, var_152_5, var_152_5)
					end
				end

				arg_149_1.var_.actorSpriteComps1070 = nil
			end

			local var_152_6 = 0
			local var_152_7 = 0.175

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:GetWordFromCfg(910110036)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 7
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end
	end,
	Play910110037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 910110037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play910110038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1070"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and arg_153_1.var_.actorSpriteComps1070 == nil then
				arg_153_1.var_.actorSpriteComps1070 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1070 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_156_1 then
							local var_156_4 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

							iter_156_1.color = Color.New(var_156_4, var_156_4, var_156_4)
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and arg_153_1.var_.actorSpriteComps1070 then
				local var_156_5 = 1

				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = Color.New(var_156_5, var_156_5, var_156_5)
					end
				end

				arg_153_1.var_.actorSpriteComps1070 = nil
			end

			local var_156_6 = 0
			local var_156_7 = 0.3

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[318].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_9 = arg_153_1:GetWordFromCfg(910110037)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 12
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end
	end,
	Play910110038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 910110038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play910110039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1070"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1070 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1070", 3)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "split_1" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(0, -350, -180)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1070, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_160_7 = arg_157_1.actors_["1070"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and arg_157_1.var_.actorSpriteComps1070 == nil then
				arg_157_1.var_.actorSpriteComps1070 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 0.0166666666666667

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps1070 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_160_2 then
							local var_160_11 = Mathf.Lerp(iter_160_2.color.r, 1, var_160_10)

							iter_160_2.color = Color.New(var_160_11, var_160_11, var_160_11)
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and arg_157_1.var_.actorSpriteComps1070 then
				local var_160_12 = 1

				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = Color.New(var_160_12, var_160_12, var_160_12)
					end
				end

				arg_157_1.var_.actorSpriteComps1070 = nil
			end

			local var_160_13 = 0
			local var_160_14 = 0.5

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_15 = arg_157_1:FormatText(StoryNameCfg[318].name)

				arg_157_1.leftNameTxt_.text = var_160_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_16 = arg_157_1:GetWordFromCfg(910110038)
				local var_160_17 = arg_157_1:FormatText(var_160_16.content)

				arg_157_1.text_.text = var_160_17

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_18 = 20
				local var_160_19 = utf8.len(var_160_17)
				local var_160_20 = var_160_18 <= 0 and var_160_14 or var_160_14 * (var_160_19 / var_160_18)

				if var_160_20 > 0 and var_160_14 < var_160_20 then
					arg_157_1.talkMaxDuration = var_160_20

					if var_160_20 + var_160_13 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_13
					end
				end

				arg_157_1.text_.text = var_160_17
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_21 = math.max(var_160_14, arg_157_1.talkMaxDuration)

			if var_160_13 <= arg_157_1.time_ and arg_157_1.time_ < var_160_13 + var_160_21 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_13) / var_160_21

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_13 + var_160_21 and arg_157_1.time_ < var_160_13 + var_160_21 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end
	end,
	Play910110039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910110039
		arg_161_1.duration_ = 0.199999999999

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"

			SetActive(arg_161_1.choicesGo_, true)

			for iter_162_0, iter_162_1 in ipairs(arg_161_1.choices_) do
				local var_162_0 = iter_162_0 <= 2

				SetActive(iter_162_1.go, var_162_0)
			end

			arg_161_1.choices_[1].txt.text = arg_161_1:FormatText(StoryChoiceCfg[292].name)
			arg_161_1.choices_[2].txt.text = arg_161_1:FormatText(StoryChoiceCfg[293].name)
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910110040(arg_161_1)
			end

			if arg_163_0 == 2 then
				arg_161_0:Play910110052(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1070"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and arg_161_1.var_.actorSpriteComps1070 == nil then
				arg_161_1.var_.actorSpriteComps1070 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1070 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_164_1 then
							local var_164_4 = Mathf.Lerp(iter_164_1.color.r, 0.5, var_164_3)

							iter_164_1.color = Color.New(var_164_4, var_164_4, var_164_4)
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and arg_161_1.var_.actorSpriteComps1070 then
				local var_164_5 = 0.5

				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = Color.New(var_164_5, var_164_5, var_164_5)
					end
				end

				arg_161_1.var_.actorSpriteComps1070 = nil
			end

			local var_164_6 = arg_161_1.actors_["1070"].transform
			local var_164_7 = 0

			if var_164_7 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_6.localPosition
				var_164_6.localScale = Vector3.New(1, 1, 1)

				local var_164_8 = var_164_6.childCount

				for iter_164_4 = 0, var_164_8 - 1 do
					local var_164_9 = var_164_6:GetChild(iter_164_4)

					if var_164_9.name == "split_8" or not string.find(var_164_9.name, "split") then
						var_164_9.gameObject:SetActive(true)
					else
						var_164_9.gameObject:SetActive(false)
					end
				end
			end

			local var_164_10 = 0.001

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_10 then
				local var_164_11 = (arg_161_1.time_ - var_164_7) / var_164_10
				local var_164_12 = Vector3.New(10000, -350, -180)

				var_164_6.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, var_164_12, var_164_11)
			end

			if arg_161_1.time_ >= var_164_7 + var_164_10 and arg_161_1.time_ < var_164_7 + var_164_10 + arg_164_0 then
				var_164_6.localPosition = Vector3.New(10000, -350, -180)
			end

			local var_164_13 = arg_161_1.actors_["1070"].transform
			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_13.localPosition
				var_164_13.localScale = Vector3.New(1, 1, 1)

				local var_164_15 = var_164_13.childCount

				for iter_164_5 = 0, var_164_15 - 1 do
					local var_164_16 = var_164_13:GetChild(iter_164_5)

					if var_164_16.name == "split_6" or not string.find(var_164_16.name, "split") then
						var_164_16.gameObject:SetActive(true)
					else
						var_164_16.gameObject:SetActive(false)
					end
				end
			end

			local var_164_17 = 0.001

			if var_164_14 <= arg_161_1.time_ and arg_161_1.time_ < var_164_14 + var_164_17 then
				local var_164_18 = (arg_161_1.time_ - var_164_14) / var_164_17
				local var_164_19 = Vector3.New(10000, -350, -180)

				var_164_13.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, var_164_19, var_164_18)
			end

			if arg_161_1.time_ >= var_164_14 + var_164_17 and arg_161_1.time_ < var_164_14 + var_164_17 + arg_164_0 then
				var_164_13.localPosition = Vector3.New(10000, -350, -180)
			end

			local var_164_20 = arg_161_1.actors_["1070"].transform
			local var_164_21 = 0

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070 = var_164_20.localPosition
				var_164_20.localScale = Vector3.New(1, 1, 1)

				local var_164_22 = var_164_20.childCount

				for iter_164_6 = 0, var_164_22 - 1 do
					local var_164_23 = var_164_20:GetChild(iter_164_6)

					if var_164_23.name == "split_7" or not string.find(var_164_23.name, "split") then
						var_164_23.gameObject:SetActive(true)
					else
						var_164_23.gameObject:SetActive(false)
					end
				end
			end

			local var_164_24 = 0.001

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_24 then
				local var_164_25 = (arg_161_1.time_ - var_164_21) / var_164_24
				local var_164_26 = Vector3.New(10000, -350, -180)

				var_164_20.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070, var_164_26, var_164_25)
			end

			if arg_161_1.time_ >= var_164_21 + var_164_24 and arg_161_1.time_ < var_164_21 + var_164_24 + arg_164_0 then
				var_164_20.localPosition = Vector3.New(10000, -350, -180)
			end
		end
	end,
	Play910110040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910110040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910110041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1070"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1070 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1070", 3)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "split_3" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(0, -350, -180)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1070, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_168_7 = arg_165_1.actors_["1070"]
			local var_168_8 = 0

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 and arg_165_1.var_.actorSpriteComps1070 == nil then
				arg_165_1.var_.actorSpriteComps1070 = var_168_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_9 = 0.0166666666666667

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 then
				local var_168_10 = (arg_165_1.time_ - var_168_8) / var_168_9

				if arg_165_1.var_.actorSpriteComps1070 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_168_2 then
							local var_168_11 = Mathf.Lerp(iter_168_2.color.r, 1, var_168_10)

							iter_168_2.color = Color.New(var_168_11, var_168_11, var_168_11)
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 and arg_165_1.var_.actorSpriteComps1070 then
				local var_168_12 = 1

				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = Color.New(var_168_12, var_168_12, var_168_12)
					end
				end

				arg_165_1.var_.actorSpriteComps1070 = nil
			end

			local var_168_13 = 0
			local var_168_14 = 1.1

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_15 = arg_165_1:FormatText(StoryNameCfg[318].name)

				arg_165_1.leftNameTxt_.text = var_168_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_16 = arg_165_1:GetWordFromCfg(910110040)
				local var_168_17 = arg_165_1:FormatText(var_168_16.content)

				arg_165_1.text_.text = var_168_17

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_18 = 44
				local var_168_19 = utf8.len(var_168_17)
				local var_168_20 = var_168_18 <= 0 and var_168_14 or var_168_14 * (var_168_19 / var_168_18)

				if var_168_20 > 0 and var_168_14 < var_168_20 then
					arg_165_1.talkMaxDuration = var_168_20

					if var_168_20 + var_168_13 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_13
					end
				end

				arg_165_1.text_.text = var_168_17
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_21 = math.max(var_168_14, arg_165_1.talkMaxDuration)

			if var_168_13 <= arg_165_1.time_ and arg_165_1.time_ < var_168_13 + var_168_21 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_13) / var_168_21

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_13 + var_168_21 and arg_165_1.time_ < var_168_13 + var_168_21 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end
	end,
	Play910110041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910110041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910110042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1070"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1070", 3)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "split_8" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(0, -350, -180)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_172_7 = arg_169_1.actors_["1070"]
			local var_172_8 = 0

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 and arg_169_1.var_.actorSpriteComps1070 == nil then
				arg_169_1.var_.actorSpriteComps1070 = var_172_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 0.0166666666666667

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_9 then
				local var_172_10 = (arg_169_1.time_ - var_172_8) / var_172_9

				if arg_169_1.var_.actorSpriteComps1070 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_172_2 then
							local var_172_11 = Mathf.Lerp(iter_172_2.color.r, 1, var_172_10)

							iter_172_2.color = Color.New(var_172_11, var_172_11, var_172_11)
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_8 + var_172_9 and arg_169_1.time_ < var_172_8 + var_172_9 + arg_172_0 and arg_169_1.var_.actorSpriteComps1070 then
				local var_172_12 = 1

				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = Color.New(var_172_12, var_172_12, var_172_12)
					end
				end

				arg_169_1.var_.actorSpriteComps1070 = nil
			end

			local var_172_13 = 0
			local var_172_14 = 1.125

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_15 = arg_169_1:FormatText(StoryNameCfg[318].name)

				arg_169_1.leftNameTxt_.text = var_172_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_16 = arg_169_1:GetWordFromCfg(910110041)
				local var_172_17 = arg_169_1:FormatText(var_172_16.content)

				arg_169_1.text_.text = var_172_17

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_18 = 45
				local var_172_19 = utf8.len(var_172_17)
				local var_172_20 = var_172_18 <= 0 and var_172_14 or var_172_14 * (var_172_19 / var_172_18)

				if var_172_20 > 0 and var_172_14 < var_172_20 then
					arg_169_1.talkMaxDuration = var_172_20

					if var_172_20 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_20 + var_172_13
					end
				end

				arg_169_1.text_.text = var_172_17
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_21 = math.max(var_172_14, arg_169_1.talkMaxDuration)

			if var_172_13 <= arg_169_1.time_ and arg_169_1.time_ < var_172_13 + var_172_21 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_13) / var_172_21

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_13 + var_172_21 and arg_169_1.time_ < var_172_13 + var_172_21 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end
	end,
	Play910110042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910110042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910110043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1070"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and arg_173_1.var_.actorSpriteComps1070 == nil then
				arg_173_1.var_.actorSpriteComps1070 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1070 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_176_1 then
							local var_176_4 = Mathf.Lerp(iter_176_1.color.r, 0.5, var_176_3)

							iter_176_1.color = Color.New(var_176_4, var_176_4, var_176_4)
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and arg_173_1.var_.actorSpriteComps1070 then
				local var_176_5 = 0.5

				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = Color.New(var_176_5, var_176_5, var_176_5)
					end
				end

				arg_173_1.var_.actorSpriteComps1070 = nil
			end

			local var_176_6 = 0
			local var_176_7 = 0.65

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_9 = arg_173_1:GetWordFromCfg(910110042)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 26
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end
	end,
	Play910110043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910110043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910110044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1070"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1070 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1070", 3)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_7" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(0, -350, -180)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1070, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_180_7 = 0
			local var_180_8 = 0.05

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_9 = arg_177_1:FormatText(StoryNameCfg[318].name)

				arg_177_1.leftNameTxt_.text = var_180_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(910110043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 2
				local var_180_13 = utf8.len(var_180_11)
				local var_180_14 = var_180_12 <= 0 and var_180_8 or var_180_8 * (var_180_13 / var_180_12)

				if var_180_14 > 0 and var_180_8 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_15 and arg_177_1.time_ < var_180_7 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end
	end,
	Play910110044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910110044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910110045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.075

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[318].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(910110044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 3
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end
	end,
	Play910110045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910110045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910110046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.35

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[318].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(910110045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 54
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end
	end,
	Play910110046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910110046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910110047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1070"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and arg_189_1.var_.actorSpriteComps1070 == nil then
				arg_189_1.var_.actorSpriteComps1070 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps1070 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_192_1 then
							local var_192_4 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_3)

							iter_192_1.color = Color.New(var_192_4, var_192_4, var_192_4)
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and arg_189_1.var_.actorSpriteComps1070 then
				local var_192_5 = 0.5

				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = Color.New(var_192_5, var_192_5, var_192_5)
					end
				end

				arg_189_1.var_.actorSpriteComps1070 = nil
			end

			local var_192_6 = 0
			local var_192_7 = 1.225

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:GetWordFromCfg(910110046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 49
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end
	end,
	Play910110047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910110047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910110048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.95

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(910110047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 38
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end
	end,
	Play910110048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910110048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910110049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1070"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1070 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1070", 3)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_6" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(0, -350, -180)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1070, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_200_7 = arg_197_1.actors_["1070"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and arg_197_1.var_.actorSpriteComps1070 == nil then
				arg_197_1.var_.actorSpriteComps1070 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.0166666666666667

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps1070 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_200_2 then
							local var_200_11 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

							iter_200_2.color = Color.New(var_200_11, var_200_11, var_200_11)
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and arg_197_1.var_.actorSpriteComps1070 then
				local var_200_12 = 1

				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = Color.New(var_200_12, var_200_12, var_200_12)
					end
				end

				arg_197_1.var_.actorSpriteComps1070 = nil
			end

			local var_200_13 = 0
			local var_200_14 = 1.05

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_15 = arg_197_1:FormatText(StoryNameCfg[318].name)

				arg_197_1.leftNameTxt_.text = var_200_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_16 = arg_197_1:GetWordFromCfg(910110048)
				local var_200_17 = arg_197_1:FormatText(var_200_16.content)

				arg_197_1.text_.text = var_200_17

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_18 = 42
				local var_200_19 = utf8.len(var_200_17)
				local var_200_20 = var_200_18 <= 0 and var_200_14 or var_200_14 * (var_200_19 / var_200_18)

				if var_200_20 > 0 and var_200_14 < var_200_20 then
					arg_197_1.talkMaxDuration = var_200_20

					if var_200_20 + var_200_13 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_13
					end
				end

				arg_197_1.text_.text = var_200_17
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = math.max(var_200_14, arg_197_1.talkMaxDuration)

			if var_200_13 <= arg_197_1.time_ and arg_197_1.time_ < var_200_13 + var_200_21 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_13) / var_200_21

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_13 + var_200_21 and arg_197_1.time_ < var_200_13 + var_200_21 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end
	end,
	Play910110049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910110049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910110050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1070"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and arg_201_1.var_.actorSpriteComps1070 == nil then
				arg_201_1.var_.actorSpriteComps1070 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1070 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_204_1 then
							local var_204_4 = Mathf.Lerp(iter_204_1.color.r, 0.5, var_204_3)

							iter_204_1.color = Color.New(var_204_4, var_204_4, var_204_4)
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and arg_201_1.var_.actorSpriteComps1070 then
				local var_204_5 = 0.5

				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = Color.New(var_204_5, var_204_5, var_204_5)
					end
				end

				arg_201_1.var_.actorSpriteComps1070 = nil
			end

			local var_204_6 = 0
			local var_204_7 = 0.55

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_9 = arg_201_1:GetWordFromCfg(910110049)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 22
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end
	end,
	Play910110050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910110050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910110051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1070"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1070 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1070", 3)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_2" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(0, -350, -180)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1070, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_208_7 = arg_205_1.actors_["1070"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and arg_205_1.var_.actorSpriteComps1070 == nil then
				arg_205_1.var_.actorSpriteComps1070 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.0166666666666667

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1070 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_208_2 then
							local var_208_11 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

							iter_208_2.color = Color.New(var_208_11, var_208_11, var_208_11)
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and arg_205_1.var_.actorSpriteComps1070 then
				local var_208_12 = 1

				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = Color.New(var_208_12, var_208_12, var_208_12)
					end
				end

				arg_205_1.var_.actorSpriteComps1070 = nil
			end

			local var_208_13 = 0
			local var_208_14 = 0.325

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_15 = arg_205_1:FormatText(StoryNameCfg[318].name)

				arg_205_1.leftNameTxt_.text = var_208_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_16 = arg_205_1:GetWordFromCfg(910110050)
				local var_208_17 = arg_205_1:FormatText(var_208_16.content)

				arg_205_1.text_.text = var_208_17

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_18 = 13
				local var_208_19 = utf8.len(var_208_17)
				local var_208_20 = var_208_18 <= 0 and var_208_14 or var_208_14 * (var_208_19 / var_208_18)

				if var_208_20 > 0 and var_208_14 < var_208_20 then
					arg_205_1.talkMaxDuration = var_208_20

					if var_208_20 + var_208_13 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_20 + var_208_13
					end
				end

				arg_205_1.text_.text = var_208_17
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_21 = math.max(var_208_14, arg_205_1.talkMaxDuration)

			if var_208_13 <= arg_205_1.time_ and arg_205_1.time_ < var_208_13 + var_208_21 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_13) / var_208_21

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_13 + var_208_21 and arg_205_1.time_ < var_208_13 + var_208_21 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end
	end,
	Play910110051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910110051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910110052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1070"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and arg_209_1.var_.actorSpriteComps1070 == nil then
				arg_209_1.var_.actorSpriteComps1070 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1070 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_212_1 then
							local var_212_4 = Mathf.Lerp(iter_212_1.color.r, 0.5, var_212_3)

							iter_212_1.color = Color.New(var_212_4, var_212_4, var_212_4)
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and arg_209_1.var_.actorSpriteComps1070 then
				local var_212_5 = 0.5

				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = Color.New(var_212_5, var_212_5, var_212_5)
					end
				end

				arg_209_1.var_.actorSpriteComps1070 = nil
			end

			local var_212_6 = 0
			local var_212_7 = 0.35

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:GetWordFromCfg(910110051)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 14
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end
	end,
	Play910110052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 910110052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play910110053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1070"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1070 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1070", 3)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_1" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(0, -350, -180)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1070, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_216_7 = arg_213_1.actors_["1070"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and arg_213_1.var_.actorSpriteComps1070 == nil then
				arg_213_1.var_.actorSpriteComps1070 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 0.0166666666666667

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps1070 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_216_2 then
							local var_216_11 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_10)

							iter_216_2.color = Color.New(var_216_11, var_216_11, var_216_11)
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and arg_213_1.var_.actorSpriteComps1070 then
				local var_216_12 = 1

				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_216_4 then
						iter_216_4.color = Color.New(var_216_12, var_216_12, var_216_12)
					end
				end

				arg_213_1.var_.actorSpriteComps1070 = nil
			end

			local var_216_13 = 0
			local var_216_14 = 0.35

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_15 = arg_213_1:FormatText(StoryNameCfg[318].name)

				arg_213_1.leftNameTxt_.text = var_216_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_16 = arg_213_1:GetWordFromCfg(910110052)
				local var_216_17 = arg_213_1:FormatText(var_216_16.content)

				arg_213_1.text_.text = var_216_17

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_18 = 14
				local var_216_19 = utf8.len(var_216_17)
				local var_216_20 = var_216_18 <= 0 and var_216_14 or var_216_14 * (var_216_19 / var_216_18)

				if var_216_20 > 0 and var_216_14 < var_216_20 then
					arg_213_1.talkMaxDuration = var_216_20

					if var_216_20 + var_216_13 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_13
					end
				end

				arg_213_1.text_.text = var_216_17
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_21 = math.max(var_216_14, arg_213_1.talkMaxDuration)

			if var_216_13 <= arg_213_1.time_ and arg_213_1.time_ < var_216_13 + var_216_21 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_13) / var_216_21

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_13 + var_216_21 and arg_213_1.time_ < var_216_13 + var_216_21 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end
	end,
	Play910110053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 910110053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play910110054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1070"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and arg_217_1.var_.actorSpriteComps1070 == nil then
				arg_217_1.var_.actorSpriteComps1070 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps1070 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_220_1 then
							local var_220_4 = Mathf.Lerp(iter_220_1.color.r, 0.5, var_220_3)

							iter_220_1.color = Color.New(var_220_4, var_220_4, var_220_4)
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and arg_217_1.var_.actorSpriteComps1070 then
				local var_220_5 = 0.5

				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = Color.New(var_220_5, var_220_5, var_220_5)
					end
				end

				arg_217_1.var_.actorSpriteComps1070 = nil
			end

			local var_220_6 = 0
			local var_220_7 = 0.25

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_9 = arg_217_1:GetWordFromCfg(910110053)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 10
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end
	end,
	Play910110054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 910110054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play910110055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1070"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1070 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1070", 3)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_5" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(0, -350, -180)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1070, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_224_7 = arg_221_1.actors_["1070"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and arg_221_1.var_.actorSpriteComps1070 == nil then
				arg_221_1.var_.actorSpriteComps1070 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.0166666666666667

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps1070 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_224_2 then
							local var_224_11 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

							iter_224_2.color = Color.New(var_224_11, var_224_11, var_224_11)
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and arg_221_1.var_.actorSpriteComps1070 then
				local var_224_12 = 1

				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = Color.New(var_224_12, var_224_12, var_224_12)
					end
				end

				arg_221_1.var_.actorSpriteComps1070 = nil
			end

			local var_224_13 = 0
			local var_224_14 = 0.05

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_15 = arg_221_1:FormatText(StoryNameCfg[318].name)

				arg_221_1.leftNameTxt_.text = var_224_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_16 = arg_221_1:GetWordFromCfg(910110054)
				local var_224_17 = arg_221_1:FormatText(var_224_16.content)

				arg_221_1.text_.text = var_224_17

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_18 = 2
				local var_224_19 = utf8.len(var_224_17)
				local var_224_20 = var_224_18 <= 0 and var_224_14 or var_224_14 * (var_224_19 / var_224_18)

				if var_224_20 > 0 and var_224_14 < var_224_20 then
					arg_221_1.talkMaxDuration = var_224_20

					if var_224_20 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_13
					end
				end

				arg_221_1.text_.text = var_224_17
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_21 = math.max(var_224_14, arg_221_1.talkMaxDuration)

			if var_224_13 <= arg_221_1.time_ and arg_221_1.time_ < var_224_13 + var_224_21 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_13) / var_224_21

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_13 + var_224_21 and arg_221_1.time_ < var_224_13 + var_224_21 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end
	end,
	Play910110055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 910110055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play910110056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.725

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[318].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:GetWordFromCfg(910110055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 29
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end
	end,
	Play910110056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 910110056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play910110057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1070"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and arg_229_1.var_.actorSpriteComps1070 == nil then
				arg_229_1.var_.actorSpriteComps1070 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1070 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_232_1 then
							local var_232_4 = Mathf.Lerp(iter_232_1.color.r, 0.5, var_232_3)

							iter_232_1.color = Color.New(var_232_4, var_232_4, var_232_4)
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and arg_229_1.var_.actorSpriteComps1070 then
				local var_232_5 = 0.5

				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = Color.New(var_232_5, var_232_5, var_232_5)
					end
				end

				arg_229_1.var_.actorSpriteComps1070 = nil
			end

			local var_232_6 = 0
			local var_232_7 = 0.275

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_8 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:GetWordFromCfg(910110056)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 11
				local var_232_12 = utf8.len(var_232_10)
				local var_232_13 = var_232_11 <= 0 and var_232_7 or var_232_7 * (var_232_12 / var_232_11)

				if var_232_13 > 0 and var_232_7 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end
	end,
	Play910110057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910110057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910110058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1070"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1070 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1070", 3)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "split_4" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(0, -350, -180)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1070, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_236_7 = arg_233_1.actors_["1070"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and arg_233_1.var_.actorSpriteComps1070 == nil then
				arg_233_1.var_.actorSpriteComps1070 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 0.0166666666666667

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps1070 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_236_2 then
							local var_236_11 = Mathf.Lerp(iter_236_2.color.r, 1, var_236_10)

							iter_236_2.color = Color.New(var_236_11, var_236_11, var_236_11)
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and arg_233_1.var_.actorSpriteComps1070 then
				local var_236_12 = 1

				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_236_4 then
						iter_236_4.color = Color.New(var_236_12, var_236_12, var_236_12)
					end
				end

				arg_233_1.var_.actorSpriteComps1070 = nil
			end

			local var_236_13 = 0
			local var_236_14 = 0.4

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_15 = arg_233_1:FormatText(StoryNameCfg[318].name)

				arg_233_1.leftNameTxt_.text = var_236_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_16 = arg_233_1:GetWordFromCfg(910110057)
				local var_236_17 = arg_233_1:FormatText(var_236_16.content)

				arg_233_1.text_.text = var_236_17

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_18 = 16
				local var_236_19 = utf8.len(var_236_17)
				local var_236_20 = var_236_18 <= 0 and var_236_14 or var_236_14 * (var_236_19 / var_236_18)

				if var_236_20 > 0 and var_236_14 < var_236_20 then
					arg_233_1.talkMaxDuration = var_236_20

					if var_236_20 + var_236_13 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_20 + var_236_13
					end
				end

				arg_233_1.text_.text = var_236_17
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_21 = math.max(var_236_14, arg_233_1.talkMaxDuration)

			if var_236_13 <= arg_233_1.time_ and arg_233_1.time_ < var_236_13 + var_236_21 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_13) / var_236_21

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_13 + var_236_21 and arg_233_1.time_ < var_236_13 + var_236_21 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end
	end,
	Play910110058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910110058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910110059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1070"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and arg_237_1.var_.actorSpriteComps1070 == nil then
				arg_237_1.var_.actorSpriteComps1070 = var_240_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.actorSpriteComps1070 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_240_1 then
							local var_240_4 = Mathf.Lerp(iter_240_1.color.r, 0.5, var_240_3)

							iter_240_1.color = Color.New(var_240_4, var_240_4, var_240_4)
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and arg_237_1.var_.actorSpriteComps1070 then
				local var_240_5 = 0.5

				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = Color.New(var_240_5, var_240_5, var_240_5)
					end
				end

				arg_237_1.var_.actorSpriteComps1070 = nil
			end

			local var_240_6 = 0
			local var_240_7 = 0.25

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_8 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_9 = arg_237_1:GetWordFromCfg(910110058)
				local var_240_10 = arg_237_1:FormatText(var_240_9.content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 10
				local var_240_12 = utf8.len(var_240_10)
				local var_240_13 = var_240_11 <= 0 and var_240_7 or var_240_7 * (var_240_12 / var_240_11)

				if var_240_13 > 0 and var_240_7 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end
	end,
	Play910110059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910110059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910110060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1070"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and arg_241_1.var_.actorSpriteComps1070 == nil then
				arg_241_1.var_.actorSpriteComps1070 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps1070 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_244_1 then
							local var_244_4 = Mathf.Lerp(iter_244_1.color.r, 1, var_244_3)

							iter_244_1.color = Color.New(var_244_4, var_244_4, var_244_4)
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and arg_241_1.var_.actorSpriteComps1070 then
				local var_244_5 = 1

				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = Color.New(var_244_5, var_244_5, var_244_5)
					end
				end

				arg_241_1.var_.actorSpriteComps1070 = nil
			end

			local var_244_6 = 0
			local var_244_7 = 0.775

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[318].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:GetWordFromCfg(910110059)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 31
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end
	end,
	Play910110060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 910110060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play910110061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1070"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and arg_245_1.var_.actorSpriteComps1070 == nil then
				arg_245_1.var_.actorSpriteComps1070 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps1070 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_248_1 then
							local var_248_4 = Mathf.Lerp(iter_248_1.color.r, 0.5, var_248_3)

							iter_248_1.color = Color.New(var_248_4, var_248_4, var_248_4)
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and arg_245_1.var_.actorSpriteComps1070 then
				local var_248_5 = 0.5

				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = Color.New(var_248_5, var_248_5, var_248_5)
					end
				end

				arg_245_1.var_.actorSpriteComps1070 = nil
			end

			local var_248_6 = 0
			local var_248_7 = 0.225

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_9 = arg_245_1:GetWordFromCfg(910110060)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 9
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_14 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_14 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_14

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_14 and arg_245_1.time_ < var_248_6 + var_248_14 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end
	end,
	Play910110061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 910110061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play910110062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.475

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(910110061)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 19
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end
	end,
	Play910110062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 910110062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play910110063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1070"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1070 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1070", 3)

				local var_256_2 = var_256_0.childCount

				for iter_256_0 = 0, var_256_2 - 1 do
					local var_256_3 = var_256_0:GetChild(iter_256_0)

					if var_256_3.name == "split_1" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_4 then
				local var_256_5 = (arg_253_1.time_ - var_256_1) / var_256_4
				local var_256_6 = Vector3.New(0, -350, -180)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1070, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_256_7 = arg_253_1.actors_["1070"]
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 and arg_253_1.var_.actorSpriteComps1070 == nil then
				arg_253_1.var_.actorSpriteComps1070 = var_256_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 0.0166666666666667

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_9 then
				local var_256_10 = (arg_253_1.time_ - var_256_8) / var_256_9

				if arg_253_1.var_.actorSpriteComps1070 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_256_2 then
							local var_256_11 = Mathf.Lerp(iter_256_2.color.r, 1, var_256_10)

							iter_256_2.color = Color.New(var_256_11, var_256_11, var_256_11)
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_8 + var_256_9 and arg_253_1.time_ < var_256_8 + var_256_9 + arg_256_0 and arg_253_1.var_.actorSpriteComps1070 then
				local var_256_12 = 1

				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_256_4 then
						iter_256_4.color = Color.New(var_256_12, var_256_12, var_256_12)
					end
				end

				arg_253_1.var_.actorSpriteComps1070 = nil
			end

			local var_256_13 = 0
			local var_256_14 = 0.9

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_15 = arg_253_1:FormatText(StoryNameCfg[318].name)

				arg_253_1.leftNameTxt_.text = var_256_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_16 = arg_253_1:GetWordFromCfg(910110062)
				local var_256_17 = arg_253_1:FormatText(var_256_16.content)

				arg_253_1.text_.text = var_256_17

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_18 = 36
				local var_256_19 = utf8.len(var_256_17)
				local var_256_20 = var_256_18 <= 0 and var_256_14 or var_256_14 * (var_256_19 / var_256_18)

				if var_256_20 > 0 and var_256_14 < var_256_20 then
					arg_253_1.talkMaxDuration = var_256_20

					if var_256_20 + var_256_13 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_20 + var_256_13
					end
				end

				arg_253_1.text_.text = var_256_17
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_21 = math.max(var_256_14, arg_253_1.talkMaxDuration)

			if var_256_13 <= arg_253_1.time_ and arg_253_1.time_ < var_256_13 + var_256_21 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_13) / var_256_21

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_13 + var_256_21 and arg_253_1.time_ < var_256_13 + var_256_21 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end
	end,
	Play910110063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 910110063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play910110064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1070"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and arg_257_1.var_.actorSpriteComps1070 == nil then
				arg_257_1.var_.actorSpriteComps1070 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps1070 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_260_1 then
							local var_260_4 = Mathf.Lerp(iter_260_1.color.r, 0.5, var_260_3)

							iter_260_1.color = Color.New(var_260_4, var_260_4, var_260_4)
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and arg_257_1.var_.actorSpriteComps1070 then
				local var_260_5 = 0.5

				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = Color.New(var_260_5, var_260_5, var_260_5)
					end
				end

				arg_257_1.var_.actorSpriteComps1070 = nil
			end

			local var_260_6 = 0
			local var_260_7 = 1.275

			if var_260_6 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_8 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_9 = arg_257_1:GetWordFromCfg(910110063)
				local var_260_10 = arg_257_1:FormatText(var_260_9.content)

				arg_257_1.text_.text = var_260_10

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 51
				local var_260_12 = utf8.len(var_260_10)
				local var_260_13 = var_260_11 <= 0 and var_260_7 or var_260_7 * (var_260_12 / var_260_11)

				if var_260_13 > 0 and var_260_7 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_10
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end
	end,
	Play910110064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 910110064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play910110065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1070"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and arg_261_1.var_.actorSpriteComps1070 == nil then
				arg_261_1.var_.actorSpriteComps1070 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps1070 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_264_1 then
							local var_264_4 = Mathf.Lerp(iter_264_1.color.r, 1, var_264_3)

							iter_264_1.color = Color.New(var_264_4, var_264_4, var_264_4)
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and arg_261_1.var_.actorSpriteComps1070 then
				local var_264_5 = 1

				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_264_3 then
						iter_264_3.color = Color.New(var_264_5, var_264_5, var_264_5)
					end
				end

				arg_261_1.var_.actorSpriteComps1070 = nil
			end

			local var_264_6 = 0
			local var_264_7 = 0.15

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_8 = arg_261_1:FormatText(StoryNameCfg[318].name)

				arg_261_1.leftNameTxt_.text = var_264_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_9 = arg_261_1:GetWordFromCfg(910110064)
				local var_264_10 = arg_261_1:FormatText(var_264_9.content)

				arg_261_1.text_.text = var_264_10

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 6
				local var_264_12 = utf8.len(var_264_10)
				local var_264_13 = var_264_11 <= 0 and var_264_7 or var_264_7 * (var_264_12 / var_264_11)

				if var_264_13 > 0 and var_264_7 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_10
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end
	end,
	Play910110065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 910110065
		arg_265_1.duration_ = 0.199999999999

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"

			SetActive(arg_265_1.choicesGo_, true)

			for iter_266_0, iter_266_1 in ipairs(arg_265_1.choices_) do
				local var_266_0 = iter_266_0 <= 2

				SetActive(iter_266_1.go, var_266_0)
			end

			arg_265_1.choices_[1].txt.text = arg_265_1:FormatText(StoryChoiceCfg[294].name)
			arg_265_1.choices_[2].txt.text = arg_265_1:FormatText(StoryChoiceCfg[295].name)
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play910110066(arg_265_1)
			end

			if arg_267_0 == 2 then
				arg_265_0:Play910110066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1070"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and arg_265_1.var_.actorSpriteComps1070 == nil then
				arg_265_1.var_.actorSpriteComps1070 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps1070 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_268_1 then
							local var_268_4 = Mathf.Lerp(iter_268_1.color.r, 0.5, var_268_3)

							iter_268_1.color = Color.New(var_268_4, var_268_4, var_268_4)
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and arg_265_1.var_.actorSpriteComps1070 then
				local var_268_5 = 0.5

				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = Color.New(var_268_5, var_268_5, var_268_5)
					end
				end

				arg_265_1.var_.actorSpriteComps1070 = nil
			end
		end
	end,
	Play910110066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 910110066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play910110067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1070"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1070 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1070", 3)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_2" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(0, -350, -180)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1070, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_272_7 = arg_269_1.actors_["1070"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and arg_269_1.var_.actorSpriteComps1070 == nil then
				arg_269_1.var_.actorSpriteComps1070 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.0166666666666667

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps1070 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_272_2 then
							local var_272_11 = Mathf.Lerp(iter_272_2.color.r, 1, var_272_10)

							iter_272_2.color = Color.New(var_272_11, var_272_11, var_272_11)
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and arg_269_1.var_.actorSpriteComps1070 then
				local var_272_12 = 1

				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = Color.New(var_272_12, var_272_12, var_272_12)
					end
				end

				arg_269_1.var_.actorSpriteComps1070 = nil
			end

			local var_272_13 = 0
			local var_272_14 = 0.375

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_15 = arg_269_1:FormatText(StoryNameCfg[318].name)

				arg_269_1.leftNameTxt_.text = var_272_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_16 = arg_269_1:GetWordFromCfg(910110066)
				local var_272_17 = arg_269_1:FormatText(var_272_16.content)

				arg_269_1.text_.text = var_272_17

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_18 = 15
				local var_272_19 = utf8.len(var_272_17)
				local var_272_20 = var_272_18 <= 0 and var_272_14 or var_272_14 * (var_272_19 / var_272_18)

				if var_272_20 > 0 and var_272_14 < var_272_20 then
					arg_269_1.talkMaxDuration = var_272_20

					if var_272_20 + var_272_13 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_20 + var_272_13
					end
				end

				arg_269_1.text_.text = var_272_17
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_21 = math.max(var_272_14, arg_269_1.talkMaxDuration)

			if var_272_13 <= arg_269_1.time_ and arg_269_1.time_ < var_272_13 + var_272_21 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_13) / var_272_21

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_13 + var_272_21 and arg_269_1.time_ < var_272_13 + var_272_21 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end
	end,
	Play910110067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 910110067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play910110068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1070"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and arg_273_1.var_.actorSpriteComps1070 == nil then
				arg_273_1.var_.actorSpriteComps1070 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps1070 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_276_1 then
							local var_276_4 = Mathf.Lerp(iter_276_1.color.r, 0.5, var_276_3)

							iter_276_1.color = Color.New(var_276_4, var_276_4, var_276_4)
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and arg_273_1.var_.actorSpriteComps1070 then
				local var_276_5 = 0.5

				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_276_3 then
						iter_276_3.color = Color.New(var_276_5, var_276_5, var_276_5)
					end
				end

				arg_273_1.var_.actorSpriteComps1070 = nil
			end

			local var_276_6 = 0
			local var_276_7 = 0.325

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_9 = arg_273_1:GetWordFromCfg(910110067)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 13
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end
	end,
	Play910110068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 910110068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play910110069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.375

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(910110068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 15
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end
	end,
	Play910110069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 910110069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play910110070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1070"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos1070 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1070", 3)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "split_1" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(0, -350, -180)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1070, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_284_7 = arg_281_1.actors_["1070"]
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 and arg_281_1.var_.actorSpriteComps1070 == nil then
				arg_281_1.var_.actorSpriteComps1070 = var_284_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_9 = 0.0166666666666667

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_9 then
				local var_284_10 = (arg_281_1.time_ - var_284_8) / var_284_9

				if arg_281_1.var_.actorSpriteComps1070 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_284_2 then
							local var_284_11 = Mathf.Lerp(iter_284_2.color.r, 1, var_284_10)

							iter_284_2.color = Color.New(var_284_11, var_284_11, var_284_11)
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_8 + var_284_9 and arg_281_1.time_ < var_284_8 + var_284_9 + arg_284_0 and arg_281_1.var_.actorSpriteComps1070 then
				local var_284_12 = 1

				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = Color.New(var_284_12, var_284_12, var_284_12)
					end
				end

				arg_281_1.var_.actorSpriteComps1070 = nil
			end

			local var_284_13 = 0
			local var_284_14 = 0.25

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_15 = arg_281_1:FormatText(StoryNameCfg[318].name)

				arg_281_1.leftNameTxt_.text = var_284_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_16 = arg_281_1:GetWordFromCfg(910110069)
				local var_284_17 = arg_281_1:FormatText(var_284_16.content)

				arg_281_1.text_.text = var_284_17

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_18 = 10
				local var_284_19 = utf8.len(var_284_17)
				local var_284_20 = var_284_18 <= 0 and var_284_14 or var_284_14 * (var_284_19 / var_284_18)

				if var_284_20 > 0 and var_284_14 < var_284_20 then
					arg_281_1.talkMaxDuration = var_284_20

					if var_284_20 + var_284_13 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_13
					end
				end

				arg_281_1.text_.text = var_284_17
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_21 = math.max(var_284_14, arg_281_1.talkMaxDuration)

			if var_284_13 <= arg_281_1.time_ and arg_281_1.time_ < var_284_13 + var_284_21 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_13) / var_284_21

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_13 + var_284_21 and arg_281_1.time_ < var_284_13 + var_284_21 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end
	end,
	Play910110070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 910110070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play910110071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1070"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and arg_285_1.var_.actorSpriteComps1070 == nil then
				arg_285_1.var_.actorSpriteComps1070 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps1070 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_288_1 then
							local var_288_4 = Mathf.Lerp(iter_288_1.color.r, 0.5, var_288_3)

							iter_288_1.color = Color.New(var_288_4, var_288_4, var_288_4)
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and arg_285_1.var_.actorSpriteComps1070 then
				local var_288_5 = 0.5

				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = Color.New(var_288_5, var_288_5, var_288_5)
					end
				end

				arg_285_1.var_.actorSpriteComps1070 = nil
			end

			local var_288_6 = 0
			local var_288_7 = 0.275

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_9 = arg_285_1:GetWordFromCfg(910110070)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 11
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end
	end,
	Play910110071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 910110071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play910110072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1070"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1070 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1070", 3)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "split_8" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(0, -350, -180)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1070, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_292_7 = arg_289_1.actors_["1070"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and arg_289_1.var_.actorSpriteComps1070 == nil then
				arg_289_1.var_.actorSpriteComps1070 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.0166666666666667

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps1070 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_292_2 then
							local var_292_11 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

							iter_292_2.color = Color.New(var_292_11, var_292_11, var_292_11)
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and arg_289_1.var_.actorSpriteComps1070 then
				local var_292_12 = 1

				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = Color.New(var_292_12, var_292_12, var_292_12)
					end
				end

				arg_289_1.var_.actorSpriteComps1070 = nil
			end

			local var_292_13 = 0
			local var_292_14 = 0.25

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_15 = arg_289_1:FormatText(StoryNameCfg[318].name)

				arg_289_1.leftNameTxt_.text = var_292_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_16 = arg_289_1:GetWordFromCfg(910110071)
				local var_292_17 = arg_289_1:FormatText(var_292_16.content)

				arg_289_1.text_.text = var_292_17

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_18 = 10
				local var_292_19 = utf8.len(var_292_17)
				local var_292_20 = var_292_18 <= 0 and var_292_14 or var_292_14 * (var_292_19 / var_292_18)

				if var_292_20 > 0 and var_292_14 < var_292_20 then
					arg_289_1.talkMaxDuration = var_292_20

					if var_292_20 + var_292_13 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_20 + var_292_13
					end
				end

				arg_289_1.text_.text = var_292_17
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_21 = math.max(var_292_14, arg_289_1.talkMaxDuration)

			if var_292_13 <= arg_289_1.time_ and arg_289_1.time_ < var_292_13 + var_292_21 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_13) / var_292_21

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_13 + var_292_21 and arg_289_1.time_ < var_292_13 + var_292_21 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end
	end,
	Play910110072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 910110072
		arg_293_1.duration_ = 7.034

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play910110073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = "I05"

			if arg_293_1.bgs_[var_296_0] == nil then
				local var_296_1 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_296_0)
				var_296_1.name = var_296_0
				var_296_1.transform.parent = arg_293_1.stage_.transform
				var_296_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_[var_296_0] = var_296_1
			end

			local var_296_2 = 2

			if var_296_2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				local var_296_3 = manager.ui.mainCamera.transform.localPosition
				local var_296_4 = Vector3.New(0, 0, 10) + Vector3.New(var_296_3.x, var_296_3.y, 0)
				local var_296_5 = arg_293_1.bgs_.I05

				var_296_5.transform.localPosition = var_296_4
				var_296_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_6 = var_296_5:GetComponent("SpriteRenderer")

				if var_296_6 and var_296_6.sprite then
					local var_296_7 = (var_296_5.transform.localPosition - var_296_3).z
					local var_296_8 = manager.ui.mainCameraCom_
					local var_296_9 = 2 * var_296_7 * Mathf.Tan(var_296_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_296_10 = var_296_9 * var_296_8.aspect
					local var_296_11 = var_296_6.sprite.bounds.size.x
					local var_296_12 = var_296_6.sprite.bounds.size.y
					local var_296_13 = var_296_10 / var_296_11
					local var_296_14 = var_296_9 / var_296_12
					local var_296_15 = var_296_14 < var_296_13 and var_296_13 or var_296_14

					var_296_5.transform.localScale = Vector3.New(var_296_15, var_296_15, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "I05" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_17 = 2

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17
				local var_296_19 = Color.New(0, 0, 0)

				var_296_19.a = Mathf.Lerp(0, 1, var_296_18)
				arg_293_1.mask_.color = var_296_19
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 then
				local var_296_20 = Color.New(0, 0, 0)

				var_296_20.a = 1
				arg_293_1.mask_.color = var_296_20
			end

			local var_296_21 = 2

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_22 = 2

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_22 then
				local var_296_23 = (arg_293_1.time_ - var_296_21) / var_296_22
				local var_296_24 = Color.New(0, 0, 0)

				var_296_24.a = Mathf.Lerp(1, 0, var_296_23)
				arg_293_1.mask_.color = var_296_24
			end

			if arg_293_1.time_ >= var_296_21 + var_296_22 and arg_293_1.time_ < var_296_21 + var_296_22 + arg_296_0 then
				local var_296_25 = Color.New(0, 0, 0)
				local var_296_26 = 0

				arg_293_1.mask_.enabled = false
				var_296_25.a = var_296_26
				arg_293_1.mask_.color = var_296_25
			end

			local var_296_27 = arg_293_1.actors_["1070"].transform
			local var_296_28 = 2

			if var_296_28 < arg_293_1.time_ and arg_293_1.time_ <= var_296_28 + arg_296_0 then
				arg_293_1.var_.moveOldPos1070 = var_296_27.localPosition
				var_296_27.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1070", 3)

				local var_296_29 = var_296_27.childCount

				for iter_296_2 = 0, var_296_29 - 1 do
					local var_296_30 = var_296_27:GetChild(iter_296_2)

					if var_296_30.name == "split_2" or not string.find(var_296_30.name, "split") then
						var_296_30.gameObject:SetActive(true)
					else
						var_296_30.gameObject:SetActive(false)
					end
				end
			end

			local var_296_31 = 0.001

			if var_296_28 <= arg_293_1.time_ and arg_293_1.time_ < var_296_28 + var_296_31 then
				local var_296_32 = (arg_293_1.time_ - var_296_28) / var_296_31
				local var_296_33 = Vector3.New(0, -350, -180)

				var_296_27.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1070, var_296_33, var_296_32)
			end

			if arg_293_1.time_ >= var_296_28 + var_296_31 and arg_293_1.time_ < var_296_28 + var_296_31 + arg_296_0 then
				var_296_27.localPosition = Vector3.New(0, -350, -180)
			end

			local var_296_34 = arg_293_1.actors_["1070"]
			local var_296_35 = 2

			if var_296_35 < arg_293_1.time_ and arg_293_1.time_ <= var_296_35 + arg_296_0 and arg_293_1.var_.actorSpriteComps1070 == nil then
				arg_293_1.var_.actorSpriteComps1070 = var_296_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_36 = 0.0166666666666667

			if var_296_35 <= arg_293_1.time_ and arg_293_1.time_ < var_296_35 + var_296_36 then
				local var_296_37 = (arg_293_1.time_ - var_296_35) / var_296_36

				if arg_293_1.var_.actorSpriteComps1070 then
					for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_296_4 then
							local var_296_38 = Mathf.Lerp(iter_296_4.color.r, 1, var_296_37)

							iter_296_4.color = Color.New(var_296_38, var_296_38, var_296_38)
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_35 + var_296_36 and arg_293_1.time_ < var_296_35 + var_296_36 + arg_296_0 and arg_293_1.var_.actorSpriteComps1070 then
				local var_296_39 = 1

				for iter_296_5, iter_296_6 in pairs(arg_293_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_296_6 then
						iter_296_6.color = Color.New(var_296_39, var_296_39, var_296_39)
					end
				end

				arg_293_1.var_.actorSpriteComps1070 = nil
			end

			local var_296_40 = arg_293_1.actors_["1070"]
			local var_296_41 = 2

			if var_296_41 < arg_293_1.time_ and arg_293_1.time_ <= var_296_41 + arg_296_0 then
				local var_296_42 = var_296_40:GetComponentInChildren(typeof(CanvasGroup))

				if var_296_42 then
					arg_293_1.var_.alphaOldValue1070 = var_296_42.alpha
					arg_293_1.var_.characterEffect1070 = var_296_42
				end

				arg_293_1.var_.alphaOldValue1070 = 0
			end

			local var_296_43 = 0.3

			if var_296_41 <= arg_293_1.time_ and arg_293_1.time_ < var_296_41 + var_296_43 then
				local var_296_44 = (arg_293_1.time_ - var_296_41) / var_296_43
				local var_296_45 = Mathf.Lerp(arg_293_1.var_.alphaOldValue1070, 1, var_296_44)

				if arg_293_1.var_.characterEffect1070 then
					arg_293_1.var_.characterEffect1070.alpha = var_296_45
				end
			end

			if arg_293_1.time_ >= var_296_41 + var_296_43 and arg_293_1.time_ < var_296_41 + var_296_43 + arg_296_0 and arg_293_1.var_.characterEffect1070 then
				arg_293_1.var_.characterEffect1070.alpha = 1
			end

			local var_296_46 = 2.034
			local var_296_47 = 0.175

			if var_296_46 < arg_293_1.time_ and arg_293_1.time_ <= var_296_46 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_48 = arg_293_1:FormatText(StoryNameCfg[318].name)

				arg_293_1.leftNameTxt_.text = var_296_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_49 = arg_293_1:GetWordFromCfg(910110072)
				local var_296_50 = arg_293_1:FormatText(var_296_49.content)

				arg_293_1.text_.text = var_296_50

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_51 = 7
				local var_296_52 = utf8.len(var_296_50)
				local var_296_53 = var_296_51 <= 0 and var_296_47 or var_296_47 * (var_296_52 / var_296_51)

				if var_296_53 > 0 and var_296_47 < var_296_53 then
					arg_293_1.talkMaxDuration = var_296_53

					if var_296_53 + var_296_46 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_53 + var_296_46
					end
				end

				arg_293_1.text_.text = var_296_50
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_54 = math.max(var_296_47, arg_293_1.talkMaxDuration)

			if var_296_46 <= arg_293_1.time_ and arg_293_1.time_ < var_296_46 + var_296_54 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_46) / var_296_54

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_46 + var_296_54 and arg_293_1.time_ < var_296_46 + var_296_54 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end
	end,
	Play910110073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 910110073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play910110074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1070"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and arg_297_1.var_.actorSpriteComps1070 == nil then
				arg_297_1.var_.actorSpriteComps1070 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.0166666666666667

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1070 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_300_1 then
							local var_300_4 = Mathf.Lerp(iter_300_1.color.r, 0.5, var_300_3)

							iter_300_1.color = Color.New(var_300_4, var_300_4, var_300_4)
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and arg_297_1.var_.actorSpriteComps1070 then
				local var_300_5 = 0.5

				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = Color.New(var_300_5, var_300_5, var_300_5)
					end
				end

				arg_297_1.var_.actorSpriteComps1070 = nil
			end

			local var_300_6 = 0
			local var_300_7 = 0.6

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_9 = arg_297_1:GetWordFromCfg(910110073)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 24
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end
	end,
	Play910110074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 910110074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play910110075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1070"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1070 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1070", 3)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "split_3" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(0, -350, -180)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1070, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_304_7 = arg_301_1.actors_["1070"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and arg_301_1.var_.actorSpriteComps1070 == nil then
				arg_301_1.var_.actorSpriteComps1070 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 0.0166666666666667

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps1070 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_304_2 then
							local var_304_11 = Mathf.Lerp(iter_304_2.color.r, 1, var_304_10)

							iter_304_2.color = Color.New(var_304_11, var_304_11, var_304_11)
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and arg_301_1.var_.actorSpriteComps1070 then
				local var_304_12 = 1

				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = Color.New(var_304_12, var_304_12, var_304_12)
					end
				end

				arg_301_1.var_.actorSpriteComps1070 = nil
			end

			local var_304_13 = 0
			local var_304_14 = 1.2

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_15 = arg_301_1:FormatText(StoryNameCfg[318].name)

				arg_301_1.leftNameTxt_.text = var_304_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_16 = arg_301_1:GetWordFromCfg(910110074)
				local var_304_17 = arg_301_1:FormatText(var_304_16.content)

				arg_301_1.text_.text = var_304_17

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_18 = 48
				local var_304_19 = utf8.len(var_304_17)
				local var_304_20 = var_304_18 <= 0 and var_304_14 or var_304_14 * (var_304_19 / var_304_18)

				if var_304_20 > 0 and var_304_14 < var_304_20 then
					arg_301_1.talkMaxDuration = var_304_20

					if var_304_20 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_13
					end
				end

				arg_301_1.text_.text = var_304_17
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_21 = math.max(var_304_14, arg_301_1.talkMaxDuration)

			if var_304_13 <= arg_301_1.time_ and arg_301_1.time_ < var_304_13 + var_304_21 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_13) / var_304_21

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_13 + var_304_21 and arg_301_1.time_ < var_304_13 + var_304_21 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end
	end,
	Play910110075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 910110075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play910110076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1070"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and arg_305_1.var_.actorSpriteComps1070 == nil then
				arg_305_1.var_.actorSpriteComps1070 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps1070 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_308_1 then
							local var_308_4 = Mathf.Lerp(iter_308_1.color.r, 0.5, var_308_3)

							iter_308_1.color = Color.New(var_308_4, var_308_4, var_308_4)
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and arg_305_1.var_.actorSpriteComps1070 then
				local var_308_5 = 0.5

				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = Color.New(var_308_5, var_308_5, var_308_5)
					end
				end

				arg_305_1.var_.actorSpriteComps1070 = nil
			end

			local var_308_6 = 0
			local var_308_7 = 1.475

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_9 = arg_305_1:GetWordFromCfg(910110075)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 59
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end
	end,
	Play910110076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 910110076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play910110077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1070"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and arg_309_1.var_.actorSpriteComps1070 == nil then
				arg_309_1.var_.actorSpriteComps1070 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps1070 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_312_1 then
							local var_312_4 = Mathf.Lerp(iter_312_1.color.r, 1, var_312_3)

							iter_312_1.color = Color.New(var_312_4, var_312_4, var_312_4)
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and arg_309_1.var_.actorSpriteComps1070 then
				local var_312_5 = 1

				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = Color.New(var_312_5, var_312_5, var_312_5)
					end
				end

				arg_309_1.var_.actorSpriteComps1070 = nil
			end

			local var_312_6 = 0
			local var_312_7 = 0.1

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[318].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_9 = arg_309_1:GetWordFromCfg(910110076)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 4
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_14 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_14 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_14

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_14 and arg_309_1.time_ < var_312_6 + var_312_14 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end
	end,
	Play910110077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910110077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910110078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1070"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and arg_313_1.var_.actorSpriteComps1070 == nil then
				arg_313_1.var_.actorSpriteComps1070 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps1070 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_316_1 then
							local var_316_4 = Mathf.Lerp(iter_316_1.color.r, 0.5, var_316_3)

							iter_316_1.color = Color.New(var_316_4, var_316_4, var_316_4)
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and arg_313_1.var_.actorSpriteComps1070 then
				local var_316_5 = 0.5

				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = Color.New(var_316_5, var_316_5, var_316_5)
					end
				end

				arg_313_1.var_.actorSpriteComps1070 = nil
			end

			local var_316_6 = 0
			local var_316_7 = 0.3

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(910110077)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 12
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_14 and arg_313_1.time_ < var_316_6 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end
	end,
	Play910110078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910110078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910110079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.6

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(910110078)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 24
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end
	end,
	Play910110079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910110079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910110080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1070"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and arg_321_1.var_.actorSpriteComps1070 == nil then
				arg_321_1.var_.actorSpriteComps1070 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.0166666666666667

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps1070 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_324_1 then
							local var_324_4 = Mathf.Lerp(iter_324_1.color.r, 1, var_324_3)

							iter_324_1.color = Color.New(var_324_4, var_324_4, var_324_4)
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and arg_321_1.var_.actorSpriteComps1070 then
				local var_324_5 = 1

				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = Color.New(var_324_5, var_324_5, var_324_5)
					end
				end

				arg_321_1.var_.actorSpriteComps1070 = nil
			end

			local var_324_6 = arg_321_1.actors_["1070"].transform
			local var_324_7 = 0

			if var_324_7 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.var_.moveOldPos1070 = var_324_6.localPosition
				var_324_6.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1070", 3)

				local var_324_8 = var_324_6.childCount

				for iter_324_4 = 0, var_324_8 - 1 do
					local var_324_9 = var_324_6:GetChild(iter_324_4)

					if var_324_9.name == "split_6" or not string.find(var_324_9.name, "split") then
						var_324_9.gameObject:SetActive(true)
					else
						var_324_9.gameObject:SetActive(false)
					end
				end
			end

			local var_324_10 = 0.001

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_10 then
				local var_324_11 = (arg_321_1.time_ - var_324_7) / var_324_10
				local var_324_12 = Vector3.New(0, -350, -180)

				var_324_6.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1070, var_324_12, var_324_11)
			end

			if arg_321_1.time_ >= var_324_7 + var_324_10 and arg_321_1.time_ < var_324_7 + var_324_10 + arg_324_0 then
				var_324_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_324_13 = 0
			local var_324_14 = 1.175

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_15 = arg_321_1:FormatText(StoryNameCfg[318].name)

				arg_321_1.leftNameTxt_.text = var_324_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_16 = arg_321_1:GetWordFromCfg(910110079)
				local var_324_17 = arg_321_1:FormatText(var_324_16.content)

				arg_321_1.text_.text = var_324_17

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_18 = 47
				local var_324_19 = utf8.len(var_324_17)
				local var_324_20 = var_324_18 <= 0 and var_324_14 or var_324_14 * (var_324_19 / var_324_18)

				if var_324_20 > 0 and var_324_14 < var_324_20 then
					arg_321_1.talkMaxDuration = var_324_20

					if var_324_20 + var_324_13 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_20 + var_324_13
					end
				end

				arg_321_1.text_.text = var_324_17
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_21 = math.max(var_324_14, arg_321_1.talkMaxDuration)

			if var_324_13 <= arg_321_1.time_ and arg_321_1.time_ < var_324_13 + var_324_21 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_13) / var_324_21

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_13 + var_324_21 and arg_321_1.time_ < var_324_13 + var_324_21 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end
	end,
	Play910110080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910110080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910110081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1070"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and arg_325_1.var_.actorSpriteComps1070 == nil then
				arg_325_1.var_.actorSpriteComps1070 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps1070 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_328_1 then
							local var_328_4 = Mathf.Lerp(iter_328_1.color.r, 0.5, var_328_3)

							iter_328_1.color = Color.New(var_328_4, var_328_4, var_328_4)
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and arg_325_1.var_.actorSpriteComps1070 then
				local var_328_5 = 0.5

				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = Color.New(var_328_5, var_328_5, var_328_5)
					end
				end

				arg_325_1.var_.actorSpriteComps1070 = nil
			end

			local var_328_6 = 0
			local var_328_7 = 0.9

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_9 = arg_325_1:GetWordFromCfg(910110080)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 36
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end
	end,
	Play910110081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910110081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910110082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1070"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and arg_329_1.var_.actorSpriteComps1070 == nil then
				arg_329_1.var_.actorSpriteComps1070 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.0166666666666667

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1070 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_332_1 then
							local var_332_4 = Mathf.Lerp(iter_332_1.color.r, 1, var_332_3)

							iter_332_1.color = Color.New(var_332_4, var_332_4, var_332_4)
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and arg_329_1.var_.actorSpriteComps1070 then
				local var_332_5 = 1

				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = Color.New(var_332_5, var_332_5, var_332_5)
					end
				end

				arg_329_1.var_.actorSpriteComps1070 = nil
			end

			local var_332_6 = arg_329_1.actors_["1070"].transform
			local var_332_7 = 0

			if var_332_7 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.var_.moveOldPos1070 = var_332_6.localPosition
				var_332_6.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1070", 3)

				local var_332_8 = var_332_6.childCount

				for iter_332_4 = 0, var_332_8 - 1 do
					local var_332_9 = var_332_6:GetChild(iter_332_4)

					if var_332_9.name == "split_3" or not string.find(var_332_9.name, "split") then
						var_332_9.gameObject:SetActive(true)
					else
						var_332_9.gameObject:SetActive(false)
					end
				end
			end

			local var_332_10 = 0.001

			if var_332_7 <= arg_329_1.time_ and arg_329_1.time_ < var_332_7 + var_332_10 then
				local var_332_11 = (arg_329_1.time_ - var_332_7) / var_332_10
				local var_332_12 = Vector3.New(0, -350, -180)

				var_332_6.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1070, var_332_12, var_332_11)
			end

			if arg_329_1.time_ >= var_332_7 + var_332_10 and arg_329_1.time_ < var_332_7 + var_332_10 + arg_332_0 then
				var_332_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_332_13 = 0
			local var_332_14 = 1.85

			if var_332_13 < arg_329_1.time_ and arg_329_1.time_ <= var_332_13 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_15 = arg_329_1:FormatText(StoryNameCfg[318].name)

				arg_329_1.leftNameTxt_.text = var_332_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_16 = arg_329_1:GetWordFromCfg(910110081)
				local var_332_17 = arg_329_1:FormatText(var_332_16.content)

				arg_329_1.text_.text = var_332_17

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_18 = 74
				local var_332_19 = utf8.len(var_332_17)
				local var_332_20 = var_332_18 <= 0 and var_332_14 or var_332_14 * (var_332_19 / var_332_18)

				if var_332_20 > 0 and var_332_14 < var_332_20 then
					arg_329_1.talkMaxDuration = var_332_20

					if var_332_20 + var_332_13 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_20 + var_332_13
					end
				end

				arg_329_1.text_.text = var_332_17
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_21 = math.max(var_332_14, arg_329_1.talkMaxDuration)

			if var_332_13 <= arg_329_1.time_ and arg_329_1.time_ < var_332_13 + var_332_21 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_13) / var_332_21

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_13 + var_332_21 and arg_329_1.time_ < var_332_13 + var_332_21 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end
	end,
	Play910110082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910110082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910110083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1070"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and arg_333_1.var_.actorSpriteComps1070 == nil then
				arg_333_1.var_.actorSpriteComps1070 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps1070 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_336_1 then
							local var_336_4 = Mathf.Lerp(iter_336_1.color.r, 0.5, var_336_3)

							iter_336_1.color = Color.New(var_336_4, var_336_4, var_336_4)
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and arg_333_1.var_.actorSpriteComps1070 then
				local var_336_5 = 0.5

				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = Color.New(var_336_5, var_336_5, var_336_5)
					end
				end

				arg_333_1.var_.actorSpriteComps1070 = nil
			end

			local var_336_6 = 0
			local var_336_7 = 0.25

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_9 = arg_333_1:GetWordFromCfg(910110082)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 10
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end
	end,
	Play910110083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910110083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910110084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1070"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and arg_337_1.var_.actorSpriteComps1070 == nil then
				arg_337_1.var_.actorSpriteComps1070 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.0166666666666667

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps1070 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_340_1 then
							local var_340_4 = Mathf.Lerp(iter_340_1.color.r, 1, var_340_3)

							iter_340_1.color = Color.New(var_340_4, var_340_4, var_340_4)
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and arg_337_1.var_.actorSpriteComps1070 then
				local var_340_5 = 1

				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_340_3 then
						iter_340_3.color = Color.New(var_340_5, var_340_5, var_340_5)
					end
				end

				arg_337_1.var_.actorSpriteComps1070 = nil
			end

			local var_340_6 = arg_337_1.actors_["1070"].transform
			local var_340_7 = 0

			if var_340_7 < arg_337_1.time_ and arg_337_1.time_ <= var_340_7 + arg_340_0 then
				arg_337_1.var_.moveOldPos1070 = var_340_6.localPosition
				var_340_6.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("1070", 3)

				local var_340_8 = var_340_6.childCount

				for iter_340_4 = 0, var_340_8 - 1 do
					local var_340_9 = var_340_6:GetChild(iter_340_4)

					if var_340_9.name == "split_1" or not string.find(var_340_9.name, "split") then
						var_340_9.gameObject:SetActive(true)
					else
						var_340_9.gameObject:SetActive(false)
					end
				end
			end

			local var_340_10 = 0.001

			if var_340_7 <= arg_337_1.time_ and arg_337_1.time_ < var_340_7 + var_340_10 then
				local var_340_11 = (arg_337_1.time_ - var_340_7) / var_340_10
				local var_340_12 = Vector3.New(0, -350, -180)

				var_340_6.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1070, var_340_12, var_340_11)
			end

			if arg_337_1.time_ >= var_340_7 + var_340_10 and arg_337_1.time_ < var_340_7 + var_340_10 + arg_340_0 then
				var_340_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_340_13 = 0
			local var_340_14 = 0.75

			if var_340_13 < arg_337_1.time_ and arg_337_1.time_ <= var_340_13 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_15 = arg_337_1:FormatText(StoryNameCfg[318].name)

				arg_337_1.leftNameTxt_.text = var_340_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_16 = arg_337_1:GetWordFromCfg(910110083)
				local var_340_17 = arg_337_1:FormatText(var_340_16.content)

				arg_337_1.text_.text = var_340_17

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_18 = 30
				local var_340_19 = utf8.len(var_340_17)
				local var_340_20 = var_340_18 <= 0 and var_340_14 or var_340_14 * (var_340_19 / var_340_18)

				if var_340_20 > 0 and var_340_14 < var_340_20 then
					arg_337_1.talkMaxDuration = var_340_20

					if var_340_20 + var_340_13 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_20 + var_340_13
					end
				end

				arg_337_1.text_.text = var_340_17
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_21 = math.max(var_340_14, arg_337_1.talkMaxDuration)

			if var_340_13 <= arg_337_1.time_ and arg_337_1.time_ < var_340_13 + var_340_21 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_13) / var_340_21

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_13 + var_340_21 and arg_337_1.time_ < var_340_13 + var_340_21 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end
	end,
	Play910110084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910110084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910110085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1070"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and arg_341_1.var_.actorSpriteComps1070 == nil then
				arg_341_1.var_.actorSpriteComps1070 = var_344_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_2 = 0.2

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.actorSpriteComps1070 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_344_1 then
							local var_344_4 = Mathf.Lerp(iter_344_1.color.r, 0.5, var_344_3)

							iter_344_1.color = Color.New(var_344_4, var_344_4, var_344_4)
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and arg_341_1.var_.actorSpriteComps1070 then
				local var_344_5 = 0.5

				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = Color.New(var_344_5, var_344_5, var_344_5)
					end
				end

				arg_341_1.var_.actorSpriteComps1070 = nil
			end

			local var_344_6 = 0
			local var_344_7 = 0.2

			if var_344_6 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_8 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_9 = arg_341_1:GetWordFromCfg(910110084)
				local var_344_10 = arg_341_1:FormatText(var_344_9.content)

				arg_341_1.text_.text = var_344_10

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 8
				local var_344_12 = utf8.len(var_344_10)
				local var_344_13 = var_344_11 <= 0 and var_344_7 or var_344_7 * (var_344_12 / var_344_11)

				if var_344_13 > 0 and var_344_7 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_10
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_14 and arg_341_1.time_ < var_344_6 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end
	end,
	Play910110085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910110085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910110086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1070"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and arg_345_1.var_.actorSpriteComps1070 == nil then
				arg_345_1.var_.actorSpriteComps1070 = var_348_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_2 = 0.0166666666666667

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.actorSpriteComps1070 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_348_1 then
							local var_348_4 = Mathf.Lerp(iter_348_1.color.r, 1, var_348_3)

							iter_348_1.color = Color.New(var_348_4, var_348_4, var_348_4)
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and arg_345_1.var_.actorSpriteComps1070 then
				local var_348_5 = 1

				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_348_3 then
						iter_348_3.color = Color.New(var_348_5, var_348_5, var_348_5)
					end
				end

				arg_345_1.var_.actorSpriteComps1070 = nil
			end

			local var_348_6 = 0
			local var_348_7 = 0.6

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[318].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_9 = arg_345_1:GetWordFromCfg(910110085)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 24
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end
	end,
	Play910110086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910110086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910110087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.875

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[318].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:GetWordFromCfg(910110086)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 35
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end
	end,
	Play910110087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910110087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910110088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1070"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and arg_353_1.var_.actorSpriteComps1070 == nil then
				arg_353_1.var_.actorSpriteComps1070 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps1070 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_356_1 then
							local var_356_4 = Mathf.Lerp(iter_356_1.color.r, 0.5, var_356_3)

							iter_356_1.color = Color.New(var_356_4, var_356_4, var_356_4)
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and arg_353_1.var_.actorSpriteComps1070 then
				local var_356_5 = 0.5

				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = Color.New(var_356_5, var_356_5, var_356_5)
					end
				end

				arg_353_1.var_.actorSpriteComps1070 = nil
			end

			local var_356_6 = 0
			local var_356_7 = 0.225

			if var_356_6 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_8 = arg_353_1:FormatText(StoryNameCfg[7].name)

				arg_353_1.leftNameTxt_.text = var_356_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_9 = arg_353_1:GetWordFromCfg(910110087)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 9
				local var_356_12 = utf8.len(var_356_10)
				local var_356_13 = var_356_11 <= 0 and var_356_7 or var_356_7 * (var_356_12 / var_356_11)

				if var_356_13 > 0 and var_356_7 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_14 and arg_353_1.time_ < var_356_6 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end
	end,
	Play910110088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910110088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910110089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1070"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and arg_357_1.var_.actorSpriteComps1070 == nil then
				arg_357_1.var_.actorSpriteComps1070 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.0166666666666667

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps1070 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_360_1 then
							local var_360_4 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

							iter_360_1.color = Color.New(var_360_4, var_360_4, var_360_4)
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and arg_357_1.var_.actorSpriteComps1070 then
				local var_360_5 = 1

				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = Color.New(var_360_5, var_360_5, var_360_5)
					end
				end

				arg_357_1.var_.actorSpriteComps1070 = nil
			end

			local var_360_6 = arg_357_1.actors_["1070"].transform
			local var_360_7 = 0

			if var_360_7 < arg_357_1.time_ and arg_357_1.time_ <= var_360_7 + arg_360_0 then
				arg_357_1.var_.moveOldPos1070 = var_360_6.localPosition
				var_360_6.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1070", 3)

				local var_360_8 = var_360_6.childCount

				for iter_360_4 = 0, var_360_8 - 1 do
					local var_360_9 = var_360_6:GetChild(iter_360_4)

					if var_360_9.name == "split_2" or not string.find(var_360_9.name, "split") then
						var_360_9.gameObject:SetActive(true)
					else
						var_360_9.gameObject:SetActive(false)
					end
				end
			end

			local var_360_10 = 0.001

			if var_360_7 <= arg_357_1.time_ and arg_357_1.time_ < var_360_7 + var_360_10 then
				local var_360_11 = (arg_357_1.time_ - var_360_7) / var_360_10
				local var_360_12 = Vector3.New(0, -350, -180)

				var_360_6.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1070, var_360_12, var_360_11)
			end

			if arg_357_1.time_ >= var_360_7 + var_360_10 and arg_357_1.time_ < var_360_7 + var_360_10 + arg_360_0 then
				var_360_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_360_13 = 0
			local var_360_14 = 0.7

			if var_360_13 < arg_357_1.time_ and arg_357_1.time_ <= var_360_13 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_15 = arg_357_1:FormatText(StoryNameCfg[318].name)

				arg_357_1.leftNameTxt_.text = var_360_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_16 = arg_357_1:GetWordFromCfg(910110088)
				local var_360_17 = arg_357_1:FormatText(var_360_16.content)

				arg_357_1.text_.text = var_360_17

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_18 = 28
				local var_360_19 = utf8.len(var_360_17)
				local var_360_20 = var_360_18 <= 0 and var_360_14 or var_360_14 * (var_360_19 / var_360_18)

				if var_360_20 > 0 and var_360_14 < var_360_20 then
					arg_357_1.talkMaxDuration = var_360_20

					if var_360_20 + var_360_13 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_20 + var_360_13
					end
				end

				arg_357_1.text_.text = var_360_17
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_21 = math.max(var_360_14, arg_357_1.talkMaxDuration)

			if var_360_13 <= arg_357_1.time_ and arg_357_1.time_ < var_360_13 + var_360_21 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_13) / var_360_21

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_13 + var_360_21 and arg_357_1.time_ < var_360_13 + var_360_21 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end
	end,
	Play910110089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 910110089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play910110090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["1070"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and arg_361_1.var_.actorSpriteComps1070 == nil then
				arg_361_1.var_.actorSpriteComps1070 = var_364_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_2 = 0.2

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.actorSpriteComps1070 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_364_1 then
							local var_364_4 = Mathf.Lerp(iter_364_1.color.r, 0.5, var_364_3)

							iter_364_1.color = Color.New(var_364_4, var_364_4, var_364_4)
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and arg_361_1.var_.actorSpriteComps1070 then
				local var_364_5 = 0.5

				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = Color.New(var_364_5, var_364_5, var_364_5)
					end
				end

				arg_361_1.var_.actorSpriteComps1070 = nil
			end

			local var_364_6 = 0
			local var_364_7 = 0.425

			if var_364_6 < arg_361_1.time_ and arg_361_1.time_ <= var_364_6 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_8 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_9 = arg_361_1:GetWordFromCfg(910110089)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_11 = 17
				local var_364_12 = utf8.len(var_364_10)
				local var_364_13 = var_364_11 <= 0 and var_364_7 or var_364_7 * (var_364_12 / var_364_11)

				if var_364_13 > 0 and var_364_7 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_6 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_6
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_14 = math.max(var_364_7, arg_361_1.talkMaxDuration)

			if var_364_6 <= arg_361_1.time_ and arg_361_1.time_ < var_364_6 + var_364_14 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_6) / var_364_14

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_6 + var_364_14 and arg_361_1.time_ < var_364_6 + var_364_14 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end
	end,
	Play910110090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 910110090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play910110091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 1.525

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(910110090)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 61
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
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end
	end,
	Play910110091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 910110091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play910110092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1070"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1070 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1070", 3)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "split_5" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(0, -350, -180)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1070, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_372_7 = arg_369_1.actors_["1070"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and arg_369_1.var_.actorSpriteComps1070 == nil then
				arg_369_1.var_.actorSpriteComps1070 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 0.0166666666666667

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps1070 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_372_2 then
							local var_372_11 = Mathf.Lerp(iter_372_2.color.r, 1, var_372_10)

							iter_372_2.color = Color.New(var_372_11, var_372_11, var_372_11)
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and arg_369_1.var_.actorSpriteComps1070 then
				local var_372_12 = 1

				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_372_4 then
						iter_372_4.color = Color.New(var_372_12, var_372_12, var_372_12)
					end
				end

				arg_369_1.var_.actorSpriteComps1070 = nil
			end

			local var_372_13 = 0
			local var_372_14 = 0.4

			if var_372_13 < arg_369_1.time_ and arg_369_1.time_ <= var_372_13 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_15 = arg_369_1:FormatText(StoryNameCfg[318].name)

				arg_369_1.leftNameTxt_.text = var_372_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_16 = arg_369_1:GetWordFromCfg(910110091)
				local var_372_17 = arg_369_1:FormatText(var_372_16.content)

				arg_369_1.text_.text = var_372_17

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_18 = 16
				local var_372_19 = utf8.len(var_372_17)
				local var_372_20 = var_372_18 <= 0 and var_372_14 or var_372_14 * (var_372_19 / var_372_18)

				if var_372_20 > 0 and var_372_14 < var_372_20 then
					arg_369_1.talkMaxDuration = var_372_20

					if var_372_20 + var_372_13 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_20 + var_372_13
					end
				end

				arg_369_1.text_.text = var_372_17
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_21 = math.max(var_372_14, arg_369_1.talkMaxDuration)

			if var_372_13 <= arg_369_1.time_ and arg_369_1.time_ < var_372_13 + var_372_21 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_13) / var_372_21

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_13 + var_372_21 and arg_369_1.time_ < var_372_13 + var_372_21 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end
	end,
	Play910110092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 910110092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play910110093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = "1039"

			if arg_373_1.actors_[var_376_0] == nil then
				local var_376_1 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_376_0), arg_373_1.canvasGo_.transform)

				var_376_1.transform:SetSiblingIndex(1)

				var_376_1.name = var_376_0
				var_376_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_373_1.actors_[var_376_0] = var_376_1
			end

			local var_376_2 = arg_373_1.actors_["1039"].transform
			local var_376_3 = 0

			if var_376_3 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.var_.moveOldPos1039 = var_376_2.localPosition
				var_376_2.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1039", 2)

				local var_376_4 = var_376_2.childCount

				for iter_376_0 = 0, var_376_4 - 1 do
					local var_376_5 = var_376_2:GetChild(iter_376_0)

					if var_376_5.name == "split_1" or not string.find(var_376_5.name, "split") then
						var_376_5.gameObject:SetActive(true)
					else
						var_376_5.gameObject:SetActive(false)
					end
				end
			end

			local var_376_6 = 0.001

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_6 then
				local var_376_7 = (arg_373_1.time_ - var_376_3) / var_376_6
				local var_376_8 = Vector3.New(-390, -350, -180)

				var_376_2.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1039, var_376_8, var_376_7)
			end

			if arg_373_1.time_ >= var_376_3 + var_376_6 and arg_373_1.time_ < var_376_3 + var_376_6 + arg_376_0 then
				var_376_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_376_9 = arg_373_1.actors_["1039"]
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 and arg_373_1.var_.actorSpriteComps1039 == nil then
				arg_373_1.var_.actorSpriteComps1039 = var_376_9:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_11 = 0.0166666666666667

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11

				if arg_373_1.var_.actorSpriteComps1039 then
					for iter_376_1, iter_376_2 in pairs(arg_373_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_376_2 then
							local var_376_13 = Mathf.Lerp(iter_376_2.color.r, 1, var_376_12)

							iter_376_2.color = Color.New(var_376_13, var_376_13, var_376_13)
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 and arg_373_1.var_.actorSpriteComps1039 then
				local var_376_14 = 1

				for iter_376_3, iter_376_4 in pairs(arg_373_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_376_4 then
						iter_376_4.color = Color.New(var_376_14, var_376_14, var_376_14)
					end
				end

				arg_373_1.var_.actorSpriteComps1039 = nil
			end

			local var_376_15 = arg_373_1.actors_["1070"].transform
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.var_.moveOldPos1070 = var_376_15.localPosition
				var_376_15.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1070", 4)

				local var_376_17 = var_376_15.childCount

				for iter_376_5 = 0, var_376_17 - 1 do
					local var_376_18 = var_376_15:GetChild(iter_376_5)

					if var_376_18.name == "split_1" or not string.find(var_376_18.name, "split") then
						var_376_18.gameObject:SetActive(true)
					else
						var_376_18.gameObject:SetActive(false)
					end
				end
			end

			local var_376_19 = 0.001

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_19 then
				local var_376_20 = (arg_373_1.time_ - var_376_16) / var_376_19
				local var_376_21 = Vector3.New(390, -350, -180)

				var_376_15.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1070, var_376_21, var_376_20)
			end

			if arg_373_1.time_ >= var_376_16 + var_376_19 and arg_373_1.time_ < var_376_16 + var_376_19 + arg_376_0 then
				var_376_15.localPosition = Vector3.New(390, -350, -180)
			end

			local var_376_22 = arg_373_1.actors_["1070"]
			local var_376_23 = 0

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 and arg_373_1.var_.actorSpriteComps1070 == nil then
				arg_373_1.var_.actorSpriteComps1070 = var_376_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_24 = 0.0166666666666667

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_24 then
				local var_376_25 = (arg_373_1.time_ - var_376_23) / var_376_24

				if arg_373_1.var_.actorSpriteComps1070 then
					for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_376_7 then
							local var_376_26 = Mathf.Lerp(iter_376_7.color.r, 0.5, var_376_25)

							iter_376_7.color = Color.New(var_376_26, var_376_26, var_376_26)
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_23 + var_376_24 and arg_373_1.time_ < var_376_23 + var_376_24 + arg_376_0 and arg_373_1.var_.actorSpriteComps1070 then
				local var_376_27 = 0.5

				for iter_376_8, iter_376_9 in pairs(arg_373_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_376_9 then
						iter_376_9.color = Color.New(var_376_27, var_376_27, var_376_27)
					end
				end

				arg_373_1.var_.actorSpriteComps1070 = nil
			end

			local var_376_28 = arg_373_1.actors_["1039"]
			local var_376_29 = 0

			if var_376_29 < arg_373_1.time_ and arg_373_1.time_ <= var_376_29 + arg_376_0 then
				local var_376_30 = var_376_28:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_30 then
					arg_373_1.var_.alphaOldValue1039 = var_376_30.alpha
					arg_373_1.var_.characterEffect1039 = var_376_30
				end

				arg_373_1.var_.alphaOldValue1039 = 0
			end

			local var_376_31 = 0.6

			if var_376_29 <= arg_373_1.time_ and arg_373_1.time_ < var_376_29 + var_376_31 then
				local var_376_32 = (arg_373_1.time_ - var_376_29) / var_376_31
				local var_376_33 = Mathf.Lerp(arg_373_1.var_.alphaOldValue1039, 1, var_376_32)

				if arg_373_1.var_.characterEffect1039 then
					arg_373_1.var_.characterEffect1039.alpha = var_376_33
				end
			end

			if arg_373_1.time_ >= var_376_29 + var_376_31 and arg_373_1.time_ < var_376_29 + var_376_31 + arg_376_0 and arg_373_1.var_.characterEffect1039 then
				arg_373_1.var_.characterEffect1039.alpha = 1
			end

			local var_376_34 = arg_373_1.actors_["1070"]
			local var_376_35 = 0

			if var_376_35 < arg_373_1.time_ and arg_373_1.time_ <= var_376_35 + arg_376_0 then
				local var_376_36 = var_376_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_36 then
					arg_373_1.var_.alphaOldValue1070 = var_376_36.alpha
					arg_373_1.var_.characterEffect1070 = var_376_36
				end

				arg_373_1.var_.alphaOldValue1070 = 0
			end

			local var_376_37 = 0.6

			if var_376_35 <= arg_373_1.time_ and arg_373_1.time_ < var_376_35 + var_376_37 then
				local var_376_38 = (arg_373_1.time_ - var_376_35) / var_376_37
				local var_376_39 = Mathf.Lerp(arg_373_1.var_.alphaOldValue1070, 1, var_376_38)

				if arg_373_1.var_.characterEffect1070 then
					arg_373_1.var_.characterEffect1070.alpha = var_376_39
				end
			end

			if arg_373_1.time_ >= var_376_35 + var_376_37 and arg_373_1.time_ < var_376_35 + var_376_37 + arg_376_0 and arg_373_1.var_.characterEffect1070 then
				arg_373_1.var_.characterEffect1070.alpha = 1
			end

			local var_376_40 = arg_373_1.actors_["1070"].transform
			local var_376_41 = 0

			if var_376_41 < arg_373_1.time_ and arg_373_1.time_ <= var_376_41 + arg_376_0 then
				arg_373_1.var_.moveOldPos1070 = var_376_40.localPosition
				var_376_40.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1070", 7)

				local var_376_42 = var_376_40.childCount

				for iter_376_10 = 0, var_376_42 - 1 do
					local var_376_43 = var_376_40:GetChild(iter_376_10)

					if var_376_43.name == "split_5" or not string.find(var_376_43.name, "split") then
						var_376_43.gameObject:SetActive(true)
					else
						var_376_43.gameObject:SetActive(false)
					end
				end
			end

			local var_376_44 = 0.001

			if var_376_41 <= arg_373_1.time_ and arg_373_1.time_ < var_376_41 + var_376_44 then
				local var_376_45 = (arg_373_1.time_ - var_376_41) / var_376_44
				local var_376_46 = Vector3.New(0, -2000, -180)

				var_376_40.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1070, var_376_46, var_376_45)
			end

			if arg_373_1.time_ >= var_376_41 + var_376_44 and arg_373_1.time_ < var_376_41 + var_376_44 + arg_376_0 then
				var_376_40.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_376_47 = 0
			local var_376_48 = 0.25

			if var_376_47 < arg_373_1.time_ and arg_373_1.time_ <= var_376_47 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_49 = arg_373_1:FormatText(StoryNameCfg[9].name)

				arg_373_1.leftNameTxt_.text = var_376_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_50 = arg_373_1:GetWordFromCfg(910110092)
				local var_376_51 = arg_373_1:FormatText(var_376_50.content)

				arg_373_1.text_.text = var_376_51

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_52 = 10
				local var_376_53 = utf8.len(var_376_51)
				local var_376_54 = var_376_52 <= 0 and var_376_48 or var_376_48 * (var_376_53 / var_376_52)

				if var_376_54 > 0 and var_376_48 < var_376_54 then
					arg_373_1.talkMaxDuration = var_376_54

					if var_376_54 + var_376_47 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_54 + var_376_47
					end
				end

				arg_373_1.text_.text = var_376_51
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_55 = math.max(var_376_48, arg_373_1.talkMaxDuration)

			if var_376_47 <= arg_373_1.time_ and arg_373_1.time_ < var_376_47 + var_376_55 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_47) / var_376_55

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_47 + var_376_55 and arg_373_1.time_ < var_376_47 + var_376_55 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end
	end,
	Play910110093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 910110093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play910110094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1039"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and arg_377_1.var_.actorSpriteComps1039 == nil then
				arg_377_1.var_.actorSpriteComps1039 = var_380_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_2 = 0.2

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.actorSpriteComps1039 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_380_1 then
							local var_380_4 = Mathf.Lerp(iter_380_1.color.r, 0.5, var_380_3)

							iter_380_1.color = Color.New(var_380_4, var_380_4, var_380_4)
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and arg_377_1.var_.actorSpriteComps1039 then
				local var_380_5 = 0.5

				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = Color.New(var_380_5, var_380_5, var_380_5)
					end
				end

				arg_377_1.var_.actorSpriteComps1039 = nil
			end

			local var_380_6 = arg_377_1.actors_["1070"]
			local var_380_7 = 0

			if var_380_7 < arg_377_1.time_ and arg_377_1.time_ <= var_380_7 + arg_380_0 and arg_377_1.var_.actorSpriteComps1070 == nil then
				arg_377_1.var_.actorSpriteComps1070 = var_380_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_8 = 0.2

			if var_380_7 <= arg_377_1.time_ and arg_377_1.time_ < var_380_7 + var_380_8 then
				local var_380_9 = (arg_377_1.time_ - var_380_7) / var_380_8

				if arg_377_1.var_.actorSpriteComps1070 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_380_5 then
							local var_380_10 = Mathf.Lerp(iter_380_5.color.r, 1, var_380_9)

							iter_380_5.color = Color.New(var_380_10, var_380_10, var_380_10)
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_7 + var_380_8 and arg_377_1.time_ < var_380_7 + var_380_8 + arg_380_0 and arg_377_1.var_.actorSpriteComps1070 then
				local var_380_11 = 1

				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_380_7 then
						iter_380_7.color = Color.New(var_380_11, var_380_11, var_380_11)
					end
				end

				arg_377_1.var_.actorSpriteComps1070 = nil
			end

			local var_380_12 = 0
			local var_380_13 = 0.325

			if var_380_12 < arg_377_1.time_ and arg_377_1.time_ <= var_380_12 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_14 = arg_377_1:FormatText(StoryNameCfg[318].name)

				arg_377_1.leftNameTxt_.text = var_380_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_15 = arg_377_1:GetWordFromCfg(910110093)
				local var_380_16 = arg_377_1:FormatText(var_380_15.content)

				arg_377_1.text_.text = var_380_16

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_17 = 13
				local var_380_18 = utf8.len(var_380_16)
				local var_380_19 = var_380_17 <= 0 and var_380_13 or var_380_13 * (var_380_18 / var_380_17)

				if var_380_19 > 0 and var_380_13 < var_380_19 then
					arg_377_1.talkMaxDuration = var_380_19

					if var_380_19 + var_380_12 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_19 + var_380_12
					end
				end

				arg_377_1.text_.text = var_380_16
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_20 = math.max(var_380_13, arg_377_1.talkMaxDuration)

			if var_380_12 <= arg_377_1.time_ and arg_377_1.time_ < var_380_12 + var_380_20 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_12) / var_380_20

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_12 + var_380_20 and arg_377_1.time_ < var_380_12 + var_380_20 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end
	end,
	Play910110094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 910110094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play910110095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1070"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1070 = var_384_0.localPosition
				var_384_0.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1070", 4)

				local var_384_2 = var_384_0.childCount

				for iter_384_0 = 0, var_384_2 - 1 do
					local var_384_3 = var_384_0:GetChild(iter_384_0)

					if var_384_3.name == "split_5" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_4 then
				local var_384_5 = (arg_381_1.time_ - var_384_1) / var_384_4
				local var_384_6 = Vector3.New(390, -350, -180)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1070, var_384_6, var_384_5)
			end

			if arg_381_1.time_ >= var_384_1 + var_384_4 and arg_381_1.time_ < var_384_1 + var_384_4 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_384_7 = arg_381_1.actors_["1039"]
			local var_384_8 = 0

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 and arg_381_1.var_.actorSpriteComps1039 == nil then
				arg_381_1.var_.actorSpriteComps1039 = var_384_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_9 = 0.0166666666666667

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_9 then
				local var_384_10 = (arg_381_1.time_ - var_384_8) / var_384_9

				if arg_381_1.var_.actorSpriteComps1039 then
					for iter_384_1, iter_384_2 in pairs(arg_381_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_384_2 then
							local var_384_11 = Mathf.Lerp(iter_384_2.color.r, 0.5, var_384_10)

							iter_384_2.color = Color.New(var_384_11, var_384_11, var_384_11)
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_8 + var_384_9 and arg_381_1.time_ < var_384_8 + var_384_9 + arg_384_0 and arg_381_1.var_.actorSpriteComps1039 then
				local var_384_12 = 0.5

				for iter_384_3, iter_384_4 in pairs(arg_381_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_384_4 then
						iter_384_4.color = Color.New(var_384_12, var_384_12, var_384_12)
					end
				end

				arg_381_1.var_.actorSpriteComps1039 = nil
			end

			local var_384_13 = 0
			local var_384_14 = 0.2

			if var_384_13 < arg_381_1.time_ and arg_381_1.time_ <= var_384_13 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_15 = arg_381_1:FormatText(StoryNameCfg[318].name)

				arg_381_1.leftNameTxt_.text = var_384_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_16 = arg_381_1:GetWordFromCfg(910110094)
				local var_384_17 = arg_381_1:FormatText(var_384_16.content)

				arg_381_1.text_.text = var_384_17

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_18 = 8
				local var_384_19 = utf8.len(var_384_17)
				local var_384_20 = var_384_18 <= 0 and var_384_14 or var_384_14 * (var_384_19 / var_384_18)

				if var_384_20 > 0 and var_384_14 < var_384_20 then
					arg_381_1.talkMaxDuration = var_384_20

					if var_384_20 + var_384_13 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_20 + var_384_13
					end
				end

				arg_381_1.text_.text = var_384_17
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_21 = math.max(var_384_14, arg_381_1.talkMaxDuration)

			if var_384_13 <= arg_381_1.time_ and arg_381_1.time_ < var_384_13 + var_384_21 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_13) / var_384_21

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_13 + var_384_21 and arg_381_1.time_ < var_384_13 + var_384_21 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end
	end,
	Play910110095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 910110095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play910110096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1039"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and arg_385_1.var_.actorSpriteComps1039 == nil then
				arg_385_1.var_.actorSpriteComps1039 = var_388_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_2 = 0.0166666666666667

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.actorSpriteComps1039 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_388_1 then
							local var_388_4 = Mathf.Lerp(iter_388_1.color.r, 1, var_388_3)

							iter_388_1.color = Color.New(var_388_4, var_388_4, var_388_4)
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and arg_385_1.var_.actorSpriteComps1039 then
				local var_388_5 = 1

				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = Color.New(var_388_5, var_388_5, var_388_5)
					end
				end

				arg_385_1.var_.actorSpriteComps1039 = nil
			end

			local var_388_6 = arg_385_1.actors_["1070"]
			local var_388_7 = 0

			if var_388_7 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 and arg_385_1.var_.actorSpriteComps1070 == nil then
				arg_385_1.var_.actorSpriteComps1070 = var_388_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_8 = 0.0166666666666667

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_8 then
				local var_388_9 = (arg_385_1.time_ - var_388_7) / var_388_8

				if arg_385_1.var_.actorSpriteComps1070 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_388_5 then
							local var_388_10 = Mathf.Lerp(iter_388_5.color.r, 0.5, var_388_9)

							iter_388_5.color = Color.New(var_388_10, var_388_10, var_388_10)
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_7 + var_388_8 and arg_385_1.time_ < var_388_7 + var_388_8 + arg_388_0 and arg_385_1.var_.actorSpriteComps1070 then
				local var_388_11 = 0.5

				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = Color.New(var_388_11, var_388_11, var_388_11)
					end
				end

				arg_385_1.var_.actorSpriteComps1070 = nil
			end

			local var_388_12 = 0
			local var_388_13 = 1.3

			if var_388_12 < arg_385_1.time_ and arg_385_1.time_ <= var_388_12 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_14 = arg_385_1:FormatText(StoryNameCfg[9].name)

				arg_385_1.leftNameTxt_.text = var_388_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_15 = arg_385_1:GetWordFromCfg(910110095)
				local var_388_16 = arg_385_1:FormatText(var_388_15.content)

				arg_385_1.text_.text = var_388_16

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_17 = 52
				local var_388_18 = utf8.len(var_388_16)
				local var_388_19 = var_388_17 <= 0 and var_388_13 or var_388_13 * (var_388_18 / var_388_17)

				if var_388_19 > 0 and var_388_13 < var_388_19 then
					arg_385_1.talkMaxDuration = var_388_19

					if var_388_19 + var_388_12 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_19 + var_388_12
					end
				end

				arg_385_1.text_.text = var_388_16
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_20 = math.max(var_388_13, arg_385_1.talkMaxDuration)

			if var_388_12 <= arg_385_1.time_ and arg_385_1.time_ < var_388_12 + var_388_20 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_12) / var_388_20

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_12 + var_388_20 and arg_385_1.time_ < var_388_12 + var_388_20 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end
	end,
	Play910110096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 910110096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play910110097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1039"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and arg_389_1.var_.actorSpriteComps1039 == nil then
				arg_389_1.var_.actorSpriteComps1039 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.0166666666666667

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps1039 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_392_1 then
							local var_392_4 = Mathf.Lerp(iter_392_1.color.r, 0.5, var_392_3)

							iter_392_1.color = Color.New(var_392_4, var_392_4, var_392_4)
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and arg_389_1.var_.actorSpriteComps1039 then
				local var_392_5 = 0.5

				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = Color.New(var_392_5, var_392_5, var_392_5)
					end
				end

				arg_389_1.var_.actorSpriteComps1039 = nil
			end

			local var_392_6 = arg_389_1.actors_["1070"]
			local var_392_7 = 0

			if var_392_7 < arg_389_1.time_ and arg_389_1.time_ <= var_392_7 + arg_392_0 and arg_389_1.var_.actorSpriteComps1070 == nil then
				arg_389_1.var_.actorSpriteComps1070 = var_392_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_8 = 0.0166666666666667

			if var_392_7 <= arg_389_1.time_ and arg_389_1.time_ < var_392_7 + var_392_8 then
				local var_392_9 = (arg_389_1.time_ - var_392_7) / var_392_8

				if arg_389_1.var_.actorSpriteComps1070 then
					for iter_392_4, iter_392_5 in pairs(arg_389_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_392_5 then
							local var_392_10 = Mathf.Lerp(iter_392_5.color.r, 1, var_392_9)

							iter_392_5.color = Color.New(var_392_10, var_392_10, var_392_10)
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_7 + var_392_8 and arg_389_1.time_ < var_392_7 + var_392_8 + arg_392_0 and arg_389_1.var_.actorSpriteComps1070 then
				local var_392_11 = 1

				for iter_392_6, iter_392_7 in pairs(arg_389_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_392_7 then
						iter_392_7.color = Color.New(var_392_11, var_392_11, var_392_11)
					end
				end

				arg_389_1.var_.actorSpriteComps1070 = nil
			end

			local var_392_12 = 0
			local var_392_13 = 0.575

			if var_392_12 < arg_389_1.time_ and arg_389_1.time_ <= var_392_12 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_14 = arg_389_1:FormatText(StoryNameCfg[318].name)

				arg_389_1.leftNameTxt_.text = var_392_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_15 = arg_389_1:GetWordFromCfg(910110096)
				local var_392_16 = arg_389_1:FormatText(var_392_15.content)

				arg_389_1.text_.text = var_392_16

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_17 = 23
				local var_392_18 = utf8.len(var_392_16)
				local var_392_19 = var_392_17 <= 0 and var_392_13 or var_392_13 * (var_392_18 / var_392_17)

				if var_392_19 > 0 and var_392_13 < var_392_19 then
					arg_389_1.talkMaxDuration = var_392_19

					if var_392_19 + var_392_12 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_19 + var_392_12
					end
				end

				arg_389_1.text_.text = var_392_16
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_20 = math.max(var_392_13, arg_389_1.talkMaxDuration)

			if var_392_12 <= arg_389_1.time_ and arg_389_1.time_ < var_392_12 + var_392_20 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_12) / var_392_20

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_12 + var_392_20 and arg_389_1.time_ < var_392_12 + var_392_20 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end
	end,
	Play910110097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 910110097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play910110098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1039"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and arg_393_1.var_.actorSpriteComps1039 == nil then
				arg_393_1.var_.actorSpriteComps1039 = var_396_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_2 = 0.2

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.actorSpriteComps1039 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_396_1 then
							local var_396_4 = Mathf.Lerp(iter_396_1.color.r, 1, var_396_3)

							iter_396_1.color = Color.New(var_396_4, var_396_4, var_396_4)
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and arg_393_1.var_.actorSpriteComps1039 then
				local var_396_5 = 1

				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = Color.New(var_396_5, var_396_5, var_396_5)
					end
				end

				arg_393_1.var_.actorSpriteComps1039 = nil
			end

			local var_396_6 = arg_393_1.actors_["1070"]
			local var_396_7 = 0

			if var_396_7 < arg_393_1.time_ and arg_393_1.time_ <= var_396_7 + arg_396_0 and arg_393_1.var_.actorSpriteComps1070 == nil then
				arg_393_1.var_.actorSpriteComps1070 = var_396_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_8 = 0.2

			if var_396_7 <= arg_393_1.time_ and arg_393_1.time_ < var_396_7 + var_396_8 then
				local var_396_9 = (arg_393_1.time_ - var_396_7) / var_396_8

				if arg_393_1.var_.actorSpriteComps1070 then
					for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_396_5 then
							local var_396_10 = Mathf.Lerp(iter_396_5.color.r, 0.5, var_396_9)

							iter_396_5.color = Color.New(var_396_10, var_396_10, var_396_10)
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_7 + var_396_8 and arg_393_1.time_ < var_396_7 + var_396_8 + arg_396_0 and arg_393_1.var_.actorSpriteComps1070 then
				local var_396_11 = 0.5

				for iter_396_6, iter_396_7 in pairs(arg_393_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_396_7 then
						iter_396_7.color = Color.New(var_396_11, var_396_11, var_396_11)
					end
				end

				arg_393_1.var_.actorSpriteComps1070 = nil
			end

			local var_396_12 = 0
			local var_396_13 = 0.65

			if var_396_12 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_14 = arg_393_1:FormatText(StoryNameCfg[9].name)

				arg_393_1.leftNameTxt_.text = var_396_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_15 = arg_393_1:GetWordFromCfg(910110097)
				local var_396_16 = arg_393_1:FormatText(var_396_15.content)

				arg_393_1.text_.text = var_396_16

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_17 = 26
				local var_396_18 = utf8.len(var_396_16)
				local var_396_19 = var_396_17 <= 0 and var_396_13 or var_396_13 * (var_396_18 / var_396_17)

				if var_396_19 > 0 and var_396_13 < var_396_19 then
					arg_393_1.talkMaxDuration = var_396_19

					if var_396_19 + var_396_12 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_19 + var_396_12
					end
				end

				arg_393_1.text_.text = var_396_16
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_20 = math.max(var_396_13, arg_393_1.talkMaxDuration)

			if var_396_12 <= arg_393_1.time_ and arg_393_1.time_ < var_396_12 + var_396_20 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_12) / var_396_20

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_12 + var_396_20 and arg_393_1.time_ < var_396_12 + var_396_20 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end
	end,
	Play910110098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 910110098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play910110099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1039"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and arg_397_1.var_.actorSpriteComps1039 == nil then
				arg_397_1.var_.actorSpriteComps1039 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps1039 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_400_1 then
							local var_400_4 = Mathf.Lerp(iter_400_1.color.r, 0.5, var_400_3)

							iter_400_1.color = Color.New(var_400_4, var_400_4, var_400_4)
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and arg_397_1.var_.actorSpriteComps1039 then
				local var_400_5 = 0.5

				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = Color.New(var_400_5, var_400_5, var_400_5)
					end
				end

				arg_397_1.var_.actorSpriteComps1039 = nil
			end

			local var_400_6 = arg_397_1.actors_["1070"]
			local var_400_7 = 0

			if var_400_7 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 and arg_397_1.var_.actorSpriteComps1070 == nil then
				arg_397_1.var_.actorSpriteComps1070 = var_400_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_8 = 0.0166666666666667

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_8 then
				local var_400_9 = (arg_397_1.time_ - var_400_7) / var_400_8

				if arg_397_1.var_.actorSpriteComps1070 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_400_5 then
							local var_400_10 = Mathf.Lerp(iter_400_5.color.r, 1, var_400_9)

							iter_400_5.color = Color.New(var_400_10, var_400_10, var_400_10)
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_7 + var_400_8 and arg_397_1.time_ < var_400_7 + var_400_8 + arg_400_0 and arg_397_1.var_.actorSpriteComps1070 then
				local var_400_11 = 1

				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_400_7 then
						iter_400_7.color = Color.New(var_400_11, var_400_11, var_400_11)
					end
				end

				arg_397_1.var_.actorSpriteComps1070 = nil
			end

			local var_400_12 = arg_397_1.actors_["1070"].transform
			local var_400_13 = 0

			if var_400_13 < arg_397_1.time_ and arg_397_1.time_ <= var_400_13 + arg_400_0 then
				arg_397_1.var_.moveOldPos1070 = var_400_12.localPosition
				var_400_12.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("1070", 4)

				local var_400_14 = var_400_12.childCount

				for iter_400_8 = 0, var_400_14 - 1 do
					local var_400_15 = var_400_12:GetChild(iter_400_8)

					if var_400_15.name == "split_2" or not string.find(var_400_15.name, "split") then
						var_400_15.gameObject:SetActive(true)
					else
						var_400_15.gameObject:SetActive(false)
					end
				end
			end

			local var_400_16 = 0.001

			if var_400_13 <= arg_397_1.time_ and arg_397_1.time_ < var_400_13 + var_400_16 then
				local var_400_17 = (arg_397_1.time_ - var_400_13) / var_400_16
				local var_400_18 = Vector3.New(390, -350, -180)

				var_400_12.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1070, var_400_18, var_400_17)
			end

			if arg_397_1.time_ >= var_400_13 + var_400_16 and arg_397_1.time_ < var_400_13 + var_400_16 + arg_400_0 then
				var_400_12.localPosition = Vector3.New(390, -350, -180)
			end

			local var_400_19 = 0
			local var_400_20 = 0.375

			if var_400_19 < arg_397_1.time_ and arg_397_1.time_ <= var_400_19 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_21 = arg_397_1:FormatText(StoryNameCfg[318].name)

				arg_397_1.leftNameTxt_.text = var_400_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_22 = arg_397_1:GetWordFromCfg(910110098)
				local var_400_23 = arg_397_1:FormatText(var_400_22.content)

				arg_397_1.text_.text = var_400_23

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_24 = 15
				local var_400_25 = utf8.len(var_400_23)
				local var_400_26 = var_400_24 <= 0 and var_400_20 or var_400_20 * (var_400_25 / var_400_24)

				if var_400_26 > 0 and var_400_20 < var_400_26 then
					arg_397_1.talkMaxDuration = var_400_26

					if var_400_26 + var_400_19 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_26 + var_400_19
					end
				end

				arg_397_1.text_.text = var_400_23
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_27 = math.max(var_400_20, arg_397_1.talkMaxDuration)

			if var_400_19 <= arg_397_1.time_ and arg_397_1.time_ < var_400_19 + var_400_27 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_19) / var_400_27

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_19 + var_400_27 and arg_397_1.time_ < var_400_19 + var_400_27 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end
	end,
	Play910110099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 910110099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play910110100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1039"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and arg_401_1.var_.actorSpriteComps1039 == nil then
				arg_401_1.var_.actorSpriteComps1039 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps1039 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_404_1 then
							local var_404_4 = Mathf.Lerp(iter_404_1.color.r, 1, var_404_3)

							iter_404_1.color = Color.New(var_404_4, var_404_4, var_404_4)
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and arg_401_1.var_.actorSpriteComps1039 then
				local var_404_5 = 1

				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = Color.New(var_404_5, var_404_5, var_404_5)
					end
				end

				arg_401_1.var_.actorSpriteComps1039 = nil
			end

			local var_404_6 = arg_401_1.actors_["1070"]
			local var_404_7 = 0

			if var_404_7 < arg_401_1.time_ and arg_401_1.time_ <= var_404_7 + arg_404_0 and arg_401_1.var_.actorSpriteComps1070 == nil then
				arg_401_1.var_.actorSpriteComps1070 = var_404_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_8 = 0.2

			if var_404_7 <= arg_401_1.time_ and arg_401_1.time_ < var_404_7 + var_404_8 then
				local var_404_9 = (arg_401_1.time_ - var_404_7) / var_404_8

				if arg_401_1.var_.actorSpriteComps1070 then
					for iter_404_4, iter_404_5 in pairs(arg_401_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_404_5 then
							local var_404_10 = Mathf.Lerp(iter_404_5.color.r, 0.5, var_404_9)

							iter_404_5.color = Color.New(var_404_10, var_404_10, var_404_10)
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_7 + var_404_8 and arg_401_1.time_ < var_404_7 + var_404_8 + arg_404_0 and arg_401_1.var_.actorSpriteComps1070 then
				local var_404_11 = 0.5

				for iter_404_6, iter_404_7 in pairs(arg_401_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_404_7 then
						iter_404_7.color = Color.New(var_404_11, var_404_11, var_404_11)
					end
				end

				arg_401_1.var_.actorSpriteComps1070 = nil
			end

			local var_404_12 = 0
			local var_404_13 = 0.65

			if var_404_12 < arg_401_1.time_ and arg_401_1.time_ <= var_404_12 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_14 = arg_401_1:FormatText(StoryNameCfg[9].name)

				arg_401_1.leftNameTxt_.text = var_404_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_15 = arg_401_1:GetWordFromCfg(910110099)
				local var_404_16 = arg_401_1:FormatText(var_404_15.content)

				arg_401_1.text_.text = var_404_16

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_17 = 26
				local var_404_18 = utf8.len(var_404_16)
				local var_404_19 = var_404_17 <= 0 and var_404_13 or var_404_13 * (var_404_18 / var_404_17)

				if var_404_19 > 0 and var_404_13 < var_404_19 then
					arg_401_1.talkMaxDuration = var_404_19

					if var_404_19 + var_404_12 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_19 + var_404_12
					end
				end

				arg_401_1.text_.text = var_404_16
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_20 = math.max(var_404_13, arg_401_1.talkMaxDuration)

			if var_404_12 <= arg_401_1.time_ and arg_401_1.time_ < var_404_12 + var_404_20 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_12) / var_404_20

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_12 + var_404_20 and arg_401_1.time_ < var_404_12 + var_404_20 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end
	end,
	Play910110100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 910110100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play910110101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1039"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and arg_405_1.var_.actorSpriteComps1039 == nil then
				arg_405_1.var_.actorSpriteComps1039 = var_408_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.actorSpriteComps1039 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_408_1 then
							local var_408_4 = Mathf.Lerp(iter_408_1.color.r, 0.5, var_408_3)

							iter_408_1.color = Color.New(var_408_4, var_408_4, var_408_4)
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and arg_405_1.var_.actorSpriteComps1039 then
				local var_408_5 = 0.5

				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_408_3 then
						iter_408_3.color = Color.New(var_408_5, var_408_5, var_408_5)
					end
				end

				arg_405_1.var_.actorSpriteComps1039 = nil
			end

			local var_408_6 = arg_405_1.actors_["1070"]
			local var_408_7 = 0

			if var_408_7 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 and arg_405_1.var_.actorSpriteComps1070 == nil then
				arg_405_1.var_.actorSpriteComps1070 = var_408_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_8 = 0.0166666666666667

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_8 then
				local var_408_9 = (arg_405_1.time_ - var_408_7) / var_408_8

				if arg_405_1.var_.actorSpriteComps1070 then
					for iter_408_4, iter_408_5 in pairs(arg_405_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_408_5 then
							local var_408_10 = Mathf.Lerp(iter_408_5.color.r, 1, var_408_9)

							iter_408_5.color = Color.New(var_408_10, var_408_10, var_408_10)
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_7 + var_408_8 and arg_405_1.time_ < var_408_7 + var_408_8 + arg_408_0 and arg_405_1.var_.actorSpriteComps1070 then
				local var_408_11 = 1

				for iter_408_6, iter_408_7 in pairs(arg_405_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_408_7 then
						iter_408_7.color = Color.New(var_408_11, var_408_11, var_408_11)
					end
				end

				arg_405_1.var_.actorSpriteComps1070 = nil
			end

			local var_408_12 = arg_405_1.actors_["1070"].transform
			local var_408_13 = 0

			if var_408_13 < arg_405_1.time_ and arg_405_1.time_ <= var_408_13 + arg_408_0 then
				arg_405_1.var_.moveOldPos1070 = var_408_12.localPosition
				var_408_12.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("1070", 4)

				local var_408_14 = var_408_12.childCount

				for iter_408_8 = 0, var_408_14 - 1 do
					local var_408_15 = var_408_12:GetChild(iter_408_8)

					if var_408_15.name == "split_7" or not string.find(var_408_15.name, "split") then
						var_408_15.gameObject:SetActive(true)
					else
						var_408_15.gameObject:SetActive(false)
					end
				end
			end

			local var_408_16 = 0.001

			if var_408_13 <= arg_405_1.time_ and arg_405_1.time_ < var_408_13 + var_408_16 then
				local var_408_17 = (arg_405_1.time_ - var_408_13) / var_408_16
				local var_408_18 = Vector3.New(390, -350, -180)

				var_408_12.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1070, var_408_18, var_408_17)
			end

			if arg_405_1.time_ >= var_408_13 + var_408_16 and arg_405_1.time_ < var_408_13 + var_408_16 + arg_408_0 then
				var_408_12.localPosition = Vector3.New(390, -350, -180)
			end

			local var_408_19 = 0
			local var_408_20 = 0.325

			if var_408_19 < arg_405_1.time_ and arg_405_1.time_ <= var_408_19 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_21 = arg_405_1:FormatText(StoryNameCfg[318].name)

				arg_405_1.leftNameTxt_.text = var_408_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_22 = arg_405_1:GetWordFromCfg(910110100)
				local var_408_23 = arg_405_1:FormatText(var_408_22.content)

				arg_405_1.text_.text = var_408_23

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_24 = 13
				local var_408_25 = utf8.len(var_408_23)
				local var_408_26 = var_408_24 <= 0 and var_408_20 or var_408_20 * (var_408_25 / var_408_24)

				if var_408_26 > 0 and var_408_20 < var_408_26 then
					arg_405_1.talkMaxDuration = var_408_26

					if var_408_26 + var_408_19 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_26 + var_408_19
					end
				end

				arg_405_1.text_.text = var_408_23
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_27 = math.max(var_408_20, arg_405_1.talkMaxDuration)

			if var_408_19 <= arg_405_1.time_ and arg_405_1.time_ < var_408_19 + var_408_27 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_19) / var_408_27

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_19 + var_408_27 and arg_405_1.time_ < var_408_19 + var_408_27 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end
	end,
	Play910110101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 910110101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play910110102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1039"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and arg_409_1.var_.actorSpriteComps1039 == nil then
				arg_409_1.var_.actorSpriteComps1039 = var_412_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.actorSpriteComps1039 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps1039:ToTable()) do
						if iter_412_1 then
							local var_412_4 = Mathf.Lerp(iter_412_1.color.r, 1, var_412_3)

							iter_412_1.color = Color.New(var_412_4, var_412_4, var_412_4)
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and arg_409_1.var_.actorSpriteComps1039 then
				local var_412_5 = 1

				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps1039:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = Color.New(var_412_5, var_412_5, var_412_5)
					end
				end

				arg_409_1.var_.actorSpriteComps1039 = nil
			end

			local var_412_6 = arg_409_1.actors_["1070"]
			local var_412_7 = 0

			if var_412_7 < arg_409_1.time_ and arg_409_1.time_ <= var_412_7 + arg_412_0 and arg_409_1.var_.actorSpriteComps1070 == nil then
				arg_409_1.var_.actorSpriteComps1070 = var_412_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_8 = 0.2

			if var_412_7 <= arg_409_1.time_ and arg_409_1.time_ < var_412_7 + var_412_8 then
				local var_412_9 = (arg_409_1.time_ - var_412_7) / var_412_8

				if arg_409_1.var_.actorSpriteComps1070 then
					for iter_412_4, iter_412_5 in pairs(arg_409_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_412_5 then
							local var_412_10 = Mathf.Lerp(iter_412_5.color.r, 0.5, var_412_9)

							iter_412_5.color = Color.New(var_412_10, var_412_10, var_412_10)
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_7 + var_412_8 and arg_409_1.time_ < var_412_7 + var_412_8 + arg_412_0 and arg_409_1.var_.actorSpriteComps1070 then
				local var_412_11 = 0.5

				for iter_412_6, iter_412_7 in pairs(arg_409_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_412_7 then
						iter_412_7.color = Color.New(var_412_11, var_412_11, var_412_11)
					end
				end

				arg_409_1.var_.actorSpriteComps1070 = nil
			end

			local var_412_12 = 0
			local var_412_13 = 0.725

			if var_412_12 < arg_409_1.time_ and arg_409_1.time_ <= var_412_12 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_14 = arg_409_1:FormatText(StoryNameCfg[9].name)

				arg_409_1.leftNameTxt_.text = var_412_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_15 = arg_409_1:GetWordFromCfg(910110101)
				local var_412_16 = arg_409_1:FormatText(var_412_15.content)

				arg_409_1.text_.text = var_412_16

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_17 = 29
				local var_412_18 = utf8.len(var_412_16)
				local var_412_19 = var_412_17 <= 0 and var_412_13 or var_412_13 * (var_412_18 / var_412_17)

				if var_412_19 > 0 and var_412_13 < var_412_19 then
					arg_409_1.talkMaxDuration = var_412_19

					if var_412_19 + var_412_12 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_19 + var_412_12
					end
				end

				arg_409_1.text_.text = var_412_16
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_20 = math.max(var_412_13, arg_409_1.talkMaxDuration)

			if var_412_12 <= arg_409_1.time_ and arg_409_1.time_ < var_412_12 + var_412_20 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_12) / var_412_20

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_12 + var_412_20 and arg_409_1.time_ < var_412_12 + var_412_20 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end
	end,
	Play910110102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 910110102
		arg_413_1.duration_ = 7

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play910110103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = "I05a"

			if arg_413_1.bgs_[var_416_0] == nil then
				local var_416_1 = Object.Instantiate(arg_413_1.paintGo_)

				var_416_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_416_0)
				var_416_1.name = var_416_0
				var_416_1.transform.parent = arg_413_1.stage_.transform
				var_416_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.bgs_[var_416_0] = var_416_1
			end

			local var_416_2 = 2

			if var_416_2 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				local var_416_3 = manager.ui.mainCamera.transform.localPosition
				local var_416_4 = Vector3.New(0, 0, 10) + Vector3.New(var_416_3.x, var_416_3.y, 0)
				local var_416_5 = arg_413_1.bgs_.I05a

				var_416_5.transform.localPosition = var_416_4
				var_416_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_6 = var_416_5:GetComponent("SpriteRenderer")

				if var_416_6 and var_416_6.sprite then
					local var_416_7 = (var_416_5.transform.localPosition - var_416_3).z
					local var_416_8 = manager.ui.mainCameraCom_
					local var_416_9 = 2 * var_416_7 * Mathf.Tan(var_416_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_416_10 = var_416_9 * var_416_8.aspect
					local var_416_11 = var_416_6.sprite.bounds.size.x
					local var_416_12 = var_416_6.sprite.bounds.size.y
					local var_416_13 = var_416_10 / var_416_11
					local var_416_14 = var_416_9 / var_416_12
					local var_416_15 = var_416_14 < var_416_13 and var_416_13 or var_416_14

					var_416_5.transform.localScale = Vector3.New(var_416_15, var_416_15, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "I05a" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_16 = arg_413_1.actors_["1070"].transform
			local var_416_17 = 2

			if var_416_17 < arg_413_1.time_ and arg_413_1.time_ <= var_416_17 + arg_416_0 then
				arg_413_1.var_.moveOldPos1070 = var_416_16.localPosition
				var_416_16.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1070", 3)

				local var_416_18 = var_416_16.childCount

				for iter_416_2 = 0, var_416_18 - 1 do
					local var_416_19 = var_416_16:GetChild(iter_416_2)

					if var_416_19.name == "split_2" or not string.find(var_416_19.name, "split") then
						var_416_19.gameObject:SetActive(true)
					else
						var_416_19.gameObject:SetActive(false)
					end
				end
			end

			local var_416_20 = 0.001

			if var_416_17 <= arg_413_1.time_ and arg_413_1.time_ < var_416_17 + var_416_20 then
				local var_416_21 = (arg_413_1.time_ - var_416_17) / var_416_20
				local var_416_22 = Vector3.New(0, -350, -180)

				var_416_16.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1070, var_416_22, var_416_21)
			end

			if arg_413_1.time_ >= var_416_17 + var_416_20 and arg_413_1.time_ < var_416_17 + var_416_20 + arg_416_0 then
				var_416_16.localPosition = Vector3.New(0, -350, -180)
			end

			local var_416_23 = arg_413_1.actors_["1070"]
			local var_416_24 = 2

			if var_416_24 < arg_413_1.time_ and arg_413_1.time_ <= var_416_24 + arg_416_0 and arg_413_1.var_.actorSpriteComps1070 == nil then
				arg_413_1.var_.actorSpriteComps1070 = var_416_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_25 = 0.0166666666666667

			if var_416_24 <= arg_413_1.time_ and arg_413_1.time_ < var_416_24 + var_416_25 then
				local var_416_26 = (arg_413_1.time_ - var_416_24) / var_416_25

				if arg_413_1.var_.actorSpriteComps1070 then
					for iter_416_3, iter_416_4 in pairs(arg_413_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_416_4 then
							local var_416_27 = Mathf.Lerp(iter_416_4.color.r, 1, var_416_26)

							iter_416_4.color = Color.New(var_416_27, var_416_27, var_416_27)
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_24 + var_416_25 and arg_413_1.time_ < var_416_24 + var_416_25 + arg_416_0 and arg_413_1.var_.actorSpriteComps1070 then
				local var_416_28 = 1

				for iter_416_5, iter_416_6 in pairs(arg_413_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_416_6 then
						iter_416_6.color = Color.New(var_416_28, var_416_28, var_416_28)
					end
				end

				arg_413_1.var_.actorSpriteComps1070 = nil
			end

			local var_416_29 = arg_413_1.actors_["1070"].transform
			local var_416_30 = 0

			if var_416_30 < arg_413_1.time_ and arg_413_1.time_ <= var_416_30 + arg_416_0 then
				arg_413_1.var_.moveOldPos1070 = var_416_29.localPosition
				var_416_29.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1070", 7)

				local var_416_31 = var_416_29.childCount

				for iter_416_7 = 0, var_416_31 - 1 do
					local var_416_32 = var_416_29:GetChild(iter_416_7)

					if var_416_32.name == "split_7" or not string.find(var_416_32.name, "split") then
						var_416_32.gameObject:SetActive(true)
					else
						var_416_32.gameObject:SetActive(false)
					end
				end
			end

			local var_416_33 = 0.001

			if var_416_30 <= arg_413_1.time_ and arg_413_1.time_ < var_416_30 + var_416_33 then
				local var_416_34 = (arg_413_1.time_ - var_416_30) / var_416_33
				local var_416_35 = Vector3.New(0, -2000, -180)

				var_416_29.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1070, var_416_35, var_416_34)
			end

			if arg_413_1.time_ >= var_416_30 + var_416_33 and arg_413_1.time_ < var_416_30 + var_416_33 + arg_416_0 then
				var_416_29.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_416_36 = arg_413_1.actors_["1039"].transform
			local var_416_37 = 0

			if var_416_37 < arg_413_1.time_ and arg_413_1.time_ <= var_416_37 + arg_416_0 then
				arg_413_1.var_.moveOldPos1039 = var_416_36.localPosition
				var_416_36.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1039", 7)

				local var_416_38 = var_416_36.childCount

				for iter_416_8 = 0, var_416_38 - 1 do
					local var_416_39 = var_416_36:GetChild(iter_416_8)

					if var_416_39.name == "split_1" or not string.find(var_416_39.name, "split") then
						var_416_39.gameObject:SetActive(true)
					else
						var_416_39.gameObject:SetActive(false)
					end
				end
			end

			local var_416_40 = 0.001

			if var_416_37 <= arg_413_1.time_ and arg_413_1.time_ < var_416_37 + var_416_40 then
				local var_416_41 = (arg_413_1.time_ - var_416_37) / var_416_40
				local var_416_42 = Vector3.New(0, -2000, -180)

				var_416_36.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1039, var_416_42, var_416_41)
			end

			if arg_413_1.time_ >= var_416_37 + var_416_40 and arg_413_1.time_ < var_416_37 + var_416_40 + arg_416_0 then
				var_416_36.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_416_43 = 0

			if var_416_43 < arg_413_1.time_ and arg_413_1.time_ <= var_416_43 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_44 = 2

			if var_416_43 <= arg_413_1.time_ and arg_413_1.time_ < var_416_43 + var_416_44 then
				local var_416_45 = (arg_413_1.time_ - var_416_43) / var_416_44
				local var_416_46 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_46.a = Mathf.Lerp(0, 1, var_416_45)
				arg_413_1.mask_.color = var_416_46
			end

			if arg_413_1.time_ >= var_416_43 + var_416_44 and arg_413_1.time_ < var_416_43 + var_416_44 + arg_416_0 then
				local var_416_47 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_47.a = 1
				arg_413_1.mask_.color = var_416_47
			end

			local var_416_48 = 2

			if var_416_48 < arg_413_1.time_ and arg_413_1.time_ <= var_416_48 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_49 = 2

			if var_416_48 <= arg_413_1.time_ and arg_413_1.time_ < var_416_48 + var_416_49 then
				local var_416_50 = (arg_413_1.time_ - var_416_48) / var_416_49
				local var_416_51 = Color.New(0.01886791, 0.01877891, 0.01877891)

				var_416_51.a = Mathf.Lerp(1, 0, var_416_50)
				arg_413_1.mask_.color = var_416_51
			end

			if arg_413_1.time_ >= var_416_48 + var_416_49 and arg_413_1.time_ < var_416_48 + var_416_49 + arg_416_0 then
				local var_416_52 = Color.New(0.01886791, 0.01877891, 0.01877891)
				local var_416_53 = 0

				arg_413_1.mask_.enabled = false
				var_416_52.a = var_416_53
				arg_413_1.mask_.color = var_416_52
			end

			local var_416_54 = arg_413_1.actors_["1070"]
			local var_416_55 = 2

			if var_416_55 < arg_413_1.time_ and arg_413_1.time_ <= var_416_55 + arg_416_0 then
				local var_416_56 = var_416_54:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_56 then
					arg_413_1.var_.alphaOldValue1070 = var_416_56.alpha
					arg_413_1.var_.characterEffect1070 = var_416_56
				end

				arg_413_1.var_.alphaOldValue1070 = 0
			end

			local var_416_57 = 0.566666666666667

			if var_416_55 <= arg_413_1.time_ and arg_413_1.time_ < var_416_55 + var_416_57 then
				local var_416_58 = (arg_413_1.time_ - var_416_55) / var_416_57
				local var_416_59 = Mathf.Lerp(arg_413_1.var_.alphaOldValue1070, 1, var_416_58)

				if arg_413_1.var_.characterEffect1070 then
					arg_413_1.var_.characterEffect1070.alpha = var_416_59
				end
			end

			if arg_413_1.time_ >= var_416_55 + var_416_57 and arg_413_1.time_ < var_416_55 + var_416_57 + arg_416_0 and arg_413_1.var_.characterEffect1070 then
				arg_413_1.var_.characterEffect1070.alpha = 1
			end

			local var_416_60 = arg_413_1.actors_["1070"]
			local var_416_61 = 0

			if var_416_61 < arg_413_1.time_ and arg_413_1.time_ <= var_416_61 + arg_416_0 then
				local var_416_62 = var_416_60:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_62 then
					arg_413_1.var_.alphaOldValue1070 = var_416_62.alpha
					arg_413_1.var_.characterEffect1070 = var_416_62
				end

				arg_413_1.var_.alphaOldValue1070 = 1
			end

			local var_416_63 = 0.0166666666666667

			if var_416_61 <= arg_413_1.time_ and arg_413_1.time_ < var_416_61 + var_416_63 then
				local var_416_64 = (arg_413_1.time_ - var_416_61) / var_416_63
				local var_416_65 = Mathf.Lerp(arg_413_1.var_.alphaOldValue1070, 0, var_416_64)

				if arg_413_1.var_.characterEffect1070 then
					arg_413_1.var_.characterEffect1070.alpha = var_416_65
				end
			end

			if arg_413_1.time_ >= var_416_61 + var_416_63 and arg_413_1.time_ < var_416_61 + var_416_63 + arg_416_0 and arg_413_1.var_.characterEffect1070 then
				arg_413_1.var_.characterEffect1070.alpha = 0
			end

			local var_416_66 = arg_413_1.actors_["1039"]
			local var_416_67 = 0

			if var_416_67 < arg_413_1.time_ and arg_413_1.time_ <= var_416_67 + arg_416_0 then
				local var_416_68 = var_416_66:GetComponentInChildren(typeof(CanvasGroup))

				if var_416_68 then
					arg_413_1.var_.alphaOldValue1039 = var_416_68.alpha
					arg_413_1.var_.characterEffect1039 = var_416_68
				end

				arg_413_1.var_.alphaOldValue1039 = 1
			end

			local var_416_69 = 0.0166666666666667

			if var_416_67 <= arg_413_1.time_ and arg_413_1.time_ < var_416_67 + var_416_69 then
				local var_416_70 = (arg_413_1.time_ - var_416_67) / var_416_69
				local var_416_71 = Mathf.Lerp(arg_413_1.var_.alphaOldValue1039, 0, var_416_70)

				if arg_413_1.var_.characterEffect1039 then
					arg_413_1.var_.characterEffect1039.alpha = var_416_71
				end
			end

			if arg_413_1.time_ >= var_416_67 + var_416_69 and arg_413_1.time_ < var_416_67 + var_416_69 + arg_416_0 and arg_413_1.var_.characterEffect1039 then
				arg_413_1.var_.characterEffect1039.alpha = 0
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_72 = 2
			local var_416_73 = 1.775

			if var_416_72 < arg_413_1.time_ and arg_413_1.time_ <= var_416_72 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				local var_416_74 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_74:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_75 = arg_413_1:GetWordFromCfg(910110102)
				local var_416_76 = arg_413_1:FormatText(var_416_75.content)

				arg_413_1.text_.text = var_416_76

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_77 = 71
				local var_416_78 = utf8.len(var_416_76)
				local var_416_79 = var_416_77 <= 0 and var_416_73 or var_416_73 * (var_416_78 / var_416_77)

				if var_416_79 > 0 and var_416_73 < var_416_79 then
					arg_413_1.talkMaxDuration = var_416_79
					var_416_72 = var_416_72 + 0.3

					if var_416_79 + var_416_72 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_79 + var_416_72
					end
				end

				arg_413_1.text_.text = var_416_76
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_80 = var_416_72 + 0.3
			local var_416_81 = math.max(var_416_73, arg_413_1.talkMaxDuration)

			if var_416_80 <= arg_413_1.time_ and arg_413_1.time_ < var_416_80 + var_416_81 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_80) / var_416_81

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_80 + var_416_81 and arg_413_1.time_ < var_416_80 + var_416_81 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end
	end,
	Play910110103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 910110103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play910110104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.45

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[318].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:GetWordFromCfg(910110103)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 18
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
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_8 and arg_419_1.time_ < var_422_0 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end
	end,
	Play910110104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 910110104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play910110105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1070"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and arg_423_1.var_.actorSpriteComps1070 == nil then
				arg_423_1.var_.actorSpriteComps1070 = var_426_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.actorSpriteComps1070 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_426_1 then
							local var_426_4 = Mathf.Lerp(iter_426_1.color.r, 0.5, var_426_3)

							iter_426_1.color = Color.New(var_426_4, var_426_4, var_426_4)
						end
					end
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and arg_423_1.var_.actorSpriteComps1070 then
				local var_426_5 = 0.5

				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = Color.New(var_426_5, var_426_5, var_426_5)
					end
				end

				arg_423_1.var_.actorSpriteComps1070 = nil
			end

			local var_426_6 = 0
			local var_426_7 = 0.8

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_8 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_9 = arg_423_1:GetWordFromCfg(910110104)
				local var_426_10 = arg_423_1:FormatText(var_426_9.content)

				arg_423_1.text_.text = var_426_10

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_11 = 32
				local var_426_12 = utf8.len(var_426_10)
				local var_426_13 = var_426_11 <= 0 and var_426_7 or var_426_7 * (var_426_12 / var_426_11)

				if var_426_13 > 0 and var_426_7 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_10
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_14 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_14 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_14

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_14 and arg_423_1.time_ < var_426_6 + var_426_14 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end
	end,
	Play910110105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 910110105
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play910110106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 1.4

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_3 = arg_427_1:GetWordFromCfg(910110105)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 56
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_8 and arg_427_1.time_ < var_430_0 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end
	end,
	Play910110106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 910110106
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play910110107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1070"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and arg_431_1.var_.actorSpriteComps1070 == nil then
				arg_431_1.var_.actorSpriteComps1070 = var_434_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.actorSpriteComps1070 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_434_1 then
							local var_434_4 = Mathf.Lerp(iter_434_1.color.r, 1, var_434_3)

							iter_434_1.color = Color.New(var_434_4, var_434_4, var_434_4)
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and arg_431_1.var_.actorSpriteComps1070 then
				local var_434_5 = 1

				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = Color.New(var_434_5, var_434_5, var_434_5)
					end
				end

				arg_431_1.var_.actorSpriteComps1070 = nil
			end

			local var_434_6 = 0
			local var_434_7 = 0.15

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[318].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_9 = arg_431_1:GetWordFromCfg(910110106)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 6
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
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end
	end,
	Play910110107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 910110107
		arg_435_1.duration_ = 0.199999999999

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"

			SetActive(arg_435_1.choicesGo_, true)

			for iter_436_0, iter_436_1 in ipairs(arg_435_1.choices_) do
				local var_436_0 = iter_436_0 <= 2

				SetActive(iter_436_1.go, var_436_0)
			end

			arg_435_1.choices_[1].txt.text = arg_435_1:FormatText(StoryChoiceCfg[296].name)
			arg_435_1.choices_[2].txt.text = arg_435_1:FormatText(StoryChoiceCfg[297].name)
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play910110108(arg_435_1)
			end

			if arg_437_0 == 2 then
				arg_435_0:Play910110108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1070"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and arg_435_1.var_.actorSpriteComps1070 == nil then
				arg_435_1.var_.actorSpriteComps1070 = var_438_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_2 = 0.2

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.actorSpriteComps1070 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_438_1 then
							local var_438_4 = Mathf.Lerp(iter_438_1.color.r, 0.5, var_438_3)

							iter_438_1.color = Color.New(var_438_4, var_438_4, var_438_4)
						end
					end
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and arg_435_1.var_.actorSpriteComps1070 then
				local var_438_5 = 0.5

				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = Color.New(var_438_5, var_438_5, var_438_5)
					end
				end

				arg_435_1.var_.actorSpriteComps1070 = nil
			end
		end
	end,
	Play910110108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 910110108
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play910110109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1070"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and arg_439_1.var_.actorSpriteComps1070 == nil then
				arg_439_1.var_.actorSpriteComps1070 = var_442_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_2 = 0.0166666666666667

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.actorSpriteComps1070 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_442_1 then
							local var_442_4 = Mathf.Lerp(iter_442_1.color.r, 1, var_442_3)

							iter_442_1.color = Color.New(var_442_4, var_442_4, var_442_4)
						end
					end
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and arg_439_1.var_.actorSpriteComps1070 then
				local var_442_5 = 1

				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_442_3 then
						iter_442_3.color = Color.New(var_442_5, var_442_5, var_442_5)
					end
				end

				arg_439_1.var_.actorSpriteComps1070 = nil
			end

			local var_442_6 = arg_439_1.actors_["1070"].transform
			local var_442_7 = 0

			if var_442_7 < arg_439_1.time_ and arg_439_1.time_ <= var_442_7 + arg_442_0 then
				arg_439_1.var_.moveOldPos1070 = var_442_6.localPosition
				var_442_6.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("1070", 3)

				local var_442_8 = var_442_6.childCount

				for iter_442_4 = 0, var_442_8 - 1 do
					local var_442_9 = var_442_6:GetChild(iter_442_4)

					if var_442_9.name == "split_1" or not string.find(var_442_9.name, "split") then
						var_442_9.gameObject:SetActive(true)
					else
						var_442_9.gameObject:SetActive(false)
					end
				end
			end

			local var_442_10 = 0.001

			if var_442_7 <= arg_439_1.time_ and arg_439_1.time_ < var_442_7 + var_442_10 then
				local var_442_11 = (arg_439_1.time_ - var_442_7) / var_442_10
				local var_442_12 = Vector3.New(0, -350, -180)

				var_442_6.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1070, var_442_12, var_442_11)
			end

			if arg_439_1.time_ >= var_442_7 + var_442_10 and arg_439_1.time_ < var_442_7 + var_442_10 + arg_442_0 then
				var_442_6.localPosition = Vector3.New(0, -350, -180)
			end

			local var_442_13 = 0
			local var_442_14 = 0.25

			if var_442_13 < arg_439_1.time_ and arg_439_1.time_ <= var_442_13 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_15 = arg_439_1:FormatText(StoryNameCfg[318].name)

				arg_439_1.leftNameTxt_.text = var_442_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_16 = arg_439_1:GetWordFromCfg(910110108)
				local var_442_17 = arg_439_1:FormatText(var_442_16.content)

				arg_439_1.text_.text = var_442_17

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_18 = 10
				local var_442_19 = utf8.len(var_442_17)
				local var_442_20 = var_442_18 <= 0 and var_442_14 or var_442_14 * (var_442_19 / var_442_18)

				if var_442_20 > 0 and var_442_14 < var_442_20 then
					arg_439_1.talkMaxDuration = var_442_20

					if var_442_20 + var_442_13 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_20 + var_442_13
					end
				end

				arg_439_1.text_.text = var_442_17
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_21 = math.max(var_442_14, arg_439_1.talkMaxDuration)

			if var_442_13 <= arg_439_1.time_ and arg_439_1.time_ < var_442_13 + var_442_21 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_13) / var_442_21

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_13 + var_442_21 and arg_439_1.time_ < var_442_13 + var_442_21 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end
	end,
	Play910110109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 910110109
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play910110110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1070"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and arg_443_1.var_.actorSpriteComps1070 == nil then
				arg_443_1.var_.actorSpriteComps1070 = var_446_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_2 = 0.2

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.actorSpriteComps1070 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_446_1 then
							local var_446_4 = Mathf.Lerp(iter_446_1.color.r, 0.5, var_446_3)

							iter_446_1.color = Color.New(var_446_4, var_446_4, var_446_4)
						end
					end
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and arg_443_1.var_.actorSpriteComps1070 then
				local var_446_5 = 0.5

				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = Color.New(var_446_5, var_446_5, var_446_5)
					end
				end

				arg_443_1.var_.actorSpriteComps1070 = nil
			end

			local var_446_6 = 0
			local var_446_7 = 0.975

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_8 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_9 = arg_443_1:GetWordFromCfg(910110109)
				local var_446_10 = arg_443_1:FormatText(var_446_9.content)

				arg_443_1.text_.text = var_446_10

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_11 = 39
				local var_446_12 = utf8.len(var_446_10)
				local var_446_13 = var_446_11 <= 0 and var_446_7 or var_446_7 * (var_446_12 / var_446_11)

				if var_446_13 > 0 and var_446_7 < var_446_13 then
					arg_443_1.talkMaxDuration = var_446_13

					if var_446_13 + var_446_6 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_13 + var_446_6
					end
				end

				arg_443_1.text_.text = var_446_10
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_14 = math.max(var_446_7, arg_443_1.talkMaxDuration)

			if var_446_6 <= arg_443_1.time_ and arg_443_1.time_ < var_446_6 + var_446_14 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_6) / var_446_14

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_6 + var_446_14 and arg_443_1.time_ < var_446_6 + var_446_14 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end
	end,
	Play910110110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 910110110
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play910110111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1070"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1070 = var_450_0.localPosition
				var_450_0.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("1070", 3)

				local var_450_2 = var_450_0.childCount

				for iter_450_0 = 0, var_450_2 - 1 do
					local var_450_3 = var_450_0:GetChild(iter_450_0)

					if var_450_3.name == "split_2" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_4 then
				local var_450_5 = (arg_447_1.time_ - var_450_1) / var_450_4
				local var_450_6 = Vector3.New(0, -350, -180)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1070, var_450_6, var_450_5)
			end

			if arg_447_1.time_ >= var_450_1 + var_450_4 and arg_447_1.time_ < var_450_1 + var_450_4 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_450_7 = arg_447_1.actors_["1070"]
			local var_450_8 = 0

			if var_450_8 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 and arg_447_1.var_.actorSpriteComps1070 == nil then
				arg_447_1.var_.actorSpriteComps1070 = var_450_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_9 = 0.0166666666666667

			if var_450_8 <= arg_447_1.time_ and arg_447_1.time_ < var_450_8 + var_450_9 then
				local var_450_10 = (arg_447_1.time_ - var_450_8) / var_450_9

				if arg_447_1.var_.actorSpriteComps1070 then
					for iter_450_1, iter_450_2 in pairs(arg_447_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_450_2 then
							local var_450_11 = Mathf.Lerp(iter_450_2.color.r, 1, var_450_10)

							iter_450_2.color = Color.New(var_450_11, var_450_11, var_450_11)
						end
					end
				end
			end

			if arg_447_1.time_ >= var_450_8 + var_450_9 and arg_447_1.time_ < var_450_8 + var_450_9 + arg_450_0 and arg_447_1.var_.actorSpriteComps1070 then
				local var_450_12 = 1

				for iter_450_3, iter_450_4 in pairs(arg_447_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_450_4 then
						iter_450_4.color = Color.New(var_450_12, var_450_12, var_450_12)
					end
				end

				arg_447_1.var_.actorSpriteComps1070 = nil
			end

			local var_450_13 = 0
			local var_450_14 = 0.15

			if var_450_13 < arg_447_1.time_ and arg_447_1.time_ <= var_450_13 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_15 = arg_447_1:FormatText(StoryNameCfg[318].name)

				arg_447_1.leftNameTxt_.text = var_450_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_16 = arg_447_1:GetWordFromCfg(910110110)
				local var_450_17 = arg_447_1:FormatText(var_450_16.content)

				arg_447_1.text_.text = var_450_17

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_18 = 6
				local var_450_19 = utf8.len(var_450_17)
				local var_450_20 = var_450_18 <= 0 and var_450_14 or var_450_14 * (var_450_19 / var_450_18)

				if var_450_20 > 0 and var_450_14 < var_450_20 then
					arg_447_1.talkMaxDuration = var_450_20

					if var_450_20 + var_450_13 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_20 + var_450_13
					end
				end

				arg_447_1.text_.text = var_450_17
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_21 = math.max(var_450_14, arg_447_1.talkMaxDuration)

			if var_450_13 <= arg_447_1.time_ and arg_447_1.time_ < var_450_13 + var_450_21 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_13) / var_450_21

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_13 + var_450_21 and arg_447_1.time_ < var_450_13 + var_450_21 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end
	end,
	Play910110111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 910110111
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play910110112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1070"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and arg_451_1.var_.actorSpriteComps1070 == nil then
				arg_451_1.var_.actorSpriteComps1070 = var_454_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_2 = 0.125

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.actorSpriteComps1070 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_454_1 then
							local var_454_4 = Mathf.Lerp(iter_454_1.color.r, 0.5, var_454_3)

							iter_454_1.color = Color.New(var_454_4, var_454_4, var_454_4)
						end
					end
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and arg_451_1.var_.actorSpriteComps1070 then
				local var_454_5 = 0.5

				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_454_3 then
						iter_454_3.color = Color.New(var_454_5, var_454_5, var_454_5)
					end
				end

				arg_451_1.var_.actorSpriteComps1070 = nil
			end

			local var_454_6 = 0
			local var_454_7 = 0.425

			if var_454_6 < arg_451_1.time_ and arg_451_1.time_ <= var_454_6 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_8 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_9 = arg_451_1:GetWordFromCfg(910110111)
				local var_454_10 = arg_451_1:FormatText(var_454_9.content)

				arg_451_1.text_.text = var_454_10

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_11 = 17
				local var_454_12 = utf8.len(var_454_10)
				local var_454_13 = var_454_11 <= 0 and var_454_7 or var_454_7 * (var_454_12 / var_454_11)

				if var_454_13 > 0 and var_454_7 < var_454_13 then
					arg_451_1.talkMaxDuration = var_454_13

					if var_454_13 + var_454_6 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_13 + var_454_6
					end
				end

				arg_451_1.text_.text = var_454_10
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_7, arg_451_1.talkMaxDuration)

			if var_454_6 <= arg_451_1.time_ and arg_451_1.time_ < var_454_6 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_6) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_6 + var_454_14 and arg_451_1.time_ < var_454_6 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end
	end,
	Play910110112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 910110112
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play910110113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1070"].transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPos1070 = var_458_0.localPosition
				var_458_0.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("1070", 3)

				local var_458_2 = var_458_0.childCount

				for iter_458_0 = 0, var_458_2 - 1 do
					local var_458_3 = var_458_0:GetChild(iter_458_0)

					if var_458_3.name == "split_6" or not string.find(var_458_3.name, "split") then
						var_458_3.gameObject:SetActive(true)
					else
						var_458_3.gameObject:SetActive(false)
					end
				end
			end

			local var_458_4 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_4 then
				local var_458_5 = (arg_455_1.time_ - var_458_1) / var_458_4
				local var_458_6 = Vector3.New(0, -350, -180)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1070, var_458_6, var_458_5)
			end

			if arg_455_1.time_ >= var_458_1 + var_458_4 and arg_455_1.time_ < var_458_1 + var_458_4 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_458_7 = arg_455_1.actors_["1070"]
			local var_458_8 = 0

			if var_458_8 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 and arg_455_1.var_.actorSpriteComps1070 == nil then
				arg_455_1.var_.actorSpriteComps1070 = var_458_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_9 = 0.0166666666666667

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_9 then
				local var_458_10 = (arg_455_1.time_ - var_458_8) / var_458_9

				if arg_455_1.var_.actorSpriteComps1070 then
					for iter_458_1, iter_458_2 in pairs(arg_455_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_458_2 then
							local var_458_11 = Mathf.Lerp(iter_458_2.color.r, 1, var_458_10)

							iter_458_2.color = Color.New(var_458_11, var_458_11, var_458_11)
						end
					end
				end
			end

			if arg_455_1.time_ >= var_458_8 + var_458_9 and arg_455_1.time_ < var_458_8 + var_458_9 + arg_458_0 and arg_455_1.var_.actorSpriteComps1070 then
				local var_458_12 = 1

				for iter_458_3, iter_458_4 in pairs(arg_455_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_458_4 then
						iter_458_4.color = Color.New(var_458_12, var_458_12, var_458_12)
					end
				end

				arg_455_1.var_.actorSpriteComps1070 = nil
			end

			local var_458_13 = 0
			local var_458_14 = 0.725

			if var_458_13 < arg_455_1.time_ and arg_455_1.time_ <= var_458_13 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_15 = arg_455_1:FormatText(StoryNameCfg[318].name)

				arg_455_1.leftNameTxt_.text = var_458_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_16 = arg_455_1:GetWordFromCfg(910110112)
				local var_458_17 = arg_455_1:FormatText(var_458_16.content)

				arg_455_1.text_.text = var_458_17

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_18 = 29
				local var_458_19 = utf8.len(var_458_17)
				local var_458_20 = var_458_18 <= 0 and var_458_14 or var_458_14 * (var_458_19 / var_458_18)

				if var_458_20 > 0 and var_458_14 < var_458_20 then
					arg_455_1.talkMaxDuration = var_458_20

					if var_458_20 + var_458_13 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_20 + var_458_13
					end
				end

				arg_455_1.text_.text = var_458_17
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_21 = math.max(var_458_14, arg_455_1.talkMaxDuration)

			if var_458_13 <= arg_455_1.time_ and arg_455_1.time_ < var_458_13 + var_458_21 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_13) / var_458_21

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_13 + var_458_21 and arg_455_1.time_ < var_458_13 + var_458_21 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end
	end,
	Play910110113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 910110113
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play910110114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["1070"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and arg_459_1.var_.actorSpriteComps1070 == nil then
				arg_459_1.var_.actorSpriteComps1070 = var_462_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_2 = 0.2

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.actorSpriteComps1070 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_462_1 then
							local var_462_4 = Mathf.Lerp(iter_462_1.color.r, 0.5, var_462_3)

							iter_462_1.color = Color.New(var_462_4, var_462_4, var_462_4)
						end
					end
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and arg_459_1.var_.actorSpriteComps1070 then
				local var_462_5 = 0.5

				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_462_3 then
						iter_462_3.color = Color.New(var_462_5, var_462_5, var_462_5)
					end
				end

				arg_459_1.var_.actorSpriteComps1070 = nil
			end

			local var_462_6 = 0
			local var_462_7 = 0.75

			if var_462_6 < arg_459_1.time_ and arg_459_1.time_ <= var_462_6 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_8 = arg_459_1:FormatText(StoryNameCfg[7].name)

				arg_459_1.leftNameTxt_.text = var_462_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_9 = arg_459_1:GetWordFromCfg(910110113)
				local var_462_10 = arg_459_1:FormatText(var_462_9.content)

				arg_459_1.text_.text = var_462_10

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_11 = 30
				local var_462_12 = utf8.len(var_462_10)
				local var_462_13 = var_462_11 <= 0 and var_462_7 or var_462_7 * (var_462_12 / var_462_11)

				if var_462_13 > 0 and var_462_7 < var_462_13 then
					arg_459_1.talkMaxDuration = var_462_13

					if var_462_13 + var_462_6 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_13 + var_462_6
					end
				end

				arg_459_1.text_.text = var_462_10
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_14 = math.max(var_462_7, arg_459_1.talkMaxDuration)

			if var_462_6 <= arg_459_1.time_ and arg_459_1.time_ < var_462_6 + var_462_14 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_6) / var_462_14

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_6 + var_462_14 and arg_459_1.time_ < var_462_6 + var_462_14 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end
	end,
	Play910110114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 910110114
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play910110115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 1.7

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[7].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_3 = arg_463_1:GetWordFromCfg(910110114)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 68
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_8 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_8 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_8

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_8 and arg_463_1.time_ < var_466_0 + var_466_8 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end
	end,
	Play910110115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 910110115
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play910110116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["1070"].transform
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.var_.moveOldPos1070 = var_470_0.localPosition
				var_470_0.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("1070", 3)

				local var_470_2 = var_470_0.childCount

				for iter_470_0 = 0, var_470_2 - 1 do
					local var_470_3 = var_470_0:GetChild(iter_470_0)

					if var_470_3.name == "split_8" or not string.find(var_470_3.name, "split") then
						var_470_3.gameObject:SetActive(true)
					else
						var_470_3.gameObject:SetActive(false)
					end
				end
			end

			local var_470_4 = 0.001

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_4 then
				local var_470_5 = (arg_467_1.time_ - var_470_1) / var_470_4
				local var_470_6 = Vector3.New(0, -350, -180)

				var_470_0.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1070, var_470_6, var_470_5)
			end

			if arg_467_1.time_ >= var_470_1 + var_470_4 and arg_467_1.time_ < var_470_1 + var_470_4 + arg_470_0 then
				var_470_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_470_7 = 0
			local var_470_8 = 1.3

			if var_470_7 < arg_467_1.time_ and arg_467_1.time_ <= var_470_7 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_9 = arg_467_1:FormatText(StoryNameCfg[318].name)

				arg_467_1.leftNameTxt_.text = var_470_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_10 = arg_467_1:GetWordFromCfg(910110115)
				local var_470_11 = arg_467_1:FormatText(var_470_10.content)

				arg_467_1.text_.text = var_470_11

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_12 = 52
				local var_470_13 = utf8.len(var_470_11)
				local var_470_14 = var_470_12 <= 0 and var_470_8 or var_470_8 * (var_470_13 / var_470_12)

				if var_470_14 > 0 and var_470_8 < var_470_14 then
					arg_467_1.talkMaxDuration = var_470_14

					if var_470_14 + var_470_7 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_14 + var_470_7
					end
				end

				arg_467_1.text_.text = var_470_11
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_15 = math.max(var_470_8, arg_467_1.talkMaxDuration)

			if var_470_7 <= arg_467_1.time_ and arg_467_1.time_ < var_470_7 + var_470_15 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_7) / var_470_15

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_7 + var_470_15 and arg_467_1.time_ < var_470_7 + var_470_15 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end
	end,
	Play910110116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 910110116
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play910110117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1070"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and arg_471_1.var_.actorSpriteComps1070 == nil then
				arg_471_1.var_.actorSpriteComps1070 = var_474_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_2 = 0.2

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.actorSpriteComps1070 then
					for iter_474_0, iter_474_1 in pairs(arg_471_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_474_1 then
							local var_474_4 = Mathf.Lerp(iter_474_1.color.r, 0.5, var_474_3)

							iter_474_1.color = Color.New(var_474_4, var_474_4, var_474_4)
						end
					end
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and arg_471_1.var_.actorSpriteComps1070 then
				local var_474_5 = 0.5

				for iter_474_2, iter_474_3 in pairs(arg_471_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_474_3 then
						iter_474_3.color = Color.New(var_474_5, var_474_5, var_474_5)
					end
				end

				arg_471_1.var_.actorSpriteComps1070 = nil
			end

			local var_474_6 = 0
			local var_474_7 = 1.35

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_8 = arg_471_1:FormatText(StoryNameCfg[7].name)

				arg_471_1.leftNameTxt_.text = var_474_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_9 = arg_471_1:GetWordFromCfg(910110116)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_11 = 54
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
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_14 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_14 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_14

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_14 and arg_471_1.time_ < var_474_6 + var_474_14 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end
	end,
	Play910110117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 910110117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play910110118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.05

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[355].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_3 = arg_475_1:GetWordFromCfg(910110117)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 2
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_8 and arg_475_1.time_ < var_478_0 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end
	end,
	Play910110118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 910110118
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play910110119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.325

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[355].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_3 = arg_479_1:GetWordFromCfg(910110118)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 13
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
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_8 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_8 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_8

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_8 and arg_479_1.time_ < var_482_0 + var_482_8 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end
	end,
	Play910110119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 910110119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play910110120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = arg_483_1.actors_["1070"].transform
			local var_486_1 = 0

			if var_486_1 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.var_.moveOldPos1070 = var_486_0.localPosition
				var_486_0.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("1070", 3)

				local var_486_2 = var_486_0.childCount

				for iter_486_0 = 0, var_486_2 - 1 do
					local var_486_3 = var_486_0:GetChild(iter_486_0)

					if var_486_3.name == "split_1" or not string.find(var_486_3.name, "split") then
						var_486_3.gameObject:SetActive(true)
					else
						var_486_3.gameObject:SetActive(false)
					end
				end
			end

			local var_486_4 = 0.001

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_4 then
				local var_486_5 = (arg_483_1.time_ - var_486_1) / var_486_4
				local var_486_6 = Vector3.New(0, -350, -180)

				var_486_0.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1070, var_486_6, var_486_5)
			end

			if arg_483_1.time_ >= var_486_1 + var_486_4 and arg_483_1.time_ < var_486_1 + var_486_4 + arg_486_0 then
				var_486_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_486_7 = arg_483_1.actors_["1070"]
			local var_486_8 = 0

			if var_486_8 < arg_483_1.time_ and arg_483_1.time_ <= var_486_8 + arg_486_0 and arg_483_1.var_.actorSpriteComps1070 == nil then
				arg_483_1.var_.actorSpriteComps1070 = var_486_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_9 = 0.0166666666666667

			if var_486_8 <= arg_483_1.time_ and arg_483_1.time_ < var_486_8 + var_486_9 then
				local var_486_10 = (arg_483_1.time_ - var_486_8) / var_486_9

				if arg_483_1.var_.actorSpriteComps1070 then
					for iter_486_1, iter_486_2 in pairs(arg_483_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_486_2 then
							local var_486_11 = Mathf.Lerp(iter_486_2.color.r, 1, var_486_10)

							iter_486_2.color = Color.New(var_486_11, var_486_11, var_486_11)
						end
					end
				end
			end

			if arg_483_1.time_ >= var_486_8 + var_486_9 and arg_483_1.time_ < var_486_8 + var_486_9 + arg_486_0 and arg_483_1.var_.actorSpriteComps1070 then
				local var_486_12 = 1

				for iter_486_3, iter_486_4 in pairs(arg_483_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_486_4 then
						iter_486_4.color = Color.New(var_486_12, var_486_12, var_486_12)
					end
				end

				arg_483_1.var_.actorSpriteComps1070 = nil
			end

			local var_486_13 = 0
			local var_486_14 = 0.15

			if var_486_13 < arg_483_1.time_ and arg_483_1.time_ <= var_486_13 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_15 = arg_483_1:FormatText(StoryNameCfg[318].name)

				arg_483_1.leftNameTxt_.text = var_486_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_16 = arg_483_1:GetWordFromCfg(910110119)
				local var_486_17 = arg_483_1:FormatText(var_486_16.content)

				arg_483_1.text_.text = var_486_17

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_18 = 6
				local var_486_19 = utf8.len(var_486_17)
				local var_486_20 = var_486_18 <= 0 and var_486_14 or var_486_14 * (var_486_19 / var_486_18)

				if var_486_20 > 0 and var_486_14 < var_486_20 then
					arg_483_1.talkMaxDuration = var_486_20

					if var_486_20 + var_486_13 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_20 + var_486_13
					end
				end

				arg_483_1.text_.text = var_486_17
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_21 = math.max(var_486_14, arg_483_1.talkMaxDuration)

			if var_486_13 <= arg_483_1.time_ and arg_483_1.time_ < var_486_13 + var_486_21 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_13) / var_486_21

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_13 + var_486_21 and arg_483_1.time_ < var_486_13 + var_486_21 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end
	end,
	Play910110120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 910110120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play910110121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1070"]
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 and arg_487_1.var_.actorSpriteComps1070 == nil then
				arg_487_1.var_.actorSpriteComps1070 = var_490_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_2 = 0.2

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2

				if arg_487_1.var_.actorSpriteComps1070 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_490_1 then
							local var_490_4 = Mathf.Lerp(iter_490_1.color.r, 0.5, var_490_3)

							iter_490_1.color = Color.New(var_490_4, var_490_4, var_490_4)
						end
					end
				end
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 and arg_487_1.var_.actorSpriteComps1070 then
				local var_490_5 = 0.5

				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_490_3 then
						iter_490_3.color = Color.New(var_490_5, var_490_5, var_490_5)
					end
				end

				arg_487_1.var_.actorSpriteComps1070 = nil
			end

			local var_490_6 = 0
			local var_490_7 = 0.4

			if var_490_6 < arg_487_1.time_ and arg_487_1.time_ <= var_490_6 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_8 = arg_487_1:FormatText(StoryNameCfg[355].name)

				arg_487_1.leftNameTxt_.text = var_490_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_9 = arg_487_1:GetWordFromCfg(910110120)
				local var_490_10 = arg_487_1:FormatText(var_490_9.content)

				arg_487_1.text_.text = var_490_10

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_11 = 16
				local var_490_12 = utf8.len(var_490_10)
				local var_490_13 = var_490_11 <= 0 and var_490_7 or var_490_7 * (var_490_12 / var_490_11)

				if var_490_13 > 0 and var_490_7 < var_490_13 then
					arg_487_1.talkMaxDuration = var_490_13

					if var_490_13 + var_490_6 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_13 + var_490_6
					end
				end

				arg_487_1.text_.text = var_490_10
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_14 = math.max(var_490_7, arg_487_1.talkMaxDuration)

			if var_490_6 <= arg_487_1.time_ and arg_487_1.time_ < var_490_6 + var_490_14 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_6) / var_490_14

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_6 + var_490_14 and arg_487_1.time_ < var_490_6 + var_490_14 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end
	end,
	Play910110121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 910110121
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play910110122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1066"].transform
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.var_.moveOldPos1066 = var_494_0.localPosition
				var_494_0.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1066", 3)

				local var_494_2 = var_494_0.childCount

				for iter_494_0 = 0, var_494_2 - 1 do
					local var_494_3 = var_494_0:GetChild(iter_494_0)

					if var_494_3.name == "split_1" or not string.find(var_494_3.name, "split") then
						var_494_3.gameObject:SetActive(true)
					else
						var_494_3.gameObject:SetActive(false)
					end
				end
			end

			local var_494_4 = 0.001

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_4 then
				local var_494_5 = (arg_491_1.time_ - var_494_1) / var_494_4
				local var_494_6 = Vector3.New(0, -350, -180)

				var_494_0.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1066, var_494_6, var_494_5)
			end

			if arg_491_1.time_ >= var_494_1 + var_494_4 and arg_491_1.time_ < var_494_1 + var_494_4 + arg_494_0 then
				var_494_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_494_7 = arg_491_1.actors_["1066"]
			local var_494_8 = 0

			if var_494_8 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				local var_494_9 = var_494_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_494_9 then
					arg_491_1.var_.alphaOldValue1066 = var_494_9.alpha
					arg_491_1.var_.characterEffect1066 = var_494_9
				end

				arg_491_1.var_.alphaOldValue1066 = 0
			end

			local var_494_10 = 0.5

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_10 then
				local var_494_11 = (arg_491_1.time_ - var_494_8) / var_494_10
				local var_494_12 = Mathf.Lerp(arg_491_1.var_.alphaOldValue1066, 1, var_494_11)

				if arg_491_1.var_.characterEffect1066 then
					arg_491_1.var_.characterEffect1066.alpha = var_494_12
				end
			end

			if arg_491_1.time_ >= var_494_8 + var_494_10 and arg_491_1.time_ < var_494_8 + var_494_10 + arg_494_0 and arg_491_1.var_.characterEffect1066 then
				arg_491_1.var_.characterEffect1066.alpha = 1
			end

			local var_494_13 = arg_491_1.actors_["1066"]
			local var_494_14 = 0

			if var_494_14 < arg_491_1.time_ and arg_491_1.time_ <= var_494_14 + arg_494_0 and arg_491_1.var_.actorSpriteComps1066 == nil then
				arg_491_1.var_.actorSpriteComps1066 = var_494_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_15 = 0.0166666666666667

			if var_494_14 <= arg_491_1.time_ and arg_491_1.time_ < var_494_14 + var_494_15 then
				local var_494_16 = (arg_491_1.time_ - var_494_14) / var_494_15

				if arg_491_1.var_.actorSpriteComps1066 then
					for iter_494_1, iter_494_2 in pairs(arg_491_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_494_2 then
							local var_494_17 = Mathf.Lerp(iter_494_2.color.r, 1, var_494_16)

							iter_494_2.color = Color.New(var_494_17, var_494_17, var_494_17)
						end
					end
				end
			end

			if arg_491_1.time_ >= var_494_14 + var_494_15 and arg_491_1.time_ < var_494_14 + var_494_15 + arg_494_0 and arg_491_1.var_.actorSpriteComps1066 then
				local var_494_18 = 1

				for iter_494_3, iter_494_4 in pairs(arg_491_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_494_4 then
						iter_494_4.color = Color.New(var_494_18, var_494_18, var_494_18)
					end
				end

				arg_491_1.var_.actorSpriteComps1066 = nil
			end

			local var_494_19 = 0
			local var_494_20 = 0.05

			if var_494_19 < arg_491_1.time_ and arg_491_1.time_ <= var_494_19 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_21 = arg_491_1:FormatText(StoryNameCfg[32].name)

				arg_491_1.leftNameTxt_.text = var_494_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_22 = arg_491_1:GetWordFromCfg(910110121)
				local var_494_23 = arg_491_1:FormatText(var_494_22.content)

				arg_491_1.text_.text = var_494_23

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_24 = 2
				local var_494_25 = utf8.len(var_494_23)
				local var_494_26 = var_494_24 <= 0 and var_494_20 or var_494_20 * (var_494_25 / var_494_24)

				if var_494_26 > 0 and var_494_20 < var_494_26 then
					arg_491_1.talkMaxDuration = var_494_26

					if var_494_26 + var_494_19 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_26 + var_494_19
					end
				end

				arg_491_1.text_.text = var_494_23
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_27 = math.max(var_494_20, arg_491_1.talkMaxDuration)

			if var_494_19 <= arg_491_1.time_ and arg_491_1.time_ < var_494_19 + var_494_27 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_19) / var_494_27

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_19 + var_494_27 and arg_491_1.time_ < var_494_19 + var_494_27 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end
	end,
	Play910110122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 910110122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play910110123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1066"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and arg_495_1.var_.actorSpriteComps1066 == nil then
				arg_495_1.var_.actorSpriteComps1066 = var_498_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_2 = 0.2

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.actorSpriteComps1066 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_498_1 then
							local var_498_4 = Mathf.Lerp(iter_498_1.color.r, 0.5, var_498_3)

							iter_498_1.color = Color.New(var_498_4, var_498_4, var_498_4)
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and arg_495_1.var_.actorSpriteComps1066 then
				local var_498_5 = 0.5

				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = Color.New(var_498_5, var_498_5, var_498_5)
					end
				end

				arg_495_1.var_.actorSpriteComps1066 = nil
			end

			local var_498_6 = 0
			local var_498_7 = 0.425

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_8 = arg_495_1:FormatText(StoryNameCfg[7].name)

				arg_495_1.leftNameTxt_.text = var_498_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_9 = arg_495_1:GetWordFromCfg(910110122)
				local var_498_10 = arg_495_1:FormatText(var_498_9.content)

				arg_495_1.text_.text = var_498_10

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_11 = 17
				local var_498_12 = utf8.len(var_498_10)
				local var_498_13 = var_498_11 <= 0 and var_498_7 or var_498_7 * (var_498_12 / var_498_11)

				if var_498_13 > 0 and var_498_7 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_10
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_14 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_14 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_6) / var_498_14

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_6 + var_498_14 and arg_495_1.time_ < var_498_6 + var_498_14 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end
	end,
	Play910110123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 910110123
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play910110124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1066"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos1066 = var_502_0.localPosition
				var_502_0.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("1066", 3)

				local var_502_2 = var_502_0.childCount

				for iter_502_0 = 0, var_502_2 - 1 do
					local var_502_3 = var_502_0:GetChild(iter_502_0)

					if var_502_3.name == "split_1" or not string.find(var_502_3.name, "split") then
						var_502_3.gameObject:SetActive(true)
					else
						var_502_3.gameObject:SetActive(false)
					end
				end
			end

			local var_502_4 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_4 then
				local var_502_5 = (arg_499_1.time_ - var_502_1) / var_502_4
				local var_502_6 = Vector3.New(0, -350, -180)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1066, var_502_6, var_502_5)
			end

			if arg_499_1.time_ >= var_502_1 + var_502_4 and arg_499_1.time_ < var_502_1 + var_502_4 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_502_7 = arg_499_1.actors_["1066"]
			local var_502_8 = 0

			if var_502_8 < arg_499_1.time_ and arg_499_1.time_ <= var_502_8 + arg_502_0 and arg_499_1.var_.actorSpriteComps1066 == nil then
				arg_499_1.var_.actorSpriteComps1066 = var_502_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_9 = 0.0166666666666667

			if var_502_8 <= arg_499_1.time_ and arg_499_1.time_ < var_502_8 + var_502_9 then
				local var_502_10 = (arg_499_1.time_ - var_502_8) / var_502_9

				if arg_499_1.var_.actorSpriteComps1066 then
					for iter_502_1, iter_502_2 in pairs(arg_499_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_502_2 then
							local var_502_11 = Mathf.Lerp(iter_502_2.color.r, 1, var_502_10)

							iter_502_2.color = Color.New(var_502_11, var_502_11, var_502_11)
						end
					end
				end
			end

			if arg_499_1.time_ >= var_502_8 + var_502_9 and arg_499_1.time_ < var_502_8 + var_502_9 + arg_502_0 and arg_499_1.var_.actorSpriteComps1066 then
				local var_502_12 = 1

				for iter_502_3, iter_502_4 in pairs(arg_499_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_502_4 then
						iter_502_4.color = Color.New(var_502_12, var_502_12, var_502_12)
					end
				end

				arg_499_1.var_.actorSpriteComps1066 = nil
			end

			local var_502_13 = 0
			local var_502_14 = 0.1

			if var_502_13 < arg_499_1.time_ and arg_499_1.time_ <= var_502_13 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_15 = arg_499_1:FormatText(StoryNameCfg[32].name)

				arg_499_1.leftNameTxt_.text = var_502_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_16 = arg_499_1:GetWordFromCfg(910110123)
				local var_502_17 = arg_499_1:FormatText(var_502_16.content)

				arg_499_1.text_.text = var_502_17

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_18 = 4
				local var_502_19 = utf8.len(var_502_17)
				local var_502_20 = var_502_18 <= 0 and var_502_14 or var_502_14 * (var_502_19 / var_502_18)

				if var_502_20 > 0 and var_502_14 < var_502_20 then
					arg_499_1.talkMaxDuration = var_502_20

					if var_502_20 + var_502_13 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_20 + var_502_13
					end
				end

				arg_499_1.text_.text = var_502_17
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_21 = math.max(var_502_14, arg_499_1.talkMaxDuration)

			if var_502_13 <= arg_499_1.time_ and arg_499_1.time_ < var_502_13 + var_502_21 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_13) / var_502_21

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_13 + var_502_21 and arg_499_1.time_ < var_502_13 + var_502_21 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end
	end,
	Play910110124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 910110124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play910110125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.55

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[32].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_3 = arg_503_1:GetWordFromCfg(910110124)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 22
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_8 and arg_503_1.time_ < var_506_0 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end
	end,
	Play910110125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 910110125
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play910110126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.175

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[32].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:GetWordFromCfg(910110125)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 7
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
	Play910110126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 910110126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play910110127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1066"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and arg_511_1.var_.actorSpriteComps1066 == nil then
				arg_511_1.var_.actorSpriteComps1066 = var_514_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_2 = 0.2

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.actorSpriteComps1066 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_514_1 then
							local var_514_4 = Mathf.Lerp(iter_514_1.color.r, 0.5, var_514_3)

							iter_514_1.color = Color.New(var_514_4, var_514_4, var_514_4)
						end
					end
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and arg_511_1.var_.actorSpriteComps1066 then
				local var_514_5 = 0.5

				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = Color.New(var_514_5, var_514_5, var_514_5)
					end
				end

				arg_511_1.var_.actorSpriteComps1066 = nil
			end

			local var_514_6 = 0
			local var_514_7 = 0.675

			if var_514_6 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_8 = arg_511_1:FormatText(StoryNameCfg[7].name)

				arg_511_1.leftNameTxt_.text = var_514_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_9 = arg_511_1:GetWordFromCfg(910110126)
				local var_514_10 = arg_511_1:FormatText(var_514_9.content)

				arg_511_1.text_.text = var_514_10

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_11 = 27
				local var_514_12 = utf8.len(var_514_10)
				local var_514_13 = var_514_11 <= 0 and var_514_7 or var_514_7 * (var_514_12 / var_514_11)

				if var_514_13 > 0 and var_514_7 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_6
					end
				end

				arg_511_1.text_.text = var_514_10
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_14 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_14 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_14

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_14 and arg_511_1.time_ < var_514_6 + var_514_14 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end
	end,
	Play910110127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 910110127
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play910110128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 1.35

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[355].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_3 = arg_515_1:GetWordFromCfg(910110127)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 54
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_8 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_8 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_8

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_8 and arg_515_1.time_ < var_518_0 + var_518_8 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end
	end,
	Play910110128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 910110128
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play910110129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 1.375

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[355].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_3 = arg_519_1:GetWordFromCfg(910110128)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 55
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
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end
	end,
	Play910110129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 910110129
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play910110130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1070"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos1070 = var_526_0.localPosition
				var_526_0.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("1070", 3)

				local var_526_2 = var_526_0.childCount

				for iter_526_0 = 0, var_526_2 - 1 do
					local var_526_3 = var_526_0:GetChild(iter_526_0)

					if var_526_3.name == "split_9" or not string.find(var_526_3.name, "split") then
						var_526_3.gameObject:SetActive(true)
					else
						var_526_3.gameObject:SetActive(false)
					end
				end
			end

			local var_526_4 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_4 then
				local var_526_5 = (arg_523_1.time_ - var_526_1) / var_526_4
				local var_526_6 = Vector3.New(0, -350, -180)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1070, var_526_6, var_526_5)
			end

			if arg_523_1.time_ >= var_526_1 + var_526_4 and arg_523_1.time_ < var_526_1 + var_526_4 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_526_7 = arg_523_1.actors_["1070"]
			local var_526_8 = 0

			if var_526_8 < arg_523_1.time_ and arg_523_1.time_ <= var_526_8 + arg_526_0 and arg_523_1.var_.actorSpriteComps1070 == nil then
				arg_523_1.var_.actorSpriteComps1070 = var_526_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_9 = 0.0166666666666667

			if var_526_8 <= arg_523_1.time_ and arg_523_1.time_ < var_526_8 + var_526_9 then
				local var_526_10 = (arg_523_1.time_ - var_526_8) / var_526_9

				if arg_523_1.var_.actorSpriteComps1070 then
					for iter_526_1, iter_526_2 in pairs(arg_523_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_526_2 then
							local var_526_11 = Mathf.Lerp(iter_526_2.color.r, 1, var_526_10)

							iter_526_2.color = Color.New(var_526_11, var_526_11, var_526_11)
						end
					end
				end
			end

			if arg_523_1.time_ >= var_526_8 + var_526_9 and arg_523_1.time_ < var_526_8 + var_526_9 + arg_526_0 and arg_523_1.var_.actorSpriteComps1070 then
				local var_526_12 = 1

				for iter_526_3, iter_526_4 in pairs(arg_523_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_526_4 then
						iter_526_4.color = Color.New(var_526_12, var_526_12, var_526_12)
					end
				end

				arg_523_1.var_.actorSpriteComps1070 = nil
			end

			local var_526_13 = 0
			local var_526_14 = 0.125

			if var_526_13 < arg_523_1.time_ and arg_523_1.time_ <= var_526_13 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_15 = arg_523_1:FormatText(StoryNameCfg[318].name)

				arg_523_1.leftNameTxt_.text = var_526_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_16 = arg_523_1:GetWordFromCfg(910110129)
				local var_526_17 = arg_523_1:FormatText(var_526_16.content)

				arg_523_1.text_.text = var_526_17

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_18 = 5
				local var_526_19 = utf8.len(var_526_17)
				local var_526_20 = var_526_18 <= 0 and var_526_14 or var_526_14 * (var_526_19 / var_526_18)

				if var_526_20 > 0 and var_526_14 < var_526_20 then
					arg_523_1.talkMaxDuration = var_526_20

					if var_526_20 + var_526_13 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_20 + var_526_13
					end
				end

				arg_523_1.text_.text = var_526_17
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_21 = math.max(var_526_14, arg_523_1.talkMaxDuration)

			if var_526_13 <= arg_523_1.time_ and arg_523_1.time_ < var_526_13 + var_526_21 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_13) / var_526_21

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_13 + var_526_21 and arg_523_1.time_ < var_526_13 + var_526_21 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end
	end,
	Play910110130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 910110130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play910110131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1070"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and arg_527_1.var_.actorSpriteComps1070 == nil then
				arg_527_1.var_.actorSpriteComps1070 = var_530_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_2 = 0.2

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.actorSpriteComps1070 then
					for iter_530_0, iter_530_1 in pairs(arg_527_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_530_1 then
							local var_530_4 = Mathf.Lerp(iter_530_1.color.r, 0.5, var_530_3)

							iter_530_1.color = Color.New(var_530_4, var_530_4, var_530_4)
						end
					end
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and arg_527_1.var_.actorSpriteComps1070 then
				local var_530_5 = 0.5

				for iter_530_2, iter_530_3 in pairs(arg_527_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_530_3 then
						iter_530_3.color = Color.New(var_530_5, var_530_5, var_530_5)
					end
				end

				arg_527_1.var_.actorSpriteComps1070 = nil
			end

			local var_530_6 = 0
			local var_530_7 = 0.4

			if var_530_6 < arg_527_1.time_ and arg_527_1.time_ <= var_530_6 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_8 = arg_527_1:FormatText(StoryNameCfg[7].name)

				arg_527_1.leftNameTxt_.text = var_530_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_9 = arg_527_1:GetWordFromCfg(910110130)
				local var_530_10 = arg_527_1:FormatText(var_530_9.content)

				arg_527_1.text_.text = var_530_10

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_11 = 16
				local var_530_12 = utf8.len(var_530_10)
				local var_530_13 = var_530_11 <= 0 and var_530_7 or var_530_7 * (var_530_12 / var_530_11)

				if var_530_13 > 0 and var_530_7 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_6 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_6
					end
				end

				arg_527_1.text_.text = var_530_10
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_14 = math.max(var_530_7, arg_527_1.talkMaxDuration)

			if var_530_6 <= arg_527_1.time_ and arg_527_1.time_ < var_530_6 + var_530_14 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_6) / var_530_14

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_6 + var_530_14 and arg_527_1.time_ < var_530_6 + var_530_14 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end
	end,
	Play910110131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 910110131
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play910110132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.275

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[355].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_3 = arg_531_1:GetWordFromCfg(910110131)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 11
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_8 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_8 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_8

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_8 and arg_531_1.time_ < var_534_0 + var_534_8 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end
	end,
	Play910110132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 910110132
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play910110133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1070"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos1070 = var_538_0.localPosition
				var_538_0.localScale = Vector3.New(1, 1, 1)

				arg_535_1:CheckSpriteTmpPos("1070", 3)

				local var_538_2 = var_538_0.childCount

				for iter_538_0 = 0, var_538_2 - 1 do
					local var_538_3 = var_538_0:GetChild(iter_538_0)

					if var_538_3.name == "split_1" or not string.find(var_538_3.name, "split") then
						var_538_3.gameObject:SetActive(true)
					else
						var_538_3.gameObject:SetActive(false)
					end
				end
			end

			local var_538_4 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_4 then
				local var_538_5 = (arg_535_1.time_ - var_538_1) / var_538_4
				local var_538_6 = Vector3.New(0, -350, -180)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1070, var_538_6, var_538_5)
			end

			if arg_535_1.time_ >= var_538_1 + var_538_4 and arg_535_1.time_ < var_538_1 + var_538_4 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_538_7 = arg_535_1.actors_["1070"]
			local var_538_8 = 0

			if var_538_8 < arg_535_1.time_ and arg_535_1.time_ <= var_538_8 + arg_538_0 and arg_535_1.var_.actorSpriteComps1070 == nil then
				arg_535_1.var_.actorSpriteComps1070 = var_538_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_9 = 0.0166666666666667

			if var_538_8 <= arg_535_1.time_ and arg_535_1.time_ < var_538_8 + var_538_9 then
				local var_538_10 = (arg_535_1.time_ - var_538_8) / var_538_9

				if arg_535_1.var_.actorSpriteComps1070 then
					for iter_538_1, iter_538_2 in pairs(arg_535_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_538_2 then
							local var_538_11 = Mathf.Lerp(iter_538_2.color.r, 1, var_538_10)

							iter_538_2.color = Color.New(var_538_11, var_538_11, var_538_11)
						end
					end
				end
			end

			if arg_535_1.time_ >= var_538_8 + var_538_9 and arg_535_1.time_ < var_538_8 + var_538_9 + arg_538_0 and arg_535_1.var_.actorSpriteComps1070 then
				local var_538_12 = 1

				for iter_538_3, iter_538_4 in pairs(arg_535_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_538_4 then
						iter_538_4.color = Color.New(var_538_12, var_538_12, var_538_12)
					end
				end

				arg_535_1.var_.actorSpriteComps1070 = nil
			end

			local var_538_13 = 0
			local var_538_14 = 0.3

			if var_538_13 < arg_535_1.time_ and arg_535_1.time_ <= var_538_13 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_15 = arg_535_1:FormatText(StoryNameCfg[318].name)

				arg_535_1.leftNameTxt_.text = var_538_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_16 = arg_535_1:GetWordFromCfg(910110132)
				local var_538_17 = arg_535_1:FormatText(var_538_16.content)

				arg_535_1.text_.text = var_538_17

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_18 = 12
				local var_538_19 = utf8.len(var_538_17)
				local var_538_20 = var_538_18 <= 0 and var_538_14 or var_538_14 * (var_538_19 / var_538_18)

				if var_538_20 > 0 and var_538_14 < var_538_20 then
					arg_535_1.talkMaxDuration = var_538_20

					if var_538_20 + var_538_13 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_20 + var_538_13
					end
				end

				arg_535_1.text_.text = var_538_17
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_21 = math.max(var_538_14, arg_535_1.talkMaxDuration)

			if var_538_13 <= arg_535_1.time_ and arg_535_1.time_ < var_538_13 + var_538_21 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_13) / var_538_21

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_13 + var_538_21 and arg_535_1.time_ < var_538_13 + var_538_21 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end
	end,
	Play910110133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 910110133
		arg_539_1.duration_ = 7

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play910110134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = "ST01a"

			if arg_539_1.bgs_[var_542_0] == nil then
				local var_542_1 = Object.Instantiate(arg_539_1.paintGo_)

				var_542_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_542_0)
				var_542_1.name = var_542_0
				var_542_1.transform.parent = arg_539_1.stage_.transform
				var_542_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_539_1.bgs_[var_542_0] = var_542_1
			end

			local var_542_2 = 2

			if var_542_2 < arg_539_1.time_ and arg_539_1.time_ <= var_542_2 + arg_542_0 then
				local var_542_3 = manager.ui.mainCamera.transform.localPosition
				local var_542_4 = Vector3.New(0, 0, 10) + Vector3.New(var_542_3.x, var_542_3.y, 0)
				local var_542_5 = arg_539_1.bgs_.ST01a

				var_542_5.transform.localPosition = var_542_4
				var_542_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_542_6 = var_542_5:GetComponent("SpriteRenderer")

				if var_542_6 and var_542_6.sprite then
					local var_542_7 = (var_542_5.transform.localPosition - var_542_3).z
					local var_542_8 = manager.ui.mainCameraCom_
					local var_542_9 = 2 * var_542_7 * Mathf.Tan(var_542_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_542_10 = var_542_9 * var_542_8.aspect
					local var_542_11 = var_542_6.sprite.bounds.size.x
					local var_542_12 = var_542_6.sprite.bounds.size.y
					local var_542_13 = var_542_10 / var_542_11
					local var_542_14 = var_542_9 / var_542_12
					local var_542_15 = var_542_14 < var_542_13 and var_542_13 or var_542_14

					var_542_5.transform.localScale = Vector3.New(var_542_15, var_542_15, 0)
				end

				for iter_542_0, iter_542_1 in pairs(arg_539_1.bgs_) do
					if iter_542_0 ~= "ST01a" then
						iter_542_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_542_16 = arg_539_1.actors_["1066"].transform
			local var_542_17 = 2

			if var_542_17 < arg_539_1.time_ and arg_539_1.time_ <= var_542_17 + arg_542_0 then
				arg_539_1.var_.moveOldPos1066 = var_542_16.localPosition
				var_542_16.localScale = Vector3.New(1, 1, 1)

				arg_539_1:CheckSpriteTmpPos("1066", 3)

				local var_542_18 = var_542_16.childCount

				for iter_542_2 = 0, var_542_18 - 1 do
					local var_542_19 = var_542_16:GetChild(iter_542_2)

					if var_542_19.name == "split_1" or not string.find(var_542_19.name, "split") then
						var_542_19.gameObject:SetActive(true)
					else
						var_542_19.gameObject:SetActive(false)
					end
				end
			end

			local var_542_20 = 0.001

			if var_542_17 <= arg_539_1.time_ and arg_539_1.time_ < var_542_17 + var_542_20 then
				local var_542_21 = (arg_539_1.time_ - var_542_17) / var_542_20
				local var_542_22 = Vector3.New(0, -350, -180)

				var_542_16.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1066, var_542_22, var_542_21)
			end

			if arg_539_1.time_ >= var_542_17 + var_542_20 and arg_539_1.time_ < var_542_17 + var_542_20 + arg_542_0 then
				var_542_16.localPosition = Vector3.New(0, -350, -180)
			end

			local var_542_23 = 0

			if var_542_23 < arg_539_1.time_ and arg_539_1.time_ <= var_542_23 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_24 = 2

			if var_542_23 <= arg_539_1.time_ and arg_539_1.time_ < var_542_23 + var_542_24 then
				local var_542_25 = (arg_539_1.time_ - var_542_23) / var_542_24
				local var_542_26 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_26.a = Mathf.Lerp(0, 1, var_542_25)
				arg_539_1.mask_.color = var_542_26
			end

			if arg_539_1.time_ >= var_542_23 + var_542_24 and arg_539_1.time_ < var_542_23 + var_542_24 + arg_542_0 then
				local var_542_27 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_27.a = 1
				arg_539_1.mask_.color = var_542_27
			end

			local var_542_28 = 2

			if var_542_28 < arg_539_1.time_ and arg_539_1.time_ <= var_542_28 + arg_542_0 then
				arg_539_1.mask_.enabled = true
				arg_539_1.mask_.raycastTarget = true

				arg_539_1:SetGaussion(false)
			end

			local var_542_29 = 2

			if var_542_28 <= arg_539_1.time_ and arg_539_1.time_ < var_542_28 + var_542_29 then
				local var_542_30 = (arg_539_1.time_ - var_542_28) / var_542_29
				local var_542_31 = Color.New(0.02830189, 0.0281684, 0.0281684)

				var_542_31.a = Mathf.Lerp(1, 0, var_542_30)
				arg_539_1.mask_.color = var_542_31
			end

			if arg_539_1.time_ >= var_542_28 + var_542_29 and arg_539_1.time_ < var_542_28 + var_542_29 + arg_542_0 then
				local var_542_32 = Color.New(0.02830189, 0.0281684, 0.0281684)
				local var_542_33 = 0

				arg_539_1.mask_.enabled = false
				var_542_32.a = var_542_33
				arg_539_1.mask_.color = var_542_32
			end

			local var_542_34 = arg_539_1.actors_["1066"]
			local var_542_35 = 2

			if var_542_35 < arg_539_1.time_ and arg_539_1.time_ <= var_542_35 + arg_542_0 then
				local var_542_36 = var_542_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_542_36 then
					arg_539_1.var_.alphaOldValue1066 = var_542_36.alpha
					arg_539_1.var_.characterEffect1066 = var_542_36
				end

				arg_539_1.var_.alphaOldValue1066 = 0
			end

			local var_542_37 = 1.1

			if var_542_35 <= arg_539_1.time_ and arg_539_1.time_ < var_542_35 + var_542_37 then
				local var_542_38 = (arg_539_1.time_ - var_542_35) / var_542_37
				local var_542_39 = Mathf.Lerp(arg_539_1.var_.alphaOldValue1066, 1, var_542_38)

				if arg_539_1.var_.characterEffect1066 then
					arg_539_1.var_.characterEffect1066.alpha = var_542_39
				end
			end

			if arg_539_1.time_ >= var_542_35 + var_542_37 and arg_539_1.time_ < var_542_35 + var_542_37 + arg_542_0 and arg_539_1.var_.characterEffect1066 then
				arg_539_1.var_.characterEffect1066.alpha = 1
			end

			local var_542_40 = arg_539_1.actors_["1066"]
			local var_542_41 = 0

			if var_542_41 < arg_539_1.time_ and arg_539_1.time_ <= var_542_41 + arg_542_0 and arg_539_1.var_.actorSpriteComps1066 == nil then
				arg_539_1.var_.actorSpriteComps1066 = var_542_40:GetComponentsInChildren(typeof(Image), true)
			end

			local var_542_42 = 0.0166666666666667

			if var_542_41 <= arg_539_1.time_ and arg_539_1.time_ < var_542_41 + var_542_42 then
				local var_542_43 = (arg_539_1.time_ - var_542_41) / var_542_42

				if arg_539_1.var_.actorSpriteComps1066 then
					for iter_542_3, iter_542_4 in pairs(arg_539_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_542_4 then
							local var_542_44 = Mathf.Lerp(iter_542_4.color.r, 1, var_542_43)

							iter_542_4.color = Color.New(var_542_44, var_542_44, var_542_44)
						end
					end
				end
			end

			if arg_539_1.time_ >= var_542_41 + var_542_42 and arg_539_1.time_ < var_542_41 + var_542_42 + arg_542_0 and arg_539_1.var_.actorSpriteComps1066 then
				local var_542_45 = 1

				for iter_542_5, iter_542_6 in pairs(arg_539_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_542_6 then
						iter_542_6.color = Color.New(var_542_45, var_542_45, var_542_45)
					end
				end

				arg_539_1.var_.actorSpriteComps1066 = nil
			end

			local var_542_46 = 2
			local var_542_47 = 0.275

			if var_542_46 < arg_539_1.time_ and arg_539_1.time_ <= var_542_46 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_48 = arg_539_1:FormatText(StoryNameCfg[32].name)

				arg_539_1.leftNameTxt_.text = var_542_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_49 = arg_539_1:GetWordFromCfg(910110133)
				local var_542_50 = arg_539_1:FormatText(var_542_49.content)

				arg_539_1.text_.text = var_542_50

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_51 = 11
				local var_542_52 = utf8.len(var_542_50)
				local var_542_53 = var_542_51 <= 0 and var_542_47 or var_542_47 * (var_542_52 / var_542_51)

				if var_542_53 > 0 and var_542_47 < var_542_53 then
					arg_539_1.talkMaxDuration = var_542_53

					if var_542_53 + var_542_46 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_53 + var_542_46
					end
				end

				arg_539_1.text_.text = var_542_50
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_54 = math.max(var_542_47, arg_539_1.talkMaxDuration)

			if var_542_46 <= arg_539_1.time_ and arg_539_1.time_ < var_542_46 + var_542_54 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_46) / var_542_54

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_46 + var_542_54 and arg_539_1.time_ < var_542_46 + var_542_54 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end
	end,
	Play910110134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 910110134
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play910110135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1066"]
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 and arg_543_1.var_.actorSpriteComps1066 == nil then
				arg_543_1.var_.actorSpriteComps1066 = var_546_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_2 = 0.2

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2

				if arg_543_1.var_.actorSpriteComps1066 then
					for iter_546_0, iter_546_1 in pairs(arg_543_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_546_1 then
							local var_546_4 = Mathf.Lerp(iter_546_1.color.r, 0.5, var_546_3)

							iter_546_1.color = Color.New(var_546_4, var_546_4, var_546_4)
						end
					end
				end
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 and arg_543_1.var_.actorSpriteComps1066 then
				local var_546_5 = 0.5

				for iter_546_2, iter_546_3 in pairs(arg_543_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_546_3 then
						iter_546_3.color = Color.New(var_546_5, var_546_5, var_546_5)
					end
				end

				arg_543_1.var_.actorSpriteComps1066 = nil
			end

			local var_546_6 = 0
			local var_546_7 = 0.725

			if var_546_6 < arg_543_1.time_ and arg_543_1.time_ <= var_546_6 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_8 = arg_543_1:FormatText(StoryNameCfg[355].name)

				arg_543_1.leftNameTxt_.text = var_546_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_9 = arg_543_1:GetWordFromCfg(910110134)
				local var_546_10 = arg_543_1:FormatText(var_546_9.content)

				arg_543_1.text_.text = var_546_10

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_11 = 29
				local var_546_12 = utf8.len(var_546_10)
				local var_546_13 = var_546_11 <= 0 and var_546_7 or var_546_7 * (var_546_12 / var_546_11)

				if var_546_13 > 0 and var_546_7 < var_546_13 then
					arg_543_1.talkMaxDuration = var_546_13

					if var_546_13 + var_546_6 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_13 + var_546_6
					end
				end

				arg_543_1.text_.text = var_546_10
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_14 = math.max(var_546_7, arg_543_1.talkMaxDuration)

			if var_546_6 <= arg_543_1.time_ and arg_543_1.time_ < var_546_6 + var_546_14 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_6) / var_546_14

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_6 + var_546_14 and arg_543_1.time_ < var_546_6 + var_546_14 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end
	end,
	Play910110135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 910110135
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play910110136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0
			local var_550_1 = 0.1

			if var_550_0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_2 = arg_547_1:FormatText(StoryNameCfg[355].name)

				arg_547_1.leftNameTxt_.text = var_550_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_3 = arg_547_1:GetWordFromCfg(910110135)
				local var_550_4 = arg_547_1:FormatText(var_550_3.content)

				arg_547_1.text_.text = var_550_4

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 4
				local var_550_6 = utf8.len(var_550_4)
				local var_550_7 = var_550_5 <= 0 and var_550_1 or var_550_1 * (var_550_6 / var_550_5)

				if var_550_7 > 0 and var_550_1 < var_550_7 then
					arg_547_1.talkMaxDuration = var_550_7

					if var_550_7 + var_550_0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_7 + var_550_0
					end
				end

				arg_547_1.text_.text = var_550_4
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_8 = math.max(var_550_1, arg_547_1.talkMaxDuration)

			if var_550_0 <= arg_547_1.time_ and arg_547_1.time_ < var_550_0 + var_550_8 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_0) / var_550_8

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_0 + var_550_8 and arg_547_1.time_ < var_550_0 + var_550_8 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end
	end,
	Play910110136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 910110136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play910110137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 0.1

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_2 = arg_551_1:FormatText(StoryNameCfg[355].name)

				arg_551_1.leftNameTxt_.text = var_554_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_3 = arg_551_1:GetWordFromCfg(910110136)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 4
				local var_554_6 = utf8.len(var_554_4)
				local var_554_7 = var_554_5 <= 0 and var_554_1 or var_554_1 * (var_554_6 / var_554_5)

				if var_554_7 > 0 and var_554_1 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_8 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_8 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_8

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_8 and arg_551_1.time_ < var_554_0 + var_554_8 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end
	end,
	Play910110137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 910110137
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play910110138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1070"].transform
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.var_.moveOldPos1070 = var_558_0.localPosition
				var_558_0.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("1070", 3)

				local var_558_2 = var_558_0.childCount

				for iter_558_0 = 0, var_558_2 - 1 do
					local var_558_3 = var_558_0:GetChild(iter_558_0)

					if var_558_3.name == "split_2" or not string.find(var_558_3.name, "split") then
						var_558_3.gameObject:SetActive(true)
					else
						var_558_3.gameObject:SetActive(false)
					end
				end
			end

			local var_558_4 = 0.001

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_4 then
				local var_558_5 = (arg_555_1.time_ - var_558_1) / var_558_4
				local var_558_6 = Vector3.New(0, -350, -180)

				var_558_0.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1070, var_558_6, var_558_5)
			end

			if arg_555_1.time_ >= var_558_1 + var_558_4 and arg_555_1.time_ < var_558_1 + var_558_4 + arg_558_0 then
				var_558_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_558_7 = arg_555_1.actors_["1070"]
			local var_558_8 = 0

			if var_558_8 < arg_555_1.time_ and arg_555_1.time_ <= var_558_8 + arg_558_0 then
				local var_558_9 = var_558_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_558_9 then
					arg_555_1.var_.alphaOldValue1070 = var_558_9.alpha
					arg_555_1.var_.characterEffect1070 = var_558_9
				end

				arg_555_1.var_.alphaOldValue1070 = 0
			end

			local var_558_10 = 0.5

			if var_558_8 <= arg_555_1.time_ and arg_555_1.time_ < var_558_8 + var_558_10 then
				local var_558_11 = (arg_555_1.time_ - var_558_8) / var_558_10
				local var_558_12 = Mathf.Lerp(arg_555_1.var_.alphaOldValue1070, 1, var_558_11)

				if arg_555_1.var_.characterEffect1070 then
					arg_555_1.var_.characterEffect1070.alpha = var_558_12
				end
			end

			if arg_555_1.time_ >= var_558_8 + var_558_10 and arg_555_1.time_ < var_558_8 + var_558_10 + arg_558_0 and arg_555_1.var_.characterEffect1070 then
				arg_555_1.var_.characterEffect1070.alpha = 1
			end

			local var_558_13 = arg_555_1.actors_["1070"]
			local var_558_14 = 0

			if var_558_14 < arg_555_1.time_ and arg_555_1.time_ <= var_558_14 + arg_558_0 and arg_555_1.var_.actorSpriteComps1070 == nil then
				arg_555_1.var_.actorSpriteComps1070 = var_558_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_15 = 0.0166666666666667

			if var_558_14 <= arg_555_1.time_ and arg_555_1.time_ < var_558_14 + var_558_15 then
				local var_558_16 = (arg_555_1.time_ - var_558_14) / var_558_15

				if arg_555_1.var_.actorSpriteComps1070 then
					for iter_558_1, iter_558_2 in pairs(arg_555_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_558_2 then
							local var_558_17 = Mathf.Lerp(iter_558_2.color.r, 1, var_558_16)

							iter_558_2.color = Color.New(var_558_17, var_558_17, var_558_17)
						end
					end
				end
			end

			if arg_555_1.time_ >= var_558_14 + var_558_15 and arg_555_1.time_ < var_558_14 + var_558_15 + arg_558_0 and arg_555_1.var_.actorSpriteComps1070 then
				local var_558_18 = 1

				for iter_558_3, iter_558_4 in pairs(arg_555_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_558_4 then
						iter_558_4.color = Color.New(var_558_18, var_558_18, var_558_18)
					end
				end

				arg_555_1.var_.actorSpriteComps1070 = nil
			end

			local var_558_19 = 0
			local var_558_20 = 0.15

			if var_558_19 < arg_555_1.time_ and arg_555_1.time_ <= var_558_19 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_21 = arg_555_1:FormatText(StoryNameCfg[318].name)

				arg_555_1.leftNameTxt_.text = var_558_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_22 = arg_555_1:GetWordFromCfg(910110137)
				local var_558_23 = arg_555_1:FormatText(var_558_22.content)

				arg_555_1.text_.text = var_558_23

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_24 = 6
				local var_558_25 = utf8.len(var_558_23)
				local var_558_26 = var_558_24 <= 0 and var_558_20 or var_558_20 * (var_558_25 / var_558_24)

				if var_558_26 > 0 and var_558_20 < var_558_26 then
					arg_555_1.talkMaxDuration = var_558_26

					if var_558_26 + var_558_19 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_26 + var_558_19
					end
				end

				arg_555_1.text_.text = var_558_23
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_27 = math.max(var_558_20, arg_555_1.talkMaxDuration)

			if var_558_19 <= arg_555_1.time_ and arg_555_1.time_ < var_558_19 + var_558_27 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_19) / var_558_27

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_19 + var_558_27 and arg_555_1.time_ < var_558_19 + var_558_27 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end
	end,
	Play910110138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 910110138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play910110139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["1070"]
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 and arg_559_1.var_.actorSpriteComps1070 == nil then
				arg_559_1.var_.actorSpriteComps1070 = var_562_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_562_2 = 0.2

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2

				if arg_559_1.var_.actorSpriteComps1070 then
					for iter_562_0, iter_562_1 in pairs(arg_559_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_562_1 then
							local var_562_4 = Mathf.Lerp(iter_562_1.color.r, 0.5, var_562_3)

							iter_562_1.color = Color.New(var_562_4, var_562_4, var_562_4)
						end
					end
				end
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 and arg_559_1.var_.actorSpriteComps1070 then
				local var_562_5 = 0.5

				for iter_562_2, iter_562_3 in pairs(arg_559_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_562_3 then
						iter_562_3.color = Color.New(var_562_5, var_562_5, var_562_5)
					end
				end

				arg_559_1.var_.actorSpriteComps1070 = nil
			end

			local var_562_6 = 0
			local var_562_7 = 0.4

			if var_562_6 < arg_559_1.time_ and arg_559_1.time_ <= var_562_6 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_8 = arg_559_1:FormatText(StoryNameCfg[7].name)

				arg_559_1.leftNameTxt_.text = var_562_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_9 = arg_559_1:GetWordFromCfg(910110138)
				local var_562_10 = arg_559_1:FormatText(var_562_9.content)

				arg_559_1.text_.text = var_562_10

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_11 = 16
				local var_562_12 = utf8.len(var_562_10)
				local var_562_13 = var_562_11 <= 0 and var_562_7 or var_562_7 * (var_562_12 / var_562_11)

				if var_562_13 > 0 and var_562_7 < var_562_13 then
					arg_559_1.talkMaxDuration = var_562_13

					if var_562_13 + var_562_6 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_13 + var_562_6
					end
				end

				arg_559_1.text_.text = var_562_10
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_14 = math.max(var_562_7, arg_559_1.talkMaxDuration)

			if var_562_6 <= arg_559_1.time_ and arg_559_1.time_ < var_562_6 + var_562_14 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_6) / var_562_14

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_6 + var_562_14 and arg_559_1.time_ < var_562_6 + var_562_14 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end
	end,
	Play910110139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 910110139
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play910110140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1070"]
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 and arg_563_1.var_.actorSpriteComps1070 == nil then
				arg_563_1.var_.actorSpriteComps1070 = var_566_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_566_2 = 0.2

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2

				if arg_563_1.var_.actorSpriteComps1070 then
					for iter_566_0, iter_566_1 in pairs(arg_563_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_566_1 then
							local var_566_4 = Mathf.Lerp(iter_566_1.color.r, 1, var_566_3)

							iter_566_1.color = Color.New(var_566_4, var_566_4, var_566_4)
						end
					end
				end
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 and arg_563_1.var_.actorSpriteComps1070 then
				local var_566_5 = 1

				for iter_566_2, iter_566_3 in pairs(arg_563_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_566_3 then
						iter_566_3.color = Color.New(var_566_5, var_566_5, var_566_5)
					end
				end

				arg_563_1.var_.actorSpriteComps1070 = nil
			end

			local var_566_6 = 0
			local var_566_7 = 0.65

			if var_566_6 < arg_563_1.time_ and arg_563_1.time_ <= var_566_6 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_8 = arg_563_1:FormatText(StoryNameCfg[318].name)

				arg_563_1.leftNameTxt_.text = var_566_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_9 = arg_563_1:GetWordFromCfg(910110139)
				local var_566_10 = arg_563_1:FormatText(var_566_9.content)

				arg_563_1.text_.text = var_566_10

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_11 = 26
				local var_566_12 = utf8.len(var_566_10)
				local var_566_13 = var_566_11 <= 0 and var_566_7 or var_566_7 * (var_566_12 / var_566_11)

				if var_566_13 > 0 and var_566_7 < var_566_13 then
					arg_563_1.talkMaxDuration = var_566_13

					if var_566_13 + var_566_6 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_13 + var_566_6
					end
				end

				arg_563_1.text_.text = var_566_10
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_14 = math.max(var_566_7, arg_563_1.talkMaxDuration)

			if var_566_6 <= arg_563_1.time_ and arg_563_1.time_ < var_566_6 + var_566_14 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_6) / var_566_14

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_6 + var_566_14 and arg_563_1.time_ < var_566_6 + var_566_14 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end
	end,
	Play910110140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 910110140
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play910110141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1070"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and arg_567_1.var_.actorSpriteComps1070 == nil then
				arg_567_1.var_.actorSpriteComps1070 = var_570_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_2 = 0.2

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.actorSpriteComps1070 then
					for iter_570_0, iter_570_1 in pairs(arg_567_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_570_1 then
							local var_570_4 = Mathf.Lerp(iter_570_1.color.r, 0.5, var_570_3)

							iter_570_1.color = Color.New(var_570_4, var_570_4, var_570_4)
						end
					end
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and arg_567_1.var_.actorSpriteComps1070 then
				local var_570_5 = 0.5

				for iter_570_2, iter_570_3 in pairs(arg_567_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_570_3 then
						iter_570_3.color = Color.New(var_570_5, var_570_5, var_570_5)
					end
				end

				arg_567_1.var_.actorSpriteComps1070 = nil
			end

			local var_570_6 = 0
			local var_570_7 = 0.725

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_8 = arg_567_1:FormatText(StoryNameCfg[355].name)

				arg_567_1.leftNameTxt_.text = var_570_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_9 = arg_567_1:GetWordFromCfg(910110140)
				local var_570_10 = arg_567_1:FormatText(var_570_9.content)

				arg_567_1.text_.text = var_570_10

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_11 = 29
				local var_570_12 = utf8.len(var_570_10)
				local var_570_13 = var_570_11 <= 0 and var_570_7 or var_570_7 * (var_570_12 / var_570_11)

				if var_570_13 > 0 and var_570_7 < var_570_13 then
					arg_567_1.talkMaxDuration = var_570_13

					if var_570_13 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_13 + var_570_6
					end
				end

				arg_567_1.text_.text = var_570_10
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_14 = math.max(var_570_7, arg_567_1.talkMaxDuration)

			if var_570_6 <= arg_567_1.time_ and arg_567_1.time_ < var_570_6 + var_570_14 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_6) / var_570_14

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_6 + var_570_14 and arg_567_1.time_ < var_570_6 + var_570_14 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end
	end,
	Play910110141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 910110141
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play910110142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1070"].transform
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.var_.moveOldPos1070 = var_574_0.localPosition
				var_574_0.localScale = Vector3.New(1, 1, 1)

				arg_571_1:CheckSpriteTmpPos("1070", 3)

				local var_574_2 = var_574_0.childCount

				for iter_574_0 = 0, var_574_2 - 1 do
					local var_574_3 = var_574_0:GetChild(iter_574_0)

					if var_574_3.name == "split_1" or not string.find(var_574_3.name, "split") then
						var_574_3.gameObject:SetActive(true)
					else
						var_574_3.gameObject:SetActive(false)
					end
				end
			end

			local var_574_4 = 0.001

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_4 then
				local var_574_5 = (arg_571_1.time_ - var_574_1) / var_574_4
				local var_574_6 = Vector3.New(0, -350, -180)

				var_574_0.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1070, var_574_6, var_574_5)
			end

			if arg_571_1.time_ >= var_574_1 + var_574_4 and arg_571_1.time_ < var_574_1 + var_574_4 + arg_574_0 then
				var_574_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_574_7 = 0
			local var_574_8 = 0.95

			if var_574_7 < arg_571_1.time_ and arg_571_1.time_ <= var_574_7 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_9 = arg_571_1:FormatText(StoryNameCfg[318].name)

				arg_571_1.leftNameTxt_.text = var_574_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_10 = arg_571_1:GetWordFromCfg(910110141)
				local var_574_11 = arg_571_1:FormatText(var_574_10.content)

				arg_571_1.text_.text = var_574_11

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_12 = 38
				local var_574_13 = utf8.len(var_574_11)
				local var_574_14 = var_574_12 <= 0 and var_574_8 or var_574_8 * (var_574_13 / var_574_12)

				if var_574_14 > 0 and var_574_8 < var_574_14 then
					arg_571_1.talkMaxDuration = var_574_14

					if var_574_14 + var_574_7 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_14 + var_574_7
					end
				end

				arg_571_1.text_.text = var_574_11
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_15 = math.max(var_574_8, arg_571_1.talkMaxDuration)

			if var_574_7 <= arg_571_1.time_ and arg_571_1.time_ < var_574_7 + var_574_15 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_7) / var_574_15

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_7 + var_574_15 and arg_571_1.time_ < var_574_7 + var_574_15 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end
	end,
	Play910110142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 910110142
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play910110143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1066"].transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPos1066 = var_578_0.localPosition
				var_578_0.localScale = Vector3.New(1, 1, 1)

				arg_575_1:CheckSpriteTmpPos("1066", 3)

				local var_578_2 = var_578_0.childCount

				for iter_578_0 = 0, var_578_2 - 1 do
					local var_578_3 = var_578_0:GetChild(iter_578_0)

					if var_578_3.name == "split_3" or not string.find(var_578_3.name, "split") then
						var_578_3.gameObject:SetActive(true)
					else
						var_578_3.gameObject:SetActive(false)
					end
				end
			end

			local var_578_4 = 0.001

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_4 then
				local var_578_5 = (arg_575_1.time_ - var_578_1) / var_578_4
				local var_578_6 = Vector3.New(0, -350, -180)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1066, var_578_6, var_578_5)
			end

			if arg_575_1.time_ >= var_578_1 + var_578_4 and arg_575_1.time_ < var_578_1 + var_578_4 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_578_7 = arg_575_1.actors_["1066"]
			local var_578_8 = 0

			if var_578_8 < arg_575_1.time_ and arg_575_1.time_ <= var_578_8 + arg_578_0 then
				local var_578_9 = var_578_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_578_9 then
					arg_575_1.var_.alphaOldValue1066 = var_578_9.alpha
					arg_575_1.var_.characterEffect1066 = var_578_9
				end

				arg_575_1.var_.alphaOldValue1066 = 0
			end

			local var_578_10 = 0.5

			if var_578_8 <= arg_575_1.time_ and arg_575_1.time_ < var_578_8 + var_578_10 then
				local var_578_11 = (arg_575_1.time_ - var_578_8) / var_578_10
				local var_578_12 = Mathf.Lerp(arg_575_1.var_.alphaOldValue1066, 1, var_578_11)

				if arg_575_1.var_.characterEffect1066 then
					arg_575_1.var_.characterEffect1066.alpha = var_578_12
				end
			end

			if arg_575_1.time_ >= var_578_8 + var_578_10 and arg_575_1.time_ < var_578_8 + var_578_10 + arg_578_0 and arg_575_1.var_.characterEffect1066 then
				arg_575_1.var_.characterEffect1066.alpha = 1
			end

			local var_578_13 = 0
			local var_578_14 = 0.275

			if var_578_13 < arg_575_1.time_ and arg_575_1.time_ <= var_578_13 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_15 = arg_575_1:FormatText(StoryNameCfg[32].name)

				arg_575_1.leftNameTxt_.text = var_578_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_16 = arg_575_1:GetWordFromCfg(910110142)
				local var_578_17 = arg_575_1:FormatText(var_578_16.content)

				arg_575_1.text_.text = var_578_17

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_18 = 11
				local var_578_19 = utf8.len(var_578_17)
				local var_578_20 = var_578_18 <= 0 and var_578_14 or var_578_14 * (var_578_19 / var_578_18)

				if var_578_20 > 0 and var_578_14 < var_578_20 then
					arg_575_1.talkMaxDuration = var_578_20

					if var_578_20 + var_578_13 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_20 + var_578_13
					end
				end

				arg_575_1.text_.text = var_578_17
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_21 = math.max(var_578_14, arg_575_1.talkMaxDuration)

			if var_578_13 <= arg_575_1.time_ and arg_575_1.time_ < var_578_13 + var_578_21 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_13) / var_578_21

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_13 + var_578_21 and arg_575_1.time_ < var_578_13 + var_578_21 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end
	end,
	Play910110143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 910110143
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play910110144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["1066"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and arg_579_1.var_.actorSpriteComps1066 == nil then
				arg_579_1.var_.actorSpriteComps1066 = var_582_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_2 = 0.2

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.actorSpriteComps1066 then
					for iter_582_0, iter_582_1 in pairs(arg_579_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_582_1 then
							local var_582_4 = Mathf.Lerp(iter_582_1.color.r, 0.5, var_582_3)

							iter_582_1.color = Color.New(var_582_4, var_582_4, var_582_4)
						end
					end
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and arg_579_1.var_.actorSpriteComps1066 then
				local var_582_5 = 0.5

				for iter_582_2, iter_582_3 in pairs(arg_579_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_582_3 then
						iter_582_3.color = Color.New(var_582_5, var_582_5, var_582_5)
					end
				end

				arg_579_1.var_.actorSpriteComps1066 = nil
			end

			local var_582_6 = 0
			local var_582_7 = 0.3

			if var_582_6 < arg_579_1.time_ and arg_579_1.time_ <= var_582_6 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_8 = arg_579_1:FormatText(StoryNameCfg[7].name)

				arg_579_1.leftNameTxt_.text = var_582_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_9 = arg_579_1:GetWordFromCfg(910110143)
				local var_582_10 = arg_579_1:FormatText(var_582_9.content)

				arg_579_1.text_.text = var_582_10

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_11 = 12
				local var_582_12 = utf8.len(var_582_10)
				local var_582_13 = var_582_11 <= 0 and var_582_7 or var_582_7 * (var_582_12 / var_582_11)

				if var_582_13 > 0 and var_582_7 < var_582_13 then
					arg_579_1.talkMaxDuration = var_582_13

					if var_582_13 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_13 + var_582_6
					end
				end

				arg_579_1.text_.text = var_582_10
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_14 = math.max(var_582_7, arg_579_1.talkMaxDuration)

			if var_582_6 <= arg_579_1.time_ and arg_579_1.time_ < var_582_6 + var_582_14 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_6) / var_582_14

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_6 + var_582_14 and arg_579_1.time_ < var_582_6 + var_582_14 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end
	end,
	Play910110144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 910110144
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play910110145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1070"].transform
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.var_.moveOldPos1070 = var_586_0.localPosition
				var_586_0.localScale = Vector3.New(1, 1, 1)

				arg_583_1:CheckSpriteTmpPos("1070", 3)

				local var_586_2 = var_586_0.childCount

				for iter_586_0 = 0, var_586_2 - 1 do
					local var_586_3 = var_586_0:GetChild(iter_586_0)

					if var_586_3.name == "split_8" or not string.find(var_586_3.name, "split") then
						var_586_3.gameObject:SetActive(true)
					else
						var_586_3.gameObject:SetActive(false)
					end
				end
			end

			local var_586_4 = 0.001

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_4 then
				local var_586_5 = (arg_583_1.time_ - var_586_1) / var_586_4
				local var_586_6 = Vector3.New(0, -350, -180)

				var_586_0.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1070, var_586_6, var_586_5)
			end

			if arg_583_1.time_ >= var_586_1 + var_586_4 and arg_583_1.time_ < var_586_1 + var_586_4 + arg_586_0 then
				var_586_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_586_7 = arg_583_1.actors_["1070"]
			local var_586_8 = 0

			if var_586_8 < arg_583_1.time_ and arg_583_1.time_ <= var_586_8 + arg_586_0 and arg_583_1.var_.actorSpriteComps1070 == nil then
				arg_583_1.var_.actorSpriteComps1070 = var_586_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_586_9 = 0.0166666666666667

			if var_586_8 <= arg_583_1.time_ and arg_583_1.time_ < var_586_8 + var_586_9 then
				local var_586_10 = (arg_583_1.time_ - var_586_8) / var_586_9

				if arg_583_1.var_.actorSpriteComps1070 then
					for iter_586_1, iter_586_2 in pairs(arg_583_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_586_2 then
							local var_586_11 = Mathf.Lerp(iter_586_2.color.r, 1, var_586_10)

							iter_586_2.color = Color.New(var_586_11, var_586_11, var_586_11)
						end
					end
				end
			end

			if arg_583_1.time_ >= var_586_8 + var_586_9 and arg_583_1.time_ < var_586_8 + var_586_9 + arg_586_0 and arg_583_1.var_.actorSpriteComps1070 then
				local var_586_12 = 1

				for iter_586_3, iter_586_4 in pairs(arg_583_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_586_4 then
						iter_586_4.color = Color.New(var_586_12, var_586_12, var_586_12)
					end
				end

				arg_583_1.var_.actorSpriteComps1070 = nil
			end

			local var_586_13 = 0
			local var_586_14 = 0.625

			if var_586_13 < arg_583_1.time_ and arg_583_1.time_ <= var_586_13 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_15 = arg_583_1:FormatText(StoryNameCfg[318].name)

				arg_583_1.leftNameTxt_.text = var_586_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_16 = arg_583_1:GetWordFromCfg(910110144)
				local var_586_17 = arg_583_1:FormatText(var_586_16.content)

				arg_583_1.text_.text = var_586_17

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_18 = 25
				local var_586_19 = utf8.len(var_586_17)
				local var_586_20 = var_586_18 <= 0 and var_586_14 or var_586_14 * (var_586_19 / var_586_18)

				if var_586_20 > 0 and var_586_14 < var_586_20 then
					arg_583_1.talkMaxDuration = var_586_20

					if var_586_20 + var_586_13 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_20 + var_586_13
					end
				end

				arg_583_1.text_.text = var_586_17
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_21 = math.max(var_586_14, arg_583_1.talkMaxDuration)

			if var_586_13 <= arg_583_1.time_ and arg_583_1.time_ < var_586_13 + var_586_21 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_13) / var_586_21

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_13 + var_586_21 and arg_583_1.time_ < var_586_13 + var_586_21 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end
	end,
	Play910110145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 910110145
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play910110146(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["1070"]
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 and arg_587_1.var_.actorSpriteComps1070 == nil then
				arg_587_1.var_.actorSpriteComps1070 = var_590_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_2 = 0.2

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2

				if arg_587_1.var_.actorSpriteComps1070 then
					for iter_590_0, iter_590_1 in pairs(arg_587_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_590_1 then
							local var_590_4 = Mathf.Lerp(iter_590_1.color.r, 0.5, var_590_3)

							iter_590_1.color = Color.New(var_590_4, var_590_4, var_590_4)
						end
					end
				end
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 and arg_587_1.var_.actorSpriteComps1070 then
				local var_590_5 = 0.5

				for iter_590_2, iter_590_3 in pairs(arg_587_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_590_3 then
						iter_590_3.color = Color.New(var_590_5, var_590_5, var_590_5)
					end
				end

				arg_587_1.var_.actorSpriteComps1070 = nil
			end

			local var_590_6 = 0
			local var_590_7 = 0.725

			if var_590_6 < arg_587_1.time_ and arg_587_1.time_ <= var_590_6 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_8 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_9 = arg_587_1:GetWordFromCfg(910110145)
				local var_590_10 = arg_587_1:FormatText(var_590_9.content)

				arg_587_1.text_.text = var_590_10

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_11 = 29
				local var_590_12 = utf8.len(var_590_10)
				local var_590_13 = var_590_11 <= 0 and var_590_7 or var_590_7 * (var_590_12 / var_590_11)

				if var_590_13 > 0 and var_590_7 < var_590_13 then
					arg_587_1.talkMaxDuration = var_590_13

					if var_590_13 + var_590_6 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_13 + var_590_6
					end
				end

				arg_587_1.text_.text = var_590_10
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_14 = math.max(var_590_7, arg_587_1.talkMaxDuration)

			if var_590_6 <= arg_587_1.time_ and arg_587_1.time_ < var_590_6 + var_590_14 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_6) / var_590_14

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_6 + var_590_14 and arg_587_1.time_ < var_590_6 + var_590_14 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end
	end,
	Play910110146 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 910110146
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play910110147(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["1070"].transform
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.var_.moveOldPos1070 = var_594_0.localPosition
				var_594_0.localScale = Vector3.New(1, 1, 1)

				arg_591_1:CheckSpriteTmpPos("1070", 3)

				local var_594_2 = var_594_0.childCount

				for iter_594_0 = 0, var_594_2 - 1 do
					local var_594_3 = var_594_0:GetChild(iter_594_0)

					if var_594_3.name == "split_6" or not string.find(var_594_3.name, "split") then
						var_594_3.gameObject:SetActive(true)
					else
						var_594_3.gameObject:SetActive(false)
					end
				end
			end

			local var_594_4 = 0.001

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_4 then
				local var_594_5 = (arg_591_1.time_ - var_594_1) / var_594_4
				local var_594_6 = Vector3.New(0, -350, -180)

				var_594_0.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos1070, var_594_6, var_594_5)
			end

			if arg_591_1.time_ >= var_594_1 + var_594_4 and arg_591_1.time_ < var_594_1 + var_594_4 + arg_594_0 then
				var_594_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_594_7 = arg_591_1.actors_["1070"]
			local var_594_8 = 0

			if var_594_8 < arg_591_1.time_ and arg_591_1.time_ <= var_594_8 + arg_594_0 and arg_591_1.var_.actorSpriteComps1070 == nil then
				arg_591_1.var_.actorSpriteComps1070 = var_594_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_594_9 = 0.0166666666666667

			if var_594_8 <= arg_591_1.time_ and arg_591_1.time_ < var_594_8 + var_594_9 then
				local var_594_10 = (arg_591_1.time_ - var_594_8) / var_594_9

				if arg_591_1.var_.actorSpriteComps1070 then
					for iter_594_1, iter_594_2 in pairs(arg_591_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_594_2 then
							local var_594_11 = Mathf.Lerp(iter_594_2.color.r, 1, var_594_10)

							iter_594_2.color = Color.New(var_594_11, var_594_11, var_594_11)
						end
					end
				end
			end

			if arg_591_1.time_ >= var_594_8 + var_594_9 and arg_591_1.time_ < var_594_8 + var_594_9 + arg_594_0 and arg_591_1.var_.actorSpriteComps1070 then
				local var_594_12 = 1

				for iter_594_3, iter_594_4 in pairs(arg_591_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_594_4 then
						iter_594_4.color = Color.New(var_594_12, var_594_12, var_594_12)
					end
				end

				arg_591_1.var_.actorSpriteComps1070 = nil
			end

			local var_594_13 = 0
			local var_594_14 = 0.225

			if var_594_13 < arg_591_1.time_ and arg_591_1.time_ <= var_594_13 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_15 = arg_591_1:FormatText(StoryNameCfg[318].name)

				arg_591_1.leftNameTxt_.text = var_594_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_16 = arg_591_1:GetWordFromCfg(910110146)
				local var_594_17 = arg_591_1:FormatText(var_594_16.content)

				arg_591_1.text_.text = var_594_17

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_18 = 9
				local var_594_19 = utf8.len(var_594_17)
				local var_594_20 = var_594_18 <= 0 and var_594_14 or var_594_14 * (var_594_19 / var_594_18)

				if var_594_20 > 0 and var_594_14 < var_594_20 then
					arg_591_1.talkMaxDuration = var_594_20

					if var_594_20 + var_594_13 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_20 + var_594_13
					end
				end

				arg_591_1.text_.text = var_594_17
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_21 = math.max(var_594_14, arg_591_1.talkMaxDuration)

			if var_594_13 <= arg_591_1.time_ and arg_591_1.time_ < var_594_13 + var_594_21 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_13) / var_594_21

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_13 + var_594_21 and arg_591_1.time_ < var_594_13 + var_594_21 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end
	end,
	Play910110147 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 910110147
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play910110148(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 1.05

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[318].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_3 = arg_595_1:GetWordFromCfg(910110147)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 42
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_8 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_8 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_8

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_8 and arg_595_1.time_ < var_598_0 + var_598_8 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end
	end,
	Play910110148 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 910110148
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play910110149(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["1070"].transform
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.var_.moveOldPos1070 = var_602_0.localPosition
				var_602_0.localScale = Vector3.New(1, 1, 1)

				arg_599_1:CheckSpriteTmpPos("1070", 7)

				local var_602_2 = var_602_0.childCount

				for iter_602_0 = 0, var_602_2 - 1 do
					local var_602_3 = var_602_0:GetChild(iter_602_0)

					if var_602_3.name == "split_6" or not string.find(var_602_3.name, "split") then
						var_602_3.gameObject:SetActive(true)
					else
						var_602_3.gameObject:SetActive(false)
					end
				end
			end

			local var_602_4 = 0.001

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_4 then
				local var_602_5 = (arg_599_1.time_ - var_602_1) / var_602_4
				local var_602_6 = Vector3.New(0, -2000, -180)

				var_602_0.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1070, var_602_6, var_602_5)
			end

			if arg_599_1.time_ >= var_602_1 + var_602_4 and arg_599_1.time_ < var_602_1 + var_602_4 + arg_602_0 then
				var_602_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_602_7 = arg_599_1.actors_["1070"]
			local var_602_8 = 0

			if var_602_8 < arg_599_1.time_ and arg_599_1.time_ <= var_602_8 + arg_602_0 then
				local var_602_9 = var_602_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_602_9 then
					arg_599_1.var_.alphaOldValue1070 = var_602_9.alpha
					arg_599_1.var_.characterEffect1070 = var_602_9
				end

				arg_599_1.var_.alphaOldValue1070 = 1
			end

			local var_602_10 = 0.5

			if var_602_8 <= arg_599_1.time_ and arg_599_1.time_ < var_602_8 + var_602_10 then
				local var_602_11 = (arg_599_1.time_ - var_602_8) / var_602_10
				local var_602_12 = Mathf.Lerp(arg_599_1.var_.alphaOldValue1070, 0, var_602_11)

				if arg_599_1.var_.characterEffect1070 then
					arg_599_1.var_.characterEffect1070.alpha = var_602_12
				end
			end

			if arg_599_1.time_ >= var_602_8 + var_602_10 and arg_599_1.time_ < var_602_8 + var_602_10 + arg_602_0 and arg_599_1.var_.characterEffect1070 then
				arg_599_1.var_.characterEffect1070.alpha = 0
			end

			local var_602_13 = 0
			local var_602_14 = 0.225

			if var_602_13 < arg_599_1.time_ and arg_599_1.time_ <= var_602_13 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_15 = arg_599_1:FormatText(StoryNameCfg[355].name)

				arg_599_1.leftNameTxt_.text = var_602_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_16 = arg_599_1:GetWordFromCfg(910110148)
				local var_602_17 = arg_599_1:FormatText(var_602_16.content)

				arg_599_1.text_.text = var_602_17

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_18 = 9
				local var_602_19 = utf8.len(var_602_17)
				local var_602_20 = var_602_18 <= 0 and var_602_14 or var_602_14 * (var_602_19 / var_602_18)

				if var_602_20 > 0 and var_602_14 < var_602_20 then
					arg_599_1.talkMaxDuration = var_602_20

					if var_602_20 + var_602_13 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_20 + var_602_13
					end
				end

				arg_599_1.text_.text = var_602_17
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_21 = math.max(var_602_14, arg_599_1.talkMaxDuration)

			if var_602_13 <= arg_599_1.time_ and arg_599_1.time_ < var_602_13 + var_602_21 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_13) / var_602_21

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_13 + var_602_21 and arg_599_1.time_ < var_602_13 + var_602_21 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end
	end,
	Play910110149 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 910110149
		arg_603_1.duration_ = 0.016666666666

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"

			SetActive(arg_603_1.choicesGo_, true)

			for iter_604_0, iter_604_1 in ipairs(arg_603_1.choices_) do
				local var_604_0 = iter_604_0 <= 2

				SetActive(iter_604_1.go, var_604_0)
			end

			arg_603_1.choices_[1].txt.text = arg_603_1:FormatText(StoryChoiceCfg[298].name)
			arg_603_1.choices_[2].txt.text = arg_603_1:FormatText(StoryChoiceCfg[299].name)
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play910110150(arg_603_1)
			end

			if arg_605_0 == 2 then
				arg_603_0:Play910110150(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			return
		end
	end,
	Play910110150 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 910110150
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play910110151(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 0.35

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_2 = arg_607_1:FormatText(StoryNameCfg[355].name)

				arg_607_1.leftNameTxt_.text = var_610_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_3 = arg_607_1:GetWordFromCfg(910110150)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_5 = 14
				local var_610_6 = utf8.len(var_610_4)
				local var_610_7 = var_610_5 <= 0 and var_610_1 or var_610_1 * (var_610_6 / var_610_5)

				if var_610_7 > 0 and var_610_1 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_8 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_8 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_8

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_8 and arg_607_1.time_ < var_610_0 + var_610_8 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end
	end,
	Play910110151 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 910110151
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play910110152(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = 0
			local var_614_1 = 1.45

			if var_614_0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_0 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_2 = arg_611_1:FormatText(StoryNameCfg[355].name)

				arg_611_1.leftNameTxt_.text = var_614_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_3 = arg_611_1:GetWordFromCfg(910110151)
				local var_614_4 = arg_611_1:FormatText(var_614_3.content)

				arg_611_1.text_.text = var_614_4

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_5 = 58
				local var_614_6 = utf8.len(var_614_4)
				local var_614_7 = var_614_5 <= 0 and var_614_1 or var_614_1 * (var_614_6 / var_614_5)

				if var_614_7 > 0 and var_614_1 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_0 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_0
					end
				end

				arg_611_1.text_.text = var_614_4
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_8 = math.max(var_614_1, arg_611_1.talkMaxDuration)

			if var_614_0 <= arg_611_1.time_ and arg_611_1.time_ < var_614_0 + var_614_8 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_0) / var_614_8

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_0 + var_614_8 and arg_611_1.time_ < var_614_0 + var_614_8 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end
	end,
	Play910110152 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 910110152
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play910110153(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.875

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_2 = arg_615_1:FormatText(StoryNameCfg[7].name)

				arg_615_1.leftNameTxt_.text = var_618_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_3 = arg_615_1:GetWordFromCfg(910110152)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 35
				local var_618_6 = utf8.len(var_618_4)
				local var_618_7 = var_618_5 <= 0 and var_618_1 or var_618_1 * (var_618_6 / var_618_5)

				if var_618_7 > 0 and var_618_1 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_8 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_8 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_8

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_8 and arg_615_1.time_ < var_618_0 + var_618_8 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end
	end,
	Play910110153 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 910110153
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play910110154(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0
			local var_622_1 = 0.075

			if var_622_0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_2 = arg_619_1:FormatText(StoryNameCfg[355].name)

				arg_619_1.leftNameTxt_.text = var_622_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_3 = arg_619_1:GetWordFromCfg(910110153)
				local var_622_4 = arg_619_1:FormatText(var_622_3.content)

				arg_619_1.text_.text = var_622_4

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_5 = 3
				local var_622_6 = utf8.len(var_622_4)
				local var_622_7 = var_622_5 <= 0 and var_622_1 or var_622_1 * (var_622_6 / var_622_5)

				if var_622_7 > 0 and var_622_1 < var_622_7 then
					arg_619_1.talkMaxDuration = var_622_7

					if var_622_7 + var_622_0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_7 + var_622_0
					end
				end

				arg_619_1.text_.text = var_622_4
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_8 = math.max(var_622_1, arg_619_1.talkMaxDuration)

			if var_622_0 <= arg_619_1.time_ and arg_619_1.time_ < var_622_0 + var_622_8 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_0) / var_622_8

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_0 + var_622_8 and arg_619_1.time_ < var_622_0 + var_622_8 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end
	end,
	Play910110154 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 910110154
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play910110155(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1070"].transform
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.var_.moveOldPos1070 = var_626_0.localPosition
				var_626_0.localScale = Vector3.New(1, 1, 1)

				arg_623_1:CheckSpriteTmpPos("1070", 3)

				local var_626_2 = var_626_0.childCount

				for iter_626_0 = 0, var_626_2 - 1 do
					local var_626_3 = var_626_0:GetChild(iter_626_0)

					if var_626_3.name == "split_2" or not string.find(var_626_3.name, "split") then
						var_626_3.gameObject:SetActive(true)
					else
						var_626_3.gameObject:SetActive(false)
					end
				end
			end

			local var_626_4 = 0.001

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_4 then
				local var_626_5 = (arg_623_1.time_ - var_626_1) / var_626_4
				local var_626_6 = Vector3.New(0, -350, -180)

				var_626_0.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1070, var_626_6, var_626_5)
			end

			if arg_623_1.time_ >= var_626_1 + var_626_4 and arg_623_1.time_ < var_626_1 + var_626_4 + arg_626_0 then
				var_626_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_626_7 = arg_623_1.actors_["1070"]
			local var_626_8 = 0

			if var_626_8 < arg_623_1.time_ and arg_623_1.time_ <= var_626_8 + arg_626_0 then
				local var_626_9 = var_626_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_626_9 then
					arg_623_1.var_.alphaOldValue1070 = var_626_9.alpha
					arg_623_1.var_.characterEffect1070 = var_626_9
				end

				arg_623_1.var_.alphaOldValue1070 = 0
			end

			local var_626_10 = 0.5

			if var_626_8 <= arg_623_1.time_ and arg_623_1.time_ < var_626_8 + var_626_10 then
				local var_626_11 = (arg_623_1.time_ - var_626_8) / var_626_10
				local var_626_12 = Mathf.Lerp(arg_623_1.var_.alphaOldValue1070, 1, var_626_11)

				if arg_623_1.var_.characterEffect1070 then
					arg_623_1.var_.characterEffect1070.alpha = var_626_12
				end
			end

			if arg_623_1.time_ >= var_626_8 + var_626_10 and arg_623_1.time_ < var_626_8 + var_626_10 + arg_626_0 and arg_623_1.var_.characterEffect1070 then
				arg_623_1.var_.characterEffect1070.alpha = 1
			end

			local var_626_13 = arg_623_1.actors_["1070"]
			local var_626_14 = 0

			if var_626_14 < arg_623_1.time_ and arg_623_1.time_ <= var_626_14 + arg_626_0 and arg_623_1.var_.actorSpriteComps1070 == nil then
				arg_623_1.var_.actorSpriteComps1070 = var_626_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_626_15 = 0.0166666666666667

			if var_626_14 <= arg_623_1.time_ and arg_623_1.time_ < var_626_14 + var_626_15 then
				local var_626_16 = (arg_623_1.time_ - var_626_14) / var_626_15

				if arg_623_1.var_.actorSpriteComps1070 then
					for iter_626_1, iter_626_2 in pairs(arg_623_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_626_2 then
							local var_626_17 = Mathf.Lerp(iter_626_2.color.r, 1, var_626_16)

							iter_626_2.color = Color.New(var_626_17, var_626_17, var_626_17)
						end
					end
				end
			end

			if arg_623_1.time_ >= var_626_14 + var_626_15 and arg_623_1.time_ < var_626_14 + var_626_15 + arg_626_0 and arg_623_1.var_.actorSpriteComps1070 then
				local var_626_18 = 1

				for iter_626_3, iter_626_4 in pairs(arg_623_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_626_4 then
						iter_626_4.color = Color.New(var_626_18, var_626_18, var_626_18)
					end
				end

				arg_623_1.var_.actorSpriteComps1070 = nil
			end

			local var_626_19 = 0
			local var_626_20 = 0.075

			if var_626_19 < arg_623_1.time_ and arg_623_1.time_ <= var_626_19 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_21 = arg_623_1:FormatText(StoryNameCfg[318].name)

				arg_623_1.leftNameTxt_.text = var_626_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_22 = arg_623_1:GetWordFromCfg(910110154)
				local var_626_23 = arg_623_1:FormatText(var_626_22.content)

				arg_623_1.text_.text = var_626_23

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_24 = 3
				local var_626_25 = utf8.len(var_626_23)
				local var_626_26 = var_626_24 <= 0 and var_626_20 or var_626_20 * (var_626_25 / var_626_24)

				if var_626_26 > 0 and var_626_20 < var_626_26 then
					arg_623_1.talkMaxDuration = var_626_26

					if var_626_26 + var_626_19 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_26 + var_626_19
					end
				end

				arg_623_1.text_.text = var_626_23
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_27 = math.max(var_626_20, arg_623_1.talkMaxDuration)

			if var_626_19 <= arg_623_1.time_ and arg_623_1.time_ < var_626_19 + var_626_27 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_19) / var_626_27

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_19 + var_626_27 and arg_623_1.time_ < var_626_19 + var_626_27 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end
	end,
	Play910110155 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 910110155
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play910110156(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1070"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and arg_627_1.var_.actorSpriteComps1070 == nil then
				arg_627_1.var_.actorSpriteComps1070 = var_630_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_2 = 0.2

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.actorSpriteComps1070 then
					for iter_630_0, iter_630_1 in pairs(arg_627_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_630_1 then
							local var_630_4 = Mathf.Lerp(iter_630_1.color.r, 0.5, var_630_3)

							iter_630_1.color = Color.New(var_630_4, var_630_4, var_630_4)
						end
					end
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and arg_627_1.var_.actorSpriteComps1070 then
				local var_630_5 = 0.5

				for iter_630_2, iter_630_3 in pairs(arg_627_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_630_3 then
						iter_630_3.color = Color.New(var_630_5, var_630_5, var_630_5)
					end
				end

				arg_627_1.var_.actorSpriteComps1070 = nil
			end

			local var_630_6 = 0
			local var_630_7 = 0.2

			if var_630_6 < arg_627_1.time_ and arg_627_1.time_ <= var_630_6 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_8 = arg_627_1:FormatText(StoryNameCfg[7].name)

				arg_627_1.leftNameTxt_.text = var_630_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_9 = arg_627_1:GetWordFromCfg(910110155)
				local var_630_10 = arg_627_1:FormatText(var_630_9.content)

				arg_627_1.text_.text = var_630_10

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_11 = 8
				local var_630_12 = utf8.len(var_630_10)
				local var_630_13 = var_630_11 <= 0 and var_630_7 or var_630_7 * (var_630_12 / var_630_11)

				if var_630_13 > 0 and var_630_7 < var_630_13 then
					arg_627_1.talkMaxDuration = var_630_13

					if var_630_13 + var_630_6 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_13 + var_630_6
					end
				end

				arg_627_1.text_.text = var_630_10
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_14 = math.max(var_630_7, arg_627_1.talkMaxDuration)

			if var_630_6 <= arg_627_1.time_ and arg_627_1.time_ < var_630_6 + var_630_14 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_6) / var_630_14

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_6 + var_630_14 and arg_627_1.time_ < var_630_6 + var_630_14 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end
	end,
	Play910110156 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 910110156
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play910110157(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1070"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and arg_631_1.var_.actorSpriteComps1070 == nil then
				arg_631_1.var_.actorSpriteComps1070 = var_634_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_634_2 = 0.2

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.actorSpriteComps1070 then
					for iter_634_0, iter_634_1 in pairs(arg_631_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_634_1 then
							local var_634_4 = Mathf.Lerp(iter_634_1.color.r, 1, var_634_3)

							iter_634_1.color = Color.New(var_634_4, var_634_4, var_634_4)
						end
					end
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and arg_631_1.var_.actorSpriteComps1070 then
				local var_634_5 = 1

				for iter_634_2, iter_634_3 in pairs(arg_631_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_634_3 then
						iter_634_3.color = Color.New(var_634_5, var_634_5, var_634_5)
					end
				end

				arg_631_1.var_.actorSpriteComps1070 = nil
			end

			local var_634_6 = 0
			local var_634_7 = 1.45

			if var_634_6 < arg_631_1.time_ and arg_631_1.time_ <= var_634_6 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_8 = arg_631_1:FormatText(StoryNameCfg[318].name)

				arg_631_1.leftNameTxt_.text = var_634_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_9 = arg_631_1:GetWordFromCfg(910110156)
				local var_634_10 = arg_631_1:FormatText(var_634_9.content)

				arg_631_1.text_.text = var_634_10

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_11 = 58
				local var_634_12 = utf8.len(var_634_10)
				local var_634_13 = var_634_11 <= 0 and var_634_7 or var_634_7 * (var_634_12 / var_634_11)

				if var_634_13 > 0 and var_634_7 < var_634_13 then
					arg_631_1.talkMaxDuration = var_634_13

					if var_634_13 + var_634_6 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_13 + var_634_6
					end
				end

				arg_631_1.text_.text = var_634_10
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_14 = math.max(var_634_7, arg_631_1.talkMaxDuration)

			if var_634_6 <= arg_631_1.time_ and arg_631_1.time_ < var_634_6 + var_634_14 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_6) / var_634_14

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_6 + var_634_14 and arg_631_1.time_ < var_634_6 + var_634_14 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end
	end,
	Play910110157 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 910110157
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play910110158(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["1070"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 and arg_635_1.var_.actorSpriteComps1070 == nil then
				arg_635_1.var_.actorSpriteComps1070 = var_638_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_638_2 = 0.2

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2

				if arg_635_1.var_.actorSpriteComps1070 then
					for iter_638_0, iter_638_1 in pairs(arg_635_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_638_1 then
							local var_638_4 = Mathf.Lerp(iter_638_1.color.r, 0.5, var_638_3)

							iter_638_1.color = Color.New(var_638_4, var_638_4, var_638_4)
						end
					end
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 and arg_635_1.var_.actorSpriteComps1070 then
				local var_638_5 = 0.5

				for iter_638_2, iter_638_3 in pairs(arg_635_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_638_3 then
						iter_638_3.color = Color.New(var_638_5, var_638_5, var_638_5)
					end
				end

				arg_635_1.var_.actorSpriteComps1070 = nil
			end

			local var_638_6 = 0
			local var_638_7 = 0.25

			if var_638_6 < arg_635_1.time_ and arg_635_1.time_ <= var_638_6 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_8 = arg_635_1:FormatText(StoryNameCfg[7].name)

				arg_635_1.leftNameTxt_.text = var_638_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_9 = arg_635_1:GetWordFromCfg(910110157)
				local var_638_10 = arg_635_1:FormatText(var_638_9.content)

				arg_635_1.text_.text = var_638_10

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_11 = 10
				local var_638_12 = utf8.len(var_638_10)
				local var_638_13 = var_638_11 <= 0 and var_638_7 or var_638_7 * (var_638_12 / var_638_11)

				if var_638_13 > 0 and var_638_7 < var_638_13 then
					arg_635_1.talkMaxDuration = var_638_13

					if var_638_13 + var_638_6 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_13 + var_638_6
					end
				end

				arg_635_1.text_.text = var_638_10
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_14 = math.max(var_638_7, arg_635_1.talkMaxDuration)

			if var_638_6 <= arg_635_1.time_ and arg_635_1.time_ < var_638_6 + var_638_14 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_6) / var_638_14

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_6 + var_638_14 and arg_635_1.time_ < var_638_6 + var_638_14 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end
	end,
	Play910110158 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 910110158
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play910110159(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 0.475

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_2 = arg_639_1:FormatText(StoryNameCfg[355].name)

				arg_639_1.leftNameTxt_.text = var_642_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_3 = arg_639_1:GetWordFromCfg(910110158)
				local var_642_4 = arg_639_1:FormatText(var_642_3.content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 19
				local var_642_6 = utf8.len(var_642_4)
				local var_642_7 = var_642_5 <= 0 and var_642_1 or var_642_1 * (var_642_6 / var_642_5)

				if var_642_7 > 0 and var_642_1 < var_642_7 then
					arg_639_1.talkMaxDuration = var_642_7

					if var_642_7 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_8 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_8 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_8

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_8 and arg_639_1.time_ < var_642_0 + var_642_8 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end
	end,
	Play910110159 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 910110159
		arg_643_1.duration_ = 7

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play910110160(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = "ST05"

			if arg_643_1.bgs_[var_646_0] == nil then
				local var_646_1 = Object.Instantiate(arg_643_1.paintGo_)

				var_646_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_646_0)
				var_646_1.name = var_646_0
				var_646_1.transform.parent = arg_643_1.stage_.transform
				var_646_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_643_1.bgs_[var_646_0] = var_646_1
			end

			local var_646_2 = 2

			if var_646_2 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				local var_646_3 = manager.ui.mainCamera.transform.localPosition
				local var_646_4 = Vector3.New(0, 0, 10) + Vector3.New(var_646_3.x, var_646_3.y, 0)
				local var_646_5 = arg_643_1.bgs_.ST05

				var_646_5.transform.localPosition = var_646_4
				var_646_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_646_6 = var_646_5:GetComponent("SpriteRenderer")

				if var_646_6 and var_646_6.sprite then
					local var_646_7 = (var_646_5.transform.localPosition - var_646_3).z
					local var_646_8 = manager.ui.mainCameraCom_
					local var_646_9 = 2 * var_646_7 * Mathf.Tan(var_646_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_646_10 = var_646_9 * var_646_8.aspect
					local var_646_11 = var_646_6.sprite.bounds.size.x
					local var_646_12 = var_646_6.sprite.bounds.size.y
					local var_646_13 = var_646_10 / var_646_11
					local var_646_14 = var_646_9 / var_646_12
					local var_646_15 = var_646_14 < var_646_13 and var_646_13 or var_646_14

					var_646_5.transform.localScale = Vector3.New(var_646_15, var_646_15, 0)
				end

				for iter_646_0, iter_646_1 in pairs(arg_643_1.bgs_) do
					if iter_646_0 ~= "ST05" then
						iter_646_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_646_16 = arg_643_1.actors_["1070"].transform
			local var_646_17 = 2

			if var_646_17 < arg_643_1.time_ and arg_643_1.time_ <= var_646_17 + arg_646_0 then
				arg_643_1.var_.moveOldPos1070 = var_646_16.localPosition
				var_646_16.localScale = Vector3.New(1, 1, 1)

				arg_643_1:CheckSpriteTmpPos("1070", 7)

				local var_646_18 = var_646_16.childCount

				for iter_646_2 = 0, var_646_18 - 1 do
					local var_646_19 = var_646_16:GetChild(iter_646_2)

					if var_646_19.name == "split_2" or not string.find(var_646_19.name, "split") then
						var_646_19.gameObject:SetActive(true)
					else
						var_646_19.gameObject:SetActive(false)
					end
				end
			end

			local var_646_20 = 0.001

			if var_646_17 <= arg_643_1.time_ and arg_643_1.time_ < var_646_17 + var_646_20 then
				local var_646_21 = (arg_643_1.time_ - var_646_17) / var_646_20
				local var_646_22 = Vector3.New(0, -2000, -180)

				var_646_16.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1070, var_646_22, var_646_21)
			end

			if arg_643_1.time_ >= var_646_17 + var_646_20 and arg_643_1.time_ < var_646_17 + var_646_20 + arg_646_0 then
				var_646_16.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_646_23 = 0

			if var_646_23 < arg_643_1.time_ and arg_643_1.time_ <= var_646_23 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_24 = 2

			if var_646_23 <= arg_643_1.time_ and arg_643_1.time_ < var_646_23 + var_646_24 then
				local var_646_25 = (arg_643_1.time_ - var_646_23) / var_646_24
				local var_646_26 = Color.New(0, 0, 0)

				var_646_26.a = Mathf.Lerp(0, 1, var_646_25)
				arg_643_1.mask_.color = var_646_26
			end

			if arg_643_1.time_ >= var_646_23 + var_646_24 and arg_643_1.time_ < var_646_23 + var_646_24 + arg_646_0 then
				local var_646_27 = Color.New(0, 0, 0)

				var_646_27.a = 1
				arg_643_1.mask_.color = var_646_27
			end

			local var_646_28 = 2

			if var_646_28 < arg_643_1.time_ and arg_643_1.time_ <= var_646_28 + arg_646_0 then
				arg_643_1.mask_.enabled = true
				arg_643_1.mask_.raycastTarget = true

				arg_643_1:SetGaussion(false)
			end

			local var_646_29 = 2

			if var_646_28 <= arg_643_1.time_ and arg_643_1.time_ < var_646_28 + var_646_29 then
				local var_646_30 = (arg_643_1.time_ - var_646_28) / var_646_29
				local var_646_31 = Color.New(0, 0, 0)

				var_646_31.a = Mathf.Lerp(1, 0, var_646_30)
				arg_643_1.mask_.color = var_646_31
			end

			if arg_643_1.time_ >= var_646_28 + var_646_29 and arg_643_1.time_ < var_646_28 + var_646_29 + arg_646_0 then
				local var_646_32 = Color.New(0, 0, 0)
				local var_646_33 = 0

				arg_643_1.mask_.enabled = false
				var_646_32.a = var_646_33
				arg_643_1.mask_.color = var_646_32
			end

			local var_646_34 = 2
			local var_646_35 = 1.225

			if var_646_34 < arg_643_1.time_ and arg_643_1.time_ <= var_646_34 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_36 = arg_643_1:GetWordFromCfg(910110159)
				local var_646_37 = arg_643_1:FormatText(var_646_36.content)

				arg_643_1.text_.text = var_646_37

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_38 = 49
				local var_646_39 = utf8.len(var_646_37)
				local var_646_40 = var_646_38 <= 0 and var_646_35 or var_646_35 * (var_646_39 / var_646_38)

				if var_646_40 > 0 and var_646_35 < var_646_40 then
					arg_643_1.talkMaxDuration = var_646_40

					if var_646_40 + var_646_34 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_40 + var_646_34
					end
				end

				arg_643_1.text_.text = var_646_37
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_41 = math.max(var_646_35, arg_643_1.talkMaxDuration)

			if var_646_34 <= arg_643_1.time_ and arg_643_1.time_ < var_646_34 + var_646_41 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_34) / var_646_41

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_34 + var_646_41 and arg_643_1.time_ < var_646_34 + var_646_41 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end
	end,
	Play910110160 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 910110160
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play910110161(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0
			local var_650_1 = 1.225

			if var_650_0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_2 = arg_647_1:GetWordFromCfg(910110160)
				local var_650_3 = arg_647_1:FormatText(var_650_2.content)

				arg_647_1.text_.text = var_650_3

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 49
				local var_650_5 = utf8.len(var_650_3)
				local var_650_6 = var_650_4 <= 0 and var_650_1 or var_650_1 * (var_650_5 / var_650_4)

				if var_650_6 > 0 and var_650_1 < var_650_6 then
					arg_647_1.talkMaxDuration = var_650_6

					if var_650_6 + var_650_0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_6 + var_650_0
					end
				end

				arg_647_1.text_.text = var_650_3
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_7 = math.max(var_650_1, arg_647_1.talkMaxDuration)

			if var_650_0 <= arg_647_1.time_ and arg_647_1.time_ < var_650_0 + var_650_7 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_0) / var_650_7

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_0 + var_650_7 and arg_647_1.time_ < var_650_0 + var_650_7 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end
	end,
	Play910110161 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 910110161
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play910110162(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = arg_651_1.actors_["1070"].transform
			local var_654_1 = 0

			if var_654_1 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 then
				arg_651_1.var_.moveOldPos1070 = var_654_0.localPosition
				var_654_0.localScale = Vector3.New(1, 1, 1)

				arg_651_1:CheckSpriteTmpPos("1070", 3)

				local var_654_2 = var_654_0.childCount

				for iter_654_0 = 0, var_654_2 - 1 do
					local var_654_3 = var_654_0:GetChild(iter_654_0)

					if var_654_3.name == "split_1" or not string.find(var_654_3.name, "split") then
						var_654_3.gameObject:SetActive(true)
					else
						var_654_3.gameObject:SetActive(false)
					end
				end
			end

			local var_654_4 = 0.001

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_4 then
				local var_654_5 = (arg_651_1.time_ - var_654_1) / var_654_4
				local var_654_6 = Vector3.New(0, -350, -180)

				var_654_0.localPosition = Vector3.Lerp(arg_651_1.var_.moveOldPos1070, var_654_6, var_654_5)
			end

			if arg_651_1.time_ >= var_654_1 + var_654_4 and arg_651_1.time_ < var_654_1 + var_654_4 + arg_654_0 then
				var_654_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_654_7 = arg_651_1.actors_["1070"]
			local var_654_8 = 0

			if var_654_8 < arg_651_1.time_ and arg_651_1.time_ <= var_654_8 + arg_654_0 and arg_651_1.var_.actorSpriteComps1070 == nil then
				arg_651_1.var_.actorSpriteComps1070 = var_654_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_654_9 = 0.0166666666666667

			if var_654_8 <= arg_651_1.time_ and arg_651_1.time_ < var_654_8 + var_654_9 then
				local var_654_10 = (arg_651_1.time_ - var_654_8) / var_654_9

				if arg_651_1.var_.actorSpriteComps1070 then
					for iter_654_1, iter_654_2 in pairs(arg_651_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_654_2 then
							local var_654_11 = Mathf.Lerp(iter_654_2.color.r, 1, var_654_10)

							iter_654_2.color = Color.New(var_654_11, var_654_11, var_654_11)
						end
					end
				end
			end

			if arg_651_1.time_ >= var_654_8 + var_654_9 and arg_651_1.time_ < var_654_8 + var_654_9 + arg_654_0 and arg_651_1.var_.actorSpriteComps1070 then
				local var_654_12 = 1

				for iter_654_3, iter_654_4 in pairs(arg_651_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_654_4 then
						iter_654_4.color = Color.New(var_654_12, var_654_12, var_654_12)
					end
				end

				arg_651_1.var_.actorSpriteComps1070 = nil
			end

			local var_654_13 = 0
			local var_654_14 = 0.575

			if var_654_13 < arg_651_1.time_ and arg_651_1.time_ <= var_654_13 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_15 = arg_651_1:FormatText(StoryNameCfg[318].name)

				arg_651_1.leftNameTxt_.text = var_654_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_16 = arg_651_1:GetWordFromCfg(910110161)
				local var_654_17 = arg_651_1:FormatText(var_654_16.content)

				arg_651_1.text_.text = var_654_17

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_18 = 23
				local var_654_19 = utf8.len(var_654_17)
				local var_654_20 = var_654_18 <= 0 and var_654_14 or var_654_14 * (var_654_19 / var_654_18)

				if var_654_20 > 0 and var_654_14 < var_654_20 then
					arg_651_1.talkMaxDuration = var_654_20

					if var_654_20 + var_654_13 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_20 + var_654_13
					end
				end

				arg_651_1.text_.text = var_654_17
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_21 = math.max(var_654_14, arg_651_1.talkMaxDuration)

			if var_654_13 <= arg_651_1.time_ and arg_651_1.time_ < var_654_13 + var_654_21 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_13) / var_654_21

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_13 + var_654_21 and arg_651_1.time_ < var_654_13 + var_654_21 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end
	end,
	Play910110162 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 910110162
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play910110163(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = arg_655_1.actors_["1070"]
			local var_658_1 = 0

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 and arg_655_1.var_.actorSpriteComps1070 == nil then
				arg_655_1.var_.actorSpriteComps1070 = var_658_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_2 = 0.2

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_2 then
				local var_658_3 = (arg_655_1.time_ - var_658_1) / var_658_2

				if arg_655_1.var_.actorSpriteComps1070 then
					for iter_658_0, iter_658_1 in pairs(arg_655_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_658_1 then
							local var_658_4 = Mathf.Lerp(iter_658_1.color.r, 0.5, var_658_3)

							iter_658_1.color = Color.New(var_658_4, var_658_4, var_658_4)
						end
					end
				end
			end

			if arg_655_1.time_ >= var_658_1 + var_658_2 and arg_655_1.time_ < var_658_1 + var_658_2 + arg_658_0 and arg_655_1.var_.actorSpriteComps1070 then
				local var_658_5 = 0.5

				for iter_658_2, iter_658_3 in pairs(arg_655_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_658_3 then
						iter_658_3.color = Color.New(var_658_5, var_658_5, var_658_5)
					end
				end

				arg_655_1.var_.actorSpriteComps1070 = nil
			end

			local var_658_6 = 0
			local var_658_7 = 0.225

			if var_658_6 < arg_655_1.time_ and arg_655_1.time_ <= var_658_6 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_8 = arg_655_1:FormatText(StoryNameCfg[7].name)

				arg_655_1.leftNameTxt_.text = var_658_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_9 = arg_655_1:GetWordFromCfg(910110162)
				local var_658_10 = arg_655_1:FormatText(var_658_9.content)

				arg_655_1.text_.text = var_658_10

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_11 = 9
				local var_658_12 = utf8.len(var_658_10)
				local var_658_13 = var_658_11 <= 0 and var_658_7 or var_658_7 * (var_658_12 / var_658_11)

				if var_658_13 > 0 and var_658_7 < var_658_13 then
					arg_655_1.talkMaxDuration = var_658_13

					if var_658_13 + var_658_6 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_13 + var_658_6
					end
				end

				arg_655_1.text_.text = var_658_10
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_14 = math.max(var_658_7, arg_655_1.talkMaxDuration)

			if var_658_6 <= arg_655_1.time_ and arg_655_1.time_ < var_658_6 + var_658_14 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_6) / var_658_14

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_6 + var_658_14 and arg_655_1.time_ < var_658_6 + var_658_14 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end
	end,
	Play910110163 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 910110163
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play910110164(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = 0
			local var_662_1 = 0.3

			if var_662_0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_0 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_2 = arg_659_1:FormatText(StoryNameCfg[355].name)

				arg_659_1.leftNameTxt_.text = var_662_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_3 = arg_659_1:GetWordFromCfg(910110163)
				local var_662_4 = arg_659_1:FormatText(var_662_3.content)

				arg_659_1.text_.text = var_662_4

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_5 = 12
				local var_662_6 = utf8.len(var_662_4)
				local var_662_7 = var_662_5 <= 0 and var_662_1 or var_662_1 * (var_662_6 / var_662_5)

				if var_662_7 > 0 and var_662_1 < var_662_7 then
					arg_659_1.talkMaxDuration = var_662_7

					if var_662_7 + var_662_0 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_7 + var_662_0
					end
				end

				arg_659_1.text_.text = var_662_4
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_8 = math.max(var_662_1, arg_659_1.talkMaxDuration)

			if var_662_0 <= arg_659_1.time_ and arg_659_1.time_ < var_662_0 + var_662_8 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_0) / var_662_8

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_0 + var_662_8 and arg_659_1.time_ < var_662_0 + var_662_8 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end
	end,
	Play910110164 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 910110164
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play910110165(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0
			local var_666_1 = 0.65

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_2 = arg_663_1:FormatText(StoryNameCfg[354].name)

				arg_663_1.leftNameTxt_.text = var_666_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_3 = arg_663_1:GetWordFromCfg(910110164)
				local var_666_4 = arg_663_1:FormatText(var_666_3.content)

				arg_663_1.text_.text = var_666_4

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_5 = 26
				local var_666_6 = utf8.len(var_666_4)
				local var_666_7 = var_666_5 <= 0 and var_666_1 or var_666_1 * (var_666_6 / var_666_5)

				if var_666_7 > 0 and var_666_1 < var_666_7 then
					arg_663_1.talkMaxDuration = var_666_7

					if var_666_7 + var_666_0 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_7 + var_666_0
					end
				end

				arg_663_1.text_.text = var_666_4
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_8 = math.max(var_666_1, arg_663_1.talkMaxDuration)

			if var_666_0 <= arg_663_1.time_ and arg_663_1.time_ < var_666_0 + var_666_8 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_0) / var_666_8

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_0 + var_666_8 and arg_663_1.time_ < var_666_0 + var_666_8 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end
	end,
	Play910110165 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 910110165
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play910110166(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["1070"]
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 and arg_667_1.var_.actorSpriteComps1070 == nil then
				arg_667_1.var_.actorSpriteComps1070 = var_670_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_670_2 = 0.2

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2

				if arg_667_1.var_.actorSpriteComps1070 then
					for iter_670_0, iter_670_1 in pairs(arg_667_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_670_1 then
							local var_670_4 = Mathf.Lerp(iter_670_1.color.r, 1, var_670_3)

							iter_670_1.color = Color.New(var_670_4, var_670_4, var_670_4)
						end
					end
				end
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 and arg_667_1.var_.actorSpriteComps1070 then
				local var_670_5 = 1

				for iter_670_2, iter_670_3 in pairs(arg_667_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_670_3 then
						iter_670_3.color = Color.New(var_670_5, var_670_5, var_670_5)
					end
				end

				arg_667_1.var_.actorSpriteComps1070 = nil
			end

			local var_670_6 = 0
			local var_670_7 = 0.175

			if var_670_6 < arg_667_1.time_ and arg_667_1.time_ <= var_670_6 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_8 = arg_667_1:FormatText(StoryNameCfg[318].name)

				arg_667_1.leftNameTxt_.text = var_670_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_9 = arg_667_1:GetWordFromCfg(910110165)
				local var_670_10 = arg_667_1:FormatText(var_670_9.content)

				arg_667_1.text_.text = var_670_10

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_11 = 7
				local var_670_12 = utf8.len(var_670_10)
				local var_670_13 = var_670_11 <= 0 and var_670_7 or var_670_7 * (var_670_12 / var_670_11)

				if var_670_13 > 0 and var_670_7 < var_670_13 then
					arg_667_1.talkMaxDuration = var_670_13

					if var_670_13 + var_670_6 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_13 + var_670_6
					end
				end

				arg_667_1.text_.text = var_670_10
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_14 = math.max(var_670_7, arg_667_1.talkMaxDuration)

			if var_670_6 <= arg_667_1.time_ and arg_667_1.time_ < var_670_6 + var_670_14 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_6) / var_670_14

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_6 + var_670_14 and arg_667_1.time_ < var_670_6 + var_670_14 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end
	end,
	Play910110166 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 910110166
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play910110167(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0
			local var_674_1 = 0.6

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_2 = arg_671_1:FormatText(StoryNameCfg[318].name)

				arg_671_1.leftNameTxt_.text = var_674_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_3 = arg_671_1:GetWordFromCfg(910110166)
				local var_674_4 = arg_671_1:FormatText(var_674_3.content)

				arg_671_1.text_.text = var_674_4

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_5 = 24
				local var_674_6 = utf8.len(var_674_4)
				local var_674_7 = var_674_5 <= 0 and var_674_1 or var_674_1 * (var_674_6 / var_674_5)

				if var_674_7 > 0 and var_674_1 < var_674_7 then
					arg_671_1.talkMaxDuration = var_674_7

					if var_674_7 + var_674_0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_7 + var_674_0
					end
				end

				arg_671_1.text_.text = var_674_4
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_8 = math.max(var_674_1, arg_671_1.talkMaxDuration)

			if var_674_0 <= arg_671_1.time_ and arg_671_1.time_ < var_674_0 + var_674_8 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_0) / var_674_8

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_0 + var_674_8 and arg_671_1.time_ < var_674_0 + var_674_8 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end
	end,
	Play910110167 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 910110167
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play910110168(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = arg_675_1.actors_["1070"]
			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 and arg_675_1.var_.actorSpriteComps1070 == nil then
				arg_675_1.var_.actorSpriteComps1070 = var_678_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_678_2 = 0.2

			if var_678_1 <= arg_675_1.time_ and arg_675_1.time_ < var_678_1 + var_678_2 then
				local var_678_3 = (arg_675_1.time_ - var_678_1) / var_678_2

				if arg_675_1.var_.actorSpriteComps1070 then
					for iter_678_0, iter_678_1 in pairs(arg_675_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_678_1 then
							local var_678_4 = Mathf.Lerp(iter_678_1.color.r, 0.5, var_678_3)

							iter_678_1.color = Color.New(var_678_4, var_678_4, var_678_4)
						end
					end
				end
			end

			if arg_675_1.time_ >= var_678_1 + var_678_2 and arg_675_1.time_ < var_678_1 + var_678_2 + arg_678_0 and arg_675_1.var_.actorSpriteComps1070 then
				local var_678_5 = 0.5

				for iter_678_2, iter_678_3 in pairs(arg_675_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_678_3 then
						iter_678_3.color = Color.New(var_678_5, var_678_5, var_678_5)
					end
				end

				arg_675_1.var_.actorSpriteComps1070 = nil
			end

			local var_678_6 = 0
			local var_678_7 = 0.575

			if var_678_6 < arg_675_1.time_ and arg_675_1.time_ <= var_678_6 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_8 = arg_675_1:FormatText(StoryNameCfg[7].name)

				arg_675_1.leftNameTxt_.text = var_678_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_9 = arg_675_1:GetWordFromCfg(910110167)
				local var_678_10 = arg_675_1:FormatText(var_678_9.content)

				arg_675_1.text_.text = var_678_10

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_11 = 23
				local var_678_12 = utf8.len(var_678_10)
				local var_678_13 = var_678_11 <= 0 and var_678_7 or var_678_7 * (var_678_12 / var_678_11)

				if var_678_13 > 0 and var_678_7 < var_678_13 then
					arg_675_1.talkMaxDuration = var_678_13

					if var_678_13 + var_678_6 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_13 + var_678_6
					end
				end

				arg_675_1.text_.text = var_678_10
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_14 = math.max(var_678_7, arg_675_1.talkMaxDuration)

			if var_678_6 <= arg_675_1.time_ and arg_675_1.time_ < var_678_6 + var_678_14 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_6) / var_678_14

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_6 + var_678_14 and arg_675_1.time_ < var_678_6 + var_678_14 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end
	end,
	Play910110168 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 910110168
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play910110169(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = 0
			local var_682_1 = 0.15

			if var_682_0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_0 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				local var_682_2 = arg_679_1:FormatText(StoryNameCfg[354].name)

				arg_679_1.leftNameTxt_.text = var_682_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, true)
				arg_679_1.iconController_:SetSelectedState("hero")

				arg_679_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_3 = arg_679_1:GetWordFromCfg(910110168)
				local var_682_4 = arg_679_1:FormatText(var_682_3.content)

				arg_679_1.text_.text = var_682_4

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_5 = 6
				local var_682_6 = utf8.len(var_682_4)
				local var_682_7 = var_682_5 <= 0 and var_682_1 or var_682_1 * (var_682_6 / var_682_5)

				if var_682_7 > 0 and var_682_1 < var_682_7 then
					arg_679_1.talkMaxDuration = var_682_7

					if var_682_7 + var_682_0 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_7 + var_682_0
					end
				end

				arg_679_1.text_.text = var_682_4
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_8 = math.max(var_682_1, arg_679_1.talkMaxDuration)

			if var_682_0 <= arg_679_1.time_ and arg_679_1.time_ < var_682_0 + var_682_8 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_0) / var_682_8

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_0 + var_682_8 and arg_679_1.time_ < var_682_0 + var_682_8 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end
	end,
	Play910110169 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 910110169
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play910110170(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 0.575

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_2 = arg_683_1:FormatText(StoryNameCfg[355].name)

				arg_683_1.leftNameTxt_.text = var_686_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_3 = arg_683_1:GetWordFromCfg(910110169)
				local var_686_4 = arg_683_1:FormatText(var_686_3.content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 23
				local var_686_6 = utf8.len(var_686_4)
				local var_686_7 = var_686_5 <= 0 and var_686_1 or var_686_1 * (var_686_6 / var_686_5)

				if var_686_7 > 0 and var_686_1 < var_686_7 then
					arg_683_1.talkMaxDuration = var_686_7

					if var_686_7 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_7 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_8 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_8 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_8

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_8 and arg_683_1.time_ < var_686_0 + var_686_8 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end
	end,
	Play910110170 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 910110170
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play910110171(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = 0
			local var_690_1 = 1.725

			if var_690_0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_0 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_2 = arg_687_1:FormatText(StoryNameCfg[354].name)

				arg_687_1.leftNameTxt_.text = var_690_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, true)
				arg_687_1.iconController_:SetSelectedState("hero")

				arg_687_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_3 = arg_687_1:GetWordFromCfg(910110170)
				local var_690_4 = arg_687_1:FormatText(var_690_3.content)

				arg_687_1.text_.text = var_690_4

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_5 = 69
				local var_690_6 = utf8.len(var_690_4)
				local var_690_7 = var_690_5 <= 0 and var_690_1 or var_690_1 * (var_690_6 / var_690_5)

				if var_690_7 > 0 and var_690_1 < var_690_7 then
					arg_687_1.talkMaxDuration = var_690_7

					if var_690_7 + var_690_0 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_7 + var_690_0
					end
				end

				arg_687_1.text_.text = var_690_4
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_8 = math.max(var_690_1, arg_687_1.talkMaxDuration)

			if var_690_0 <= arg_687_1.time_ and arg_687_1.time_ < var_690_0 + var_690_8 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_0) / var_690_8

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_0 + var_690_8 and arg_687_1.time_ < var_690_0 + var_690_8 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end
	end,
	Play910110171 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 910110171
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play910110172(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["1070"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and arg_691_1.var_.actorSpriteComps1070 == nil then
				arg_691_1.var_.actorSpriteComps1070 = var_694_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_2 = 0.2

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.actorSpriteComps1070 then
					for iter_694_0, iter_694_1 in pairs(arg_691_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_694_1 then
							local var_694_4 = Mathf.Lerp(iter_694_1.color.r, 1, var_694_3)

							iter_694_1.color = Color.New(var_694_4, var_694_4, var_694_4)
						end
					end
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and arg_691_1.var_.actorSpriteComps1070 then
				local var_694_5 = 1

				for iter_694_2, iter_694_3 in pairs(arg_691_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_694_3 then
						iter_694_3.color = Color.New(var_694_5, var_694_5, var_694_5)
					end
				end

				arg_691_1.var_.actorSpriteComps1070 = nil
			end

			local var_694_6 = 0
			local var_694_7 = 0.75

			if var_694_6 < arg_691_1.time_ and arg_691_1.time_ <= var_694_6 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_8 = arg_691_1:FormatText(StoryNameCfg[318].name)

				arg_691_1.leftNameTxt_.text = var_694_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_9 = arg_691_1:GetWordFromCfg(910110171)
				local var_694_10 = arg_691_1:FormatText(var_694_9.content)

				arg_691_1.text_.text = var_694_10

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_11 = 26
				local var_694_12 = utf8.len(var_694_10)
				local var_694_13 = var_694_11 <= 0 and var_694_7 or var_694_7 * (var_694_12 / var_694_11)

				if var_694_13 > 0 and var_694_7 < var_694_13 then
					arg_691_1.talkMaxDuration = var_694_13

					if var_694_13 + var_694_6 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_6
					end
				end

				arg_691_1.text_.text = var_694_10
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_14 = math.max(var_694_7, arg_691_1.talkMaxDuration)

			if var_694_6 <= arg_691_1.time_ and arg_691_1.time_ < var_694_6 + var_694_14 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_6) / var_694_14

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_6 + var_694_14 and arg_691_1.time_ < var_694_6 + var_694_14 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end
	end,
	Play910110172 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 910110172
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play910110173(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1070"]
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 and arg_695_1.var_.actorSpriteComps1070 == nil then
				arg_695_1.var_.actorSpriteComps1070 = var_698_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_698_2 = 0.2

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2

				if arg_695_1.var_.actorSpriteComps1070 then
					for iter_698_0, iter_698_1 in pairs(arg_695_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_698_1 then
							local var_698_4 = Mathf.Lerp(iter_698_1.color.r, 0.5, var_698_3)

							iter_698_1.color = Color.New(var_698_4, var_698_4, var_698_4)
						end
					end
				end
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 and arg_695_1.var_.actorSpriteComps1070 then
				local var_698_5 = 0.5

				for iter_698_2, iter_698_3 in pairs(arg_695_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_698_3 then
						iter_698_3.color = Color.New(var_698_5, var_698_5, var_698_5)
					end
				end

				arg_695_1.var_.actorSpriteComps1070 = nil
			end

			local var_698_6 = 0
			local var_698_7 = 0.4

			if var_698_6 < arg_695_1.time_ and arg_695_1.time_ <= var_698_6 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_8 = arg_695_1:FormatText(StoryNameCfg[354].name)

				arg_695_1.leftNameTxt_.text = var_698_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, true)
				arg_695_1.iconController_:SetSelectedState("hero")

				arg_695_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_9 = arg_695_1:GetWordFromCfg(910110172)
				local var_698_10 = arg_695_1:FormatText(var_698_9.content)

				arg_695_1.text_.text = var_698_10

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_11 = 16
				local var_698_12 = utf8.len(var_698_10)
				local var_698_13 = var_698_11 <= 0 and var_698_7 or var_698_7 * (var_698_12 / var_698_11)

				if var_698_13 > 0 and var_698_7 < var_698_13 then
					arg_695_1.talkMaxDuration = var_698_13

					if var_698_13 + var_698_6 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_13 + var_698_6
					end
				end

				arg_695_1.text_.text = var_698_10
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_14 = math.max(var_698_7, arg_695_1.talkMaxDuration)

			if var_698_6 <= arg_695_1.time_ and arg_695_1.time_ < var_698_6 + var_698_14 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_6) / var_698_14

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_6 + var_698_14 and arg_695_1.time_ < var_698_6 + var_698_14 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end
	end,
	Play910110173 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 910110173
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play910110174(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1070"]
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 and arg_699_1.var_.actorSpriteComps1070 == nil then
				arg_699_1.var_.actorSpriteComps1070 = var_702_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_2 = 0.2

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2

				if arg_699_1.var_.actorSpriteComps1070 then
					for iter_702_0, iter_702_1 in pairs(arg_699_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_702_1 then
							local var_702_4 = Mathf.Lerp(iter_702_1.color.r, 1, var_702_3)

							iter_702_1.color = Color.New(var_702_4, var_702_4, var_702_4)
						end
					end
				end
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 and arg_699_1.var_.actorSpriteComps1070 then
				local var_702_5 = 1

				for iter_702_2, iter_702_3 in pairs(arg_699_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_702_3 then
						iter_702_3.color = Color.New(var_702_5, var_702_5, var_702_5)
					end
				end

				arg_699_1.var_.actorSpriteComps1070 = nil
			end

			local var_702_6 = 0
			local var_702_7 = 0.1

			if var_702_6 < arg_699_1.time_ and arg_699_1.time_ <= var_702_6 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				local var_702_8 = arg_699_1:FormatText(StoryNameCfg[318].name)

				arg_699_1.leftNameTxt_.text = var_702_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_9 = arg_699_1:GetWordFromCfg(910110173)
				local var_702_10 = arg_699_1:FormatText(var_702_9.content)

				arg_699_1.text_.text = var_702_10

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_11 = 4
				local var_702_12 = utf8.len(var_702_10)
				local var_702_13 = var_702_11 <= 0 and var_702_7 or var_702_7 * (var_702_12 / var_702_11)

				if var_702_13 > 0 and var_702_7 < var_702_13 then
					arg_699_1.talkMaxDuration = var_702_13

					if var_702_13 + var_702_6 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_13 + var_702_6
					end
				end

				arg_699_1.text_.text = var_702_10
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_14 = math.max(var_702_7, arg_699_1.talkMaxDuration)

			if var_702_6 <= arg_699_1.time_ and arg_699_1.time_ < var_702_6 + var_702_14 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_6) / var_702_14

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_6 + var_702_14 and arg_699_1.time_ < var_702_6 + var_702_14 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end
	end,
	Play910110174 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 910110174
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play910110175(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = arg_703_1.actors_["1070"].transform
			local var_706_1 = 0

			if var_706_1 < arg_703_1.time_ and arg_703_1.time_ <= var_706_1 + arg_706_0 then
				arg_703_1.var_.moveOldPos1070 = var_706_0.localPosition
				var_706_0.localScale = Vector3.New(1, 1, 1)

				arg_703_1:CheckSpriteTmpPos("1070", 7)

				local var_706_2 = var_706_0.childCount

				for iter_706_0 = 0, var_706_2 - 1 do
					local var_706_3 = var_706_0:GetChild(iter_706_0)

					if var_706_3.name == "split_1" or not string.find(var_706_3.name, "split") then
						var_706_3.gameObject:SetActive(true)
					else
						var_706_3.gameObject:SetActive(false)
					end
				end
			end

			local var_706_4 = 0.001

			if var_706_1 <= arg_703_1.time_ and arg_703_1.time_ < var_706_1 + var_706_4 then
				local var_706_5 = (arg_703_1.time_ - var_706_1) / var_706_4
				local var_706_6 = Vector3.New(0, -2000, -180)

				var_706_0.localPosition = Vector3.Lerp(arg_703_1.var_.moveOldPos1070, var_706_6, var_706_5)
			end

			if arg_703_1.time_ >= var_706_1 + var_706_4 and arg_703_1.time_ < var_706_1 + var_706_4 + arg_706_0 then
				var_706_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_706_7 = 0
			local var_706_8 = 0.25

			if var_706_7 < arg_703_1.time_ and arg_703_1.time_ <= var_706_7 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_9 = arg_703_1:FormatText(StoryNameCfg[7].name)

				arg_703_1.leftNameTxt_.text = var_706_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_10 = arg_703_1:GetWordFromCfg(910110174)
				local var_706_11 = arg_703_1:FormatText(var_706_10.content)

				arg_703_1.text_.text = var_706_11

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_12 = 10
				local var_706_13 = utf8.len(var_706_11)
				local var_706_14 = var_706_12 <= 0 and var_706_8 or var_706_8 * (var_706_13 / var_706_12)

				if var_706_14 > 0 and var_706_8 < var_706_14 then
					arg_703_1.talkMaxDuration = var_706_14

					if var_706_14 + var_706_7 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_14 + var_706_7
					end
				end

				arg_703_1.text_.text = var_706_11
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_15 = math.max(var_706_8, arg_703_1.talkMaxDuration)

			if var_706_7 <= arg_703_1.time_ and arg_703_1.time_ < var_706_7 + var_706_15 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_7) / var_706_15

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_7 + var_706_15 and arg_703_1.time_ < var_706_7 + var_706_15 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end
	end,
	Play910110175 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 910110175
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play910110176(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0
			local var_710_1 = 0.25

			if var_710_0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_2 = arg_707_1:FormatText(StoryNameCfg[355].name)

				arg_707_1.leftNameTxt_.text = var_710_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, true)
				arg_707_1.iconController_:SetSelectedState("hero")

				arg_707_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_3 = arg_707_1:GetWordFromCfg(910110175)
				local var_710_4 = arg_707_1:FormatText(var_710_3.content)

				arg_707_1.text_.text = var_710_4

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_5 = 10
				local var_710_6 = utf8.len(var_710_4)
				local var_710_7 = var_710_5 <= 0 and var_710_1 or var_710_1 * (var_710_6 / var_710_5)

				if var_710_7 > 0 and var_710_1 < var_710_7 then
					arg_707_1.talkMaxDuration = var_710_7

					if var_710_7 + var_710_0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_7 + var_710_0
					end
				end

				arg_707_1.text_.text = var_710_4
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_8 = math.max(var_710_1, arg_707_1.talkMaxDuration)

			if var_710_0 <= arg_707_1.time_ and arg_707_1.time_ < var_710_0 + var_710_8 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_0) / var_710_8

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_0 + var_710_8 and arg_707_1.time_ < var_710_0 + var_710_8 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end
	end,
	Play910110176 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 910110176
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play910110177(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0
			local var_714_1 = 0.525

			if var_714_0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_2 = arg_711_1:FormatText(StoryNameCfg[354].name)

				arg_711_1.leftNameTxt_.text = var_714_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, true)
				arg_711_1.iconController_:SetSelectedState("hero")

				arg_711_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_3 = arg_711_1:GetWordFromCfg(910110176)
				local var_714_4 = arg_711_1:FormatText(var_714_3.content)

				arg_711_1.text_.text = var_714_4

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_5 = 21
				local var_714_6 = utf8.len(var_714_4)
				local var_714_7 = var_714_5 <= 0 and var_714_1 or var_714_1 * (var_714_6 / var_714_5)

				if var_714_7 > 0 and var_714_1 < var_714_7 then
					arg_711_1.talkMaxDuration = var_714_7

					if var_714_7 + var_714_0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_7 + var_714_0
					end
				end

				arg_711_1.text_.text = var_714_4
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_8 = math.max(var_714_1, arg_711_1.talkMaxDuration)

			if var_714_0 <= arg_711_1.time_ and arg_711_1.time_ < var_714_0 + var_714_8 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_0) / var_714_8

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_0 + var_714_8 and arg_711_1.time_ < var_714_0 + var_714_8 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end
	end,
	Play910110177 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 910110177
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play910110178(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0
			local var_718_1 = 0.275

			if var_718_0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				local var_718_2 = arg_715_1:FormatText(StoryNameCfg[354].name)

				arg_715_1.leftNameTxt_.text = var_718_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, true)
				arg_715_1.iconController_:SetSelectedState("hero")

				arg_715_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6063")

				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_3 = arg_715_1:GetWordFromCfg(910110177)
				local var_718_4 = arg_715_1:FormatText(var_718_3.content)

				arg_715_1.text_.text = var_718_4

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_5 = 11
				local var_718_6 = utf8.len(var_718_4)
				local var_718_7 = var_718_5 <= 0 and var_718_1 or var_718_1 * (var_718_6 / var_718_5)

				if var_718_7 > 0 and var_718_1 < var_718_7 then
					arg_715_1.talkMaxDuration = var_718_7

					if var_718_7 + var_718_0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_7 + var_718_0
					end
				end

				arg_715_1.text_.text = var_718_4
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_8 = math.max(var_718_1, arg_715_1.talkMaxDuration)

			if var_718_0 <= arg_715_1.time_ and arg_715_1.time_ < var_718_0 + var_718_8 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_0) / var_718_8

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_0 + var_718_8 and arg_715_1.time_ < var_718_0 + var_718_8 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end
	end,
	Play910110178 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 910110178
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play910110179(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0
			local var_722_1 = 1.75

			if var_722_0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, false)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_2 = arg_719_1:GetWordFromCfg(910110178)
				local var_722_3 = arg_719_1:FormatText(var_722_2.content)

				arg_719_1.text_.text = var_722_3

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_4 = 70
				local var_722_5 = utf8.len(var_722_3)
				local var_722_6 = var_722_4 <= 0 and var_722_1 or var_722_1 * (var_722_5 / var_722_4)

				if var_722_6 > 0 and var_722_1 < var_722_6 then
					arg_719_1.talkMaxDuration = var_722_6

					if var_722_6 + var_722_0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_6 + var_722_0
					end
				end

				arg_719_1.text_.text = var_722_3
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_7 = math.max(var_722_1, arg_719_1.talkMaxDuration)

			if var_722_0 <= arg_719_1.time_ and arg_719_1.time_ < var_722_0 + var_722_7 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_0) / var_722_7

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_0 + var_722_7 and arg_719_1.time_ < var_722_0 + var_722_7 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end
	end,
	Play910110179 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 910110179
		arg_723_1.duration_ = 7

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play910110180(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = "ST02"

			if arg_723_1.bgs_[var_726_0] == nil then
				local var_726_1 = Object.Instantiate(arg_723_1.paintGo_)

				var_726_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_726_0)
				var_726_1.name = var_726_0
				var_726_1.transform.parent = arg_723_1.stage_.transform
				var_726_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_723_1.bgs_[var_726_0] = var_726_1
			end

			local var_726_2 = 2

			if var_726_2 < arg_723_1.time_ and arg_723_1.time_ <= var_726_2 + arg_726_0 then
				local var_726_3 = manager.ui.mainCamera.transform.localPosition
				local var_726_4 = Vector3.New(0, 0, 10) + Vector3.New(var_726_3.x, var_726_3.y, 0)
				local var_726_5 = arg_723_1.bgs_.ST02

				var_726_5.transform.localPosition = var_726_4
				var_726_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_726_6 = var_726_5:GetComponent("SpriteRenderer")

				if var_726_6 and var_726_6.sprite then
					local var_726_7 = (var_726_5.transform.localPosition - var_726_3).z
					local var_726_8 = manager.ui.mainCameraCom_
					local var_726_9 = 2 * var_726_7 * Mathf.Tan(var_726_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_726_10 = var_726_9 * var_726_8.aspect
					local var_726_11 = var_726_6.sprite.bounds.size.x
					local var_726_12 = var_726_6.sprite.bounds.size.y
					local var_726_13 = var_726_10 / var_726_11
					local var_726_14 = var_726_9 / var_726_12
					local var_726_15 = var_726_14 < var_726_13 and var_726_13 or var_726_14

					var_726_5.transform.localScale = Vector3.New(var_726_15, var_726_15, 0)
				end

				for iter_726_0, iter_726_1 in pairs(arg_723_1.bgs_) do
					if iter_726_0 ~= "ST02" then
						iter_726_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_726_16 = 0

			if var_726_16 < arg_723_1.time_ and arg_723_1.time_ <= var_726_16 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_17 = 2

			if var_726_16 <= arg_723_1.time_ and arg_723_1.time_ < var_726_16 + var_726_17 then
				local var_726_18 = (arg_723_1.time_ - var_726_16) / var_726_17
				local var_726_19 = Color.New(0, 0, 0)

				var_726_19.a = Mathf.Lerp(0, 1, var_726_18)
				arg_723_1.mask_.color = var_726_19
			end

			if arg_723_1.time_ >= var_726_16 + var_726_17 and arg_723_1.time_ < var_726_16 + var_726_17 + arg_726_0 then
				local var_726_20 = Color.New(0, 0, 0)

				var_726_20.a = 1
				arg_723_1.mask_.color = var_726_20
			end

			local var_726_21 = 2

			if var_726_21 < arg_723_1.time_ and arg_723_1.time_ <= var_726_21 + arg_726_0 then
				arg_723_1.mask_.enabled = true
				arg_723_1.mask_.raycastTarget = true

				arg_723_1:SetGaussion(false)
			end

			local var_726_22 = 2

			if var_726_21 <= arg_723_1.time_ and arg_723_1.time_ < var_726_21 + var_726_22 then
				local var_726_23 = (arg_723_1.time_ - var_726_21) / var_726_22
				local var_726_24 = Color.New(0, 0, 0)

				var_726_24.a = Mathf.Lerp(1, 0, var_726_23)
				arg_723_1.mask_.color = var_726_24
			end

			if arg_723_1.time_ >= var_726_21 + var_726_22 and arg_723_1.time_ < var_726_21 + var_726_22 + arg_726_0 then
				local var_726_25 = Color.New(0, 0, 0)
				local var_726_26 = 0

				arg_723_1.mask_.enabled = false
				var_726_25.a = var_726_26
				arg_723_1.mask_.color = var_726_25
			end

			if arg_723_1.frameCnt_ <= 1 then
				arg_723_1.dialog_:SetActive(false)
			end

			local var_726_27 = 2
			local var_726_28 = 1.275

			if var_726_27 < arg_723_1.time_ and arg_723_1.time_ <= var_726_27 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0

				arg_723_1.dialog_:SetActive(true)

				local var_726_29 = LeanTween.value(arg_723_1.dialog_, 0, 1, 0.3)

				var_726_29:setOnUpdate(LuaHelper.FloatAction(function(arg_727_0)
					arg_723_1.dialogCg_.alpha = arg_727_0
				end))
				var_726_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_723_1.dialog_)
					var_726_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_723_1.duration_ = arg_723_1.duration_ + 0.3

				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_30 = arg_723_1:GetWordFromCfg(910110179)
				local var_726_31 = arg_723_1:FormatText(var_726_30.content)

				arg_723_1.text_.text = var_726_31

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_32 = 51
				local var_726_33 = utf8.len(var_726_31)
				local var_726_34 = var_726_32 <= 0 and var_726_28 or var_726_28 * (var_726_33 / var_726_32)

				if var_726_34 > 0 and var_726_28 < var_726_34 then
					arg_723_1.talkMaxDuration = var_726_34
					var_726_27 = var_726_27 + 0.3

					if var_726_34 + var_726_27 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_34 + var_726_27
					end
				end

				arg_723_1.text_.text = var_726_31
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_35 = var_726_27 + 0.3
			local var_726_36 = math.max(var_726_28, arg_723_1.talkMaxDuration)

			if var_726_35 <= arg_723_1.time_ and arg_723_1.time_ < var_726_35 + var_726_36 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_35) / var_726_36

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_35 + var_726_36 and arg_723_1.time_ < var_726_35 + var_726_36 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end
	end,
	Play910110180 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 910110180
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play910110181(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = 0
			local var_732_1 = 1.025

			if var_732_0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_2 = arg_729_1:FormatText(StoryNameCfg[355].name)

				arg_729_1.leftNameTxt_.text = var_732_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, true)
				arg_729_1.iconController_:SetSelectedState("hero")

				arg_729_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_3 = arg_729_1:GetWordFromCfg(910110180)
				local var_732_4 = arg_729_1:FormatText(var_732_3.content)

				arg_729_1.text_.text = var_732_4

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 41
				local var_732_6 = utf8.len(var_732_4)
				local var_732_7 = var_732_5 <= 0 and var_732_1 or var_732_1 * (var_732_6 / var_732_5)

				if var_732_7 > 0 and var_732_1 < var_732_7 then
					arg_729_1.talkMaxDuration = var_732_7

					if var_732_7 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_7 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_4
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end
	end,
	Play910110181 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 910110181
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play910110182(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = 0
			local var_736_1 = 0.85

			if var_736_0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_0 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				local var_736_2 = arg_733_1:FormatText(StoryNameCfg[355].name)

				arg_733_1.leftNameTxt_.text = var_736_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6067")

				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_3 = arg_733_1:GetWordFromCfg(910110181)
				local var_736_4 = arg_733_1:FormatText(var_736_3.content)

				arg_733_1.text_.text = var_736_4

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 34
				local var_736_6 = utf8.len(var_736_4)
				local var_736_7 = var_736_5 <= 0 and var_736_1 or var_736_1 * (var_736_6 / var_736_5)

				if var_736_7 > 0 and var_736_1 < var_736_7 then
					arg_733_1.talkMaxDuration = var_736_7

					if var_736_7 + var_736_0 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_7 + var_736_0
					end
				end

				arg_733_1.text_.text = var_736_4
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_8 = math.max(var_736_1, arg_733_1.talkMaxDuration)

			if var_736_0 <= arg_733_1.time_ and arg_733_1.time_ < var_736_0 + var_736_8 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_0) / var_736_8

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_0 + var_736_8 and arg_733_1.time_ < var_736_0 + var_736_8 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end
	end,
	Play910110182 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 910110182
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play910110183(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = 0
			local var_740_1 = 0.225

			if var_740_0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_0 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_2 = arg_737_1:FormatText(StoryNameCfg[7].name)

				arg_737_1.leftNameTxt_.text = var_740_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_3 = arg_737_1:GetWordFromCfg(910110182)
				local var_740_4 = arg_737_1:FormatText(var_740_3.content)

				arg_737_1.text_.text = var_740_4

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_5 = 9
				local var_740_6 = utf8.len(var_740_4)
				local var_740_7 = var_740_5 <= 0 and var_740_1 or var_740_1 * (var_740_6 / var_740_5)

				if var_740_7 > 0 and var_740_1 < var_740_7 then
					arg_737_1.talkMaxDuration = var_740_7

					if var_740_7 + var_740_0 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_7 + var_740_0
					end
				end

				arg_737_1.text_.text = var_740_4
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_8 = math.max(var_740_1, arg_737_1.talkMaxDuration)

			if var_740_0 <= arg_737_1.time_ and arg_737_1.time_ < var_740_0 + var_740_8 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_0) / var_740_8

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_0 + var_740_8 and arg_737_1.time_ < var_740_0 + var_740_8 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end
	end,
	Play910110183 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 910110183
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play910110184(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = arg_741_1.actors_["1070"].transform
			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 then
				arg_741_1.var_.moveOldPos1070 = var_744_0.localPosition
				var_744_0.localScale = Vector3.New(1, 1, 1)

				arg_741_1:CheckSpriteTmpPos("1070", 3)

				local var_744_2 = var_744_0.childCount

				for iter_744_0 = 0, var_744_2 - 1 do
					local var_744_3 = var_744_0:GetChild(iter_744_0)

					if var_744_3.name == "split_2" or not string.find(var_744_3.name, "split") then
						var_744_3.gameObject:SetActive(true)
					else
						var_744_3.gameObject:SetActive(false)
					end
				end
			end

			local var_744_4 = 0.001

			if var_744_1 <= arg_741_1.time_ and arg_741_1.time_ < var_744_1 + var_744_4 then
				local var_744_5 = (arg_741_1.time_ - var_744_1) / var_744_4
				local var_744_6 = Vector3.New(0, -350, -180)

				var_744_0.localPosition = Vector3.Lerp(arg_741_1.var_.moveOldPos1070, var_744_6, var_744_5)
			end

			if arg_741_1.time_ >= var_744_1 + var_744_4 and arg_741_1.time_ < var_744_1 + var_744_4 + arg_744_0 then
				var_744_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_744_7 = arg_741_1.actors_["1070"]
			local var_744_8 = 0

			if var_744_8 < arg_741_1.time_ and arg_741_1.time_ <= var_744_8 + arg_744_0 then
				local var_744_9 = var_744_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_744_9 then
					arg_741_1.var_.alphaOldValue1070 = var_744_9.alpha
					arg_741_1.var_.characterEffect1070 = var_744_9
				end

				arg_741_1.var_.alphaOldValue1070 = 0
			end

			local var_744_10 = 0.5

			if var_744_8 <= arg_741_1.time_ and arg_741_1.time_ < var_744_8 + var_744_10 then
				local var_744_11 = (arg_741_1.time_ - var_744_8) / var_744_10
				local var_744_12 = Mathf.Lerp(arg_741_1.var_.alphaOldValue1070, 1, var_744_11)

				if arg_741_1.var_.characterEffect1070 then
					arg_741_1.var_.characterEffect1070.alpha = var_744_12
				end
			end

			if arg_741_1.time_ >= var_744_8 + var_744_10 and arg_741_1.time_ < var_744_8 + var_744_10 + arg_744_0 and arg_741_1.var_.characterEffect1070 then
				arg_741_1.var_.characterEffect1070.alpha = 1
			end

			local var_744_13 = arg_741_1.actors_["1070"]
			local var_744_14 = 0

			if var_744_14 < arg_741_1.time_ and arg_741_1.time_ <= var_744_14 + arg_744_0 and arg_741_1.var_.actorSpriteComps1070 == nil then
				arg_741_1.var_.actorSpriteComps1070 = var_744_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_744_15 = 0.0166666666666667

			if var_744_14 <= arg_741_1.time_ and arg_741_1.time_ < var_744_14 + var_744_15 then
				local var_744_16 = (arg_741_1.time_ - var_744_14) / var_744_15

				if arg_741_1.var_.actorSpriteComps1070 then
					for iter_744_1, iter_744_2 in pairs(arg_741_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_744_2 then
							local var_744_17 = Mathf.Lerp(iter_744_2.color.r, 1, var_744_16)

							iter_744_2.color = Color.New(var_744_17, var_744_17, var_744_17)
						end
					end
				end
			end

			if arg_741_1.time_ >= var_744_14 + var_744_15 and arg_741_1.time_ < var_744_14 + var_744_15 + arg_744_0 and arg_741_1.var_.actorSpriteComps1070 then
				local var_744_18 = 1

				for iter_744_3, iter_744_4 in pairs(arg_741_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_744_4 then
						iter_744_4.color = Color.New(var_744_18, var_744_18, var_744_18)
					end
				end

				arg_741_1.var_.actorSpriteComps1070 = nil
			end

			local var_744_19 = 0
			local var_744_20 = 0.575

			if var_744_19 < arg_741_1.time_ and arg_741_1.time_ <= var_744_19 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_21 = arg_741_1:FormatText(StoryNameCfg[318].name)

				arg_741_1.leftNameTxt_.text = var_744_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_22 = arg_741_1:GetWordFromCfg(910110183)
				local var_744_23 = arg_741_1:FormatText(var_744_22.content)

				arg_741_1.text_.text = var_744_23

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_24 = 23
				local var_744_25 = utf8.len(var_744_23)
				local var_744_26 = var_744_24 <= 0 and var_744_20 or var_744_20 * (var_744_25 / var_744_24)

				if var_744_26 > 0 and var_744_20 < var_744_26 then
					arg_741_1.talkMaxDuration = var_744_26

					if var_744_26 + var_744_19 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_26 + var_744_19
					end
				end

				arg_741_1.text_.text = var_744_23
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_27 = math.max(var_744_20, arg_741_1.talkMaxDuration)

			if var_744_19 <= arg_741_1.time_ and arg_741_1.time_ < var_744_19 + var_744_27 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_19) / var_744_27

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_19 + var_744_27 and arg_741_1.time_ < var_744_19 + var_744_27 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end
	end,
	Play910110184 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 910110184
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
			arg_745_1.auto_ = false
		end

		function arg_745_1.playNext_(arg_747_0)
			arg_745_1.onStoryFinished_()
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0
			local var_748_1 = 1.675

			if var_748_0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_0 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, false)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_2 = arg_745_1:GetWordFromCfg(910110184)
				local var_748_3 = arg_745_1:FormatText(var_748_2.content)

				arg_745_1.text_.text = var_748_3

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_4 = 67
				local var_748_5 = utf8.len(var_748_3)
				local var_748_6 = var_748_4 <= 0 and var_748_1 or var_748_1 * (var_748_5 / var_748_4)

				if var_748_6 > 0 and var_748_1 < var_748_6 then
					arg_745_1.talkMaxDuration = var_748_6

					if var_748_6 + var_748_0 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_6 + var_748_0
					end
				end

				arg_745_1.text_.text = var_748_3
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_7 = math.max(var_748_1, arg_745_1.talkMaxDuration)

			if var_748_0 <= arg_745_1.time_ and arg_745_1.time_ < var_748_0 + var_748_7 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_0) / var_748_7

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_0 + var_748_7 and arg_745_1.time_ < var_748_0 + var_748_7 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/I03",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST34",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST17",
		"Assets/UIResources/UI_AB/TextureConfig/Background/I05",
		"Assets/UIResources/UI_AB/TextureConfig/Background/I05a",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST01a",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST05",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST02"
	},
	voices = {}
}
