return {
	Play910819001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910819001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910819002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST18a"

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
				local var_4_5 = arg_1_1.bgs_.ST18a

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
					if iter_4_0 ~= "ST18a" then
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

			local var_4_22 = "1111"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_4_22), arg_1_1.canvasGo_.transform)

				var_4_23.transform:SetSiblingIndex(1)

				var_4_23.name = var_4_22
				var_4_23.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_22] = var_4_23
			end

			local var_4_24 = arg_1_1.actors_["1111"].transform
			local var_4_25 = 2

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111 = var_4_24.localPosition
				var_4_24.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1111", 3)

				local var_4_26 = var_4_24.childCount

				for iter_4_2 = 0, var_4_26 - 1 do
					local var_4_27 = var_4_24:GetChild(iter_4_2)

					if var_4_27.name == "split_3" or not string.find(var_4_27.name, "split") then
						var_4_27.gameObject:SetActive(true)
					else
						var_4_27.gameObject:SetActive(false)
					end
				end
			end

			local var_4_28 = 0.001

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_25) / var_4_28
				local var_4_30 = Vector3.New(-100, -290, -350)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111, var_4_30, var_4_29)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_28 and arg_1_1.time_ < var_4_25 + var_4_28 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_4_31 = arg_1_1.actors_["1111"]
			local var_4_32 = 2

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 and arg_1_1.var_.actorSpriteComps1111 == nil then
				arg_1_1.var_.actorSpriteComps1111 = var_4_31:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_33 = 2

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33

				if arg_1_1.var_.actorSpriteComps1111 then
					for iter_4_3, iter_4_4 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_4_4 then
							local var_4_35 = Mathf.Lerp(iter_4_4.color.r, 1, var_4_34)

							iter_4_4.color = Color.New(var_4_35, var_4_35, var_4_35)
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 and arg_1_1.var_.actorSpriteComps1111 then
				local var_4_36 = 1

				for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_4_6 then
						iter_4_6.color = Color.New(var_4_36, var_4_36, var_4_36)
					end
				end

				arg_1_1.var_.actorSpriteComps1111 = nil
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_skip", "ui_bgm_lower", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_41 = 2
			local var_4_42 = 0.05

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_43 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_43:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_44 = arg_1_1:FormatText(StoryNameCfg[67].name)

				arg_1_1.leftNameTxt_.text = var_4_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_45 = arg_1_1:GetWordFromCfg(910819001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_47 = 2
				local var_4_48 = utf8.len(var_4_46)
				local var_4_49 = var_4_47 <= 0 and var_4_42 or var_4_42 * (var_4_48 / var_4_47)

				if var_4_49 > 0 and var_4_42 < var_4_49 then
					arg_1_1.talkMaxDuration = var_4_49
					var_4_41 = var_4_41 + 0.3

					if var_4_49 + var_4_41 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_41
					end
				end

				arg_1_1.text_.text = var_4_46
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_50 = var_4_41 + 0.3
			local var_4_51 = math.max(var_4_42, arg_1_1.talkMaxDuration)

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_51 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_50) / var_4_51

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_50 + var_4_51 and arg_1_1.time_ < var_4_50 + var_4_51 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play910819002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910819002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910819003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1111"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and arg_7_1.var_.actorSpriteComps1111 == nil then
				arg_7_1.var_.actorSpriteComps1111 = var_10_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_10_2 = 2

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.actorSpriteComps1111 then
					for iter_10_0, iter_10_1 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_10_1 then
							local var_10_4 = Mathf.Lerp(iter_10_1.color.r, 0.5, var_10_3)

							iter_10_1.color = Color.New(var_10_4, var_10_4, var_10_4)
						end
					end
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and arg_7_1.var_.actorSpriteComps1111 then
				local var_10_5 = 0.5

				for iter_10_2, iter_10_3 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_10_3 then
						iter_10_3.color = Color.New(var_10_5, var_10_5, var_10_5)
					end
				end

				arg_7_1.var_.actorSpriteComps1111 = nil
			end

			local var_10_6 = 0
			local var_10_7 = 1.225

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_8 = arg_7_1:GetWordFromCfg(910819002)
				local var_10_9 = arg_7_1:FormatText(var_10_8.content)

				arg_7_1.text_.text = var_10_9

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 49
				local var_10_11 = utf8.len(var_10_9)
				local var_10_12 = var_10_10 <= 0 and var_10_7 or var_10_7 * (var_10_11 / var_10_10)

				if var_10_12 > 0 and var_10_7 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_9
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_13 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_13 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_13

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_13 and arg_7_1.time_ < var_10_6 + var_10_13 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play910819003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910819003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910819004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 0.325

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_2 = arg_11_1:FormatText(StoryNameCfg[7].name)

				arg_11_1.leftNameTxt_.text = var_14_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:GetWordFromCfg(910819003)
				local var_14_4 = arg_11_1:FormatText(var_14_3.content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 13
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
	Play910819004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910819004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910819005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.35

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[7].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:GetWordFromCfg(910819004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 14
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
	Play910819005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910819005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910819006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1111"].transform
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.var_.moveOldPos1111 = var_22_0.localPosition
				var_22_0.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1111", 3)

				local var_22_2 = var_22_0.childCount

				for iter_22_0 = 0, var_22_2 - 1 do
					local var_22_3 = var_22_0:GetChild(iter_22_0)

					if var_22_3.name == "split_3" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_4 then
				local var_22_5 = (arg_19_1.time_ - var_22_1) / var_22_4
				local var_22_6 = Vector3.New(-100, -290, -350)

				var_22_0.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1111, var_22_6, var_22_5)
			end

			if arg_19_1.time_ >= var_22_1 + var_22_4 and arg_19_1.time_ < var_22_1 + var_22_4 + arg_22_0 then
				var_22_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_22_7 = arg_19_1.actors_["1111"]
			local var_22_8 = 0

			if var_22_8 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 and arg_19_1.var_.actorSpriteComps1111 == nil then
				arg_19_1.var_.actorSpriteComps1111 = var_22_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_9 = 2

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_9 then
				local var_22_10 = (arg_19_1.time_ - var_22_8) / var_22_9

				if arg_19_1.var_.actorSpriteComps1111 then
					for iter_22_1, iter_22_2 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_22_2 then
							local var_22_11 = Mathf.Lerp(iter_22_2.color.r, 1, var_22_10)

							iter_22_2.color = Color.New(var_22_11, var_22_11, var_22_11)
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_8 + var_22_9 and arg_19_1.time_ < var_22_8 + var_22_9 + arg_22_0 and arg_19_1.var_.actorSpriteComps1111 then
				local var_22_12 = 1

				for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_22_4 then
						iter_22_4.color = Color.New(var_22_12, var_22_12, var_22_12)
					end
				end

				arg_19_1.var_.actorSpriteComps1111 = nil
			end

			local var_22_13 = 0
			local var_22_14 = 0.475

			if var_22_13 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_15 = arg_19_1:FormatText(StoryNameCfg[67].name)

				arg_19_1.leftNameTxt_.text = var_22_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_16 = arg_19_1:GetWordFromCfg(910819005)
				local var_22_17 = arg_19_1:FormatText(var_22_16.content)

				arg_19_1.text_.text = var_22_17

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_18 = 19
				local var_22_19 = utf8.len(var_22_17)
				local var_22_20 = var_22_18 <= 0 and var_22_14 or var_22_14 * (var_22_19 / var_22_18)

				if var_22_20 > 0 and var_22_14 < var_22_20 then
					arg_19_1.talkMaxDuration = var_22_20

					if var_22_20 + var_22_13 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_13
					end
				end

				arg_19_1.text_.text = var_22_17
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_14, arg_19_1.talkMaxDuration)

			if var_22_13 <= arg_19_1.time_ and arg_19_1.time_ < var_22_13 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_13) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_13 + var_22_21 and arg_19_1.time_ < var_22_13 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play910819006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910819006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910819007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1111"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and arg_23_1.var_.actorSpriteComps1111 == nil then
				arg_23_1.var_.actorSpriteComps1111 = var_26_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_2 = 2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.actorSpriteComps1111 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_26_1 then
							local var_26_4 = Mathf.Lerp(iter_26_1.color.r, 0.5, var_26_3)

							iter_26_1.color = Color.New(var_26_4, var_26_4, var_26_4)
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and arg_23_1.var_.actorSpriteComps1111 then
				local var_26_5 = 0.5

				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = Color.New(var_26_5, var_26_5, var_26_5)
					end
				end

				arg_23_1.var_.actorSpriteComps1111 = nil
			end

			local var_26_6 = 0
			local var_26_7 = 0.25

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_8 = arg_23_1:FormatText(StoryNameCfg[623].name)

				arg_23_1.leftNameTxt_.text = var_26_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_9 = arg_23_1:GetWordFromCfg(910819006)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 10
				local var_26_12 = utf8.len(var_26_10)
				local var_26_13 = var_26_11 <= 0 and var_26_7 or var_26_7 * (var_26_12 / var_26_11)

				if var_26_13 > 0 and var_26_7 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_14 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_14

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_14 and arg_23_1.time_ < var_26_6 + var_26_14 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play910819007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910819007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910819008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1111"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1111 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1111", 3)

				local var_30_2 = var_30_0.childCount

				for iter_30_0 = 0, var_30_2 - 1 do
					local var_30_3 = var_30_0:GetChild(iter_30_0)

					if var_30_3.name == "split_3" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_4 then
				local var_30_5 = (arg_27_1.time_ - var_30_1) / var_30_4
				local var_30_6 = Vector3.New(-100, -290, -350)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1111, var_30_6, var_30_5)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_4 and arg_27_1.time_ < var_30_1 + var_30_4 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_30_7 = arg_27_1.actors_["1111"]
			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 and arg_27_1.var_.actorSpriteComps1111 == nil then
				arg_27_1.var_.actorSpriteComps1111 = var_30_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_9 = 2

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 then
				local var_30_10 = (arg_27_1.time_ - var_30_8) / var_30_9

				if arg_27_1.var_.actorSpriteComps1111 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_30_2 then
							local var_30_11 = Mathf.Lerp(iter_30_2.color.r, 1, var_30_10)

							iter_30_2.color = Color.New(var_30_11, var_30_11, var_30_11)
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 and arg_27_1.var_.actorSpriteComps1111 then
				local var_30_12 = 1

				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_30_4 then
						iter_30_4.color = Color.New(var_30_12, var_30_12, var_30_12)
					end
				end

				arg_27_1.var_.actorSpriteComps1111 = nil
			end

			local var_30_13 = 0
			local var_30_14 = 0.225

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_15 = arg_27_1:FormatText(StoryNameCfg[67].name)

				arg_27_1.leftNameTxt_.text = var_30_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_16 = arg_27_1:GetWordFromCfg(910819007)
				local var_30_17 = arg_27_1:FormatText(var_30_16.content)

				arg_27_1.text_.text = var_30_17

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_18 = 9
				local var_30_19 = utf8.len(var_30_17)
				local var_30_20 = var_30_18 <= 0 and var_30_14 or var_30_14 * (var_30_19 / var_30_18)

				if var_30_20 > 0 and var_30_14 < var_30_20 then
					arg_27_1.talkMaxDuration = var_30_20

					if var_30_20 + var_30_13 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_20 + var_30_13
					end
				end

				arg_27_1.text_.text = var_30_17
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_21 = math.max(var_30_14, arg_27_1.talkMaxDuration)

			if var_30_13 <= arg_27_1.time_ and arg_27_1.time_ < var_30_13 + var_30_21 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_13) / var_30_21

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_13 + var_30_21 and arg_27_1.time_ < var_30_13 + var_30_21 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play910819008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910819008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910819009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1111"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and arg_31_1.var_.actorSpriteComps1111 == nil then
				arg_31_1.var_.actorSpriteComps1111 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps1111 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_34_1 then
							local var_34_4 = Mathf.Lerp(iter_34_1.color.r, 0.5, var_34_3)

							iter_34_1.color = Color.New(var_34_4, var_34_4, var_34_4)
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and arg_31_1.var_.actorSpriteComps1111 then
				local var_34_5 = 0.5

				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_34_3 then
						iter_34_3.color = Color.New(var_34_5, var_34_5, var_34_5)
					end
				end

				arg_31_1.var_.actorSpriteComps1111 = nil
			end

			local var_34_6 = 0
			local var_34_7 = 0.25

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_8 = arg_31_1:FormatText(StoryNameCfg[623].name)

				arg_31_1.leftNameTxt_.text = var_34_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_9 = arg_31_1:GetWordFromCfg(910819008)
				local var_34_10 = arg_31_1:FormatText(var_34_9.content)

				arg_31_1.text_.text = var_34_10

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 10
				local var_34_12 = utf8.len(var_34_10)
				local var_34_13 = var_34_11 <= 0 and var_34_7 or var_34_7 * (var_34_12 / var_34_11)

				if var_34_13 > 0 and var_34_7 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_10
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	Play910819009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910819009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910819010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.8

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(910819009)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 32
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_7 and arg_35_1.time_ < var_38_0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play910819010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910819010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910819011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1111"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1111 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1111", 3)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_3" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(-100, -290, -350)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1111, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_42_7 = arg_39_1.actors_["1111"]
			local var_42_8 = 0

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 and arg_39_1.var_.actorSpriteComps1111 == nil then
				arg_39_1.var_.actorSpriteComps1111 = var_42_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_9 = 2

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_9 then
				local var_42_10 = (arg_39_1.time_ - var_42_8) / var_42_9

				if arg_39_1.var_.actorSpriteComps1111 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_42_2 then
							local var_42_11 = Mathf.Lerp(iter_42_2.color.r, 1, var_42_10)

							iter_42_2.color = Color.New(var_42_11, var_42_11, var_42_11)
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_8 + var_42_9 and arg_39_1.time_ < var_42_8 + var_42_9 + arg_42_0 and arg_39_1.var_.actorSpriteComps1111 then
				local var_42_12 = 1

				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = Color.New(var_42_12, var_42_12, var_42_12)
					end
				end

				arg_39_1.var_.actorSpriteComps1111 = nil
			end

			local var_42_13 = 0
			local var_42_14 = 0.725

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_15 = arg_39_1:FormatText(StoryNameCfg[67].name)

				arg_39_1.leftNameTxt_.text = var_42_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_16 = arg_39_1:GetWordFromCfg(910819010)
				local var_42_17 = arg_39_1:FormatText(var_42_16.content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_18 = 29
				local var_42_19 = utf8.len(var_42_17)
				local var_42_20 = var_42_18 <= 0 and var_42_14 or var_42_14 * (var_42_19 / var_42_18)

				if var_42_20 > 0 and var_42_14 < var_42_20 then
					arg_39_1.talkMaxDuration = var_42_20

					if var_42_20 + var_42_13 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_13
					end
				end

				arg_39_1.text_.text = var_42_17
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_21 = math.max(var_42_14, arg_39_1.talkMaxDuration)

			if var_42_13 <= arg_39_1.time_ and arg_39_1.time_ < var_42_13 + var_42_21 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_13) / var_42_21

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_13 + var_42_21 and arg_39_1.time_ < var_42_13 + var_42_21 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play910819011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910819011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910819012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1111"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and arg_43_1.var_.actorSpriteComps1111 == nil then
				arg_43_1.var_.actorSpriteComps1111 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1111 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_46_1 then
							local var_46_4 = Mathf.Lerp(iter_46_1.color.r, 0.5, var_46_3)

							iter_46_1.color = Color.New(var_46_4, var_46_4, var_46_4)
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and arg_43_1.var_.actorSpriteComps1111 then
				local var_46_5 = 0.5

				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = Color.New(var_46_5, var_46_5, var_46_5)
					end
				end

				arg_43_1.var_.actorSpriteComps1111 = nil
			end

			local var_46_6 = 0
			local var_46_7 = 0.25

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_8 = arg_43_1:FormatText(StoryNameCfg[623].name)

				arg_43_1.leftNameTxt_.text = var_46_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_9 = arg_43_1:GetWordFromCfg(910819011)
				local var_46_10 = arg_43_1:FormatText(var_46_9.content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_11 = 10
				local var_46_12 = utf8.len(var_46_10)
				local var_46_13 = var_46_11 <= 0 and var_46_7 or var_46_7 * (var_46_12 / var_46_11)

				if var_46_13 > 0 and var_46_7 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_14 and arg_43_1.time_ < var_46_6 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play910819012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910819012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910819013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1111"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1111 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1111", 3)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_3" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(-100, -290, -350)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1111, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_50_7 = arg_47_1.actors_["1111"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and arg_47_1.var_.actorSpriteComps1111 == nil then
				arg_47_1.var_.actorSpriteComps1111 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps1111 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_50_2 then
							local var_50_11 = Mathf.Lerp(iter_50_2.color.r, 1, var_50_10)

							iter_50_2.color = Color.New(var_50_11, var_50_11, var_50_11)
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and arg_47_1.var_.actorSpriteComps1111 then
				local var_50_12 = 1

				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = Color.New(var_50_12, var_50_12, var_50_12)
					end
				end

				arg_47_1.var_.actorSpriteComps1111 = nil
			end

			local var_50_13 = 0
			local var_50_14 = 0.35

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_15 = arg_47_1:FormatText(StoryNameCfg[67].name)

				arg_47_1.leftNameTxt_.text = var_50_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_16 = arg_47_1:GetWordFromCfg(910819012)
				local var_50_17 = arg_47_1:FormatText(var_50_16.content)

				arg_47_1.text_.text = var_50_17

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_18 = 14
				local var_50_19 = utf8.len(var_50_17)
				local var_50_20 = var_50_18 <= 0 and var_50_14 or var_50_14 * (var_50_19 / var_50_18)

				if var_50_20 > 0 and var_50_14 < var_50_20 then
					arg_47_1.talkMaxDuration = var_50_20

					if var_50_20 + var_50_13 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_13
					end
				end

				arg_47_1.text_.text = var_50_17
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_21 = math.max(var_50_14, arg_47_1.talkMaxDuration)

			if var_50_13 <= arg_47_1.time_ and arg_47_1.time_ < var_50_13 + var_50_21 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_13) / var_50_21

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_13 + var_50_21 and arg_47_1.time_ < var_50_13 + var_50_21 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end
	end,
	Play910819013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910819013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910819014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1111"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and arg_51_1.var_.actorSpriteComps1111 == nil then
				arg_51_1.var_.actorSpriteComps1111 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1111 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_54_1 then
							local var_54_4 = Mathf.Lerp(iter_54_1.color.r, 0.5, var_54_3)

							iter_54_1.color = Color.New(var_54_4, var_54_4, var_54_4)
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and arg_51_1.var_.actorSpriteComps1111 then
				local var_54_5 = 0.5

				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = Color.New(var_54_5, var_54_5, var_54_5)
					end
				end

				arg_51_1.var_.actorSpriteComps1111 = nil
			end

			local var_54_6 = 0
			local var_54_7 = 0.425

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[7].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:GetWordFromCfg(910819013)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 17
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_14 and arg_51_1.time_ < var_54_6 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play910819014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910819014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910819015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.1

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(910819014)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 4
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play910819015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910819015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910819016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.15

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

				local var_62_2 = arg_59_1:GetWordFromCfg(910819015)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 6
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
	Play910819016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910819016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910819017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.775

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(910819016)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 31
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
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end
	end,
	Play910819017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910819017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910819018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1111"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1111 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1111", 3)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(-100, -290, -350)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1111, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_70_7 = arg_67_1.actors_["1111"]
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 and arg_67_1.var_.actorSpriteComps1111 == nil then
				arg_67_1.var_.actorSpriteComps1111 = var_70_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_9 = 2

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 then
				local var_70_10 = (arg_67_1.time_ - var_70_8) / var_70_9

				if arg_67_1.var_.actorSpriteComps1111 then
					for iter_70_1, iter_70_2 in pairs(arg_67_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_70_2 then
							local var_70_11 = Mathf.Lerp(iter_70_2.color.r, 1, var_70_10)

							iter_70_2.color = Color.New(var_70_11, var_70_11, var_70_11)
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 and arg_67_1.var_.actorSpriteComps1111 then
				local var_70_12 = 1

				for iter_70_3, iter_70_4 in pairs(arg_67_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_70_4 then
						iter_70_4.color = Color.New(var_70_12, var_70_12, var_70_12)
					end
				end

				arg_67_1.var_.actorSpriteComps1111 = nil
			end

			local var_70_13 = 0
			local var_70_14 = 0.5

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_15 = arg_67_1:FormatText(StoryNameCfg[67].name)

				arg_67_1.leftNameTxt_.text = var_70_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_16 = arg_67_1:GetWordFromCfg(910819017)
				local var_70_17 = arg_67_1:FormatText(var_70_16.content)

				arg_67_1.text_.text = var_70_17

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_18 = 20
				local var_70_19 = utf8.len(var_70_17)
				local var_70_20 = var_70_18 <= 0 and var_70_14 or var_70_14 * (var_70_19 / var_70_18)

				if var_70_20 > 0 and var_70_14 < var_70_20 then
					arg_67_1.talkMaxDuration = var_70_20

					if var_70_20 + var_70_13 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_13
					end
				end

				arg_67_1.text_.text = var_70_17
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_21 = math.max(var_70_14, arg_67_1.talkMaxDuration)

			if var_70_13 <= arg_67_1.time_ and arg_67_1.time_ < var_70_13 + var_70_21 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_13) / var_70_21

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_13 + var_70_21 and arg_67_1.time_ < var_70_13 + var_70_21 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play910819018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910819018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play910819019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1111"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and arg_71_1.var_.actorSpriteComps1111 == nil then
				arg_71_1.var_.actorSpriteComps1111 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps1111 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_74_1 then
							local var_74_4 = Mathf.Lerp(iter_74_1.color.r, 0.5, var_74_3)

							iter_74_1.color = Color.New(var_74_4, var_74_4, var_74_4)
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and arg_71_1.var_.actorSpriteComps1111 then
				local var_74_5 = 0.5

				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = Color.New(var_74_5, var_74_5, var_74_5)
					end
				end

				arg_71_1.var_.actorSpriteComps1111 = nil
			end

			local var_74_6 = 0
			local var_74_7 = 0.85

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(910819018)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 34
				local var_74_11 = utf8.len(var_74_9)
				local var_74_12 = var_74_10 <= 0 and var_74_7 or var_74_7 * (var_74_11 / var_74_10)

				if var_74_12 > 0 and var_74_7 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_13 and arg_71_1.time_ < var_74_6 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play910819019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910819019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play910819020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1111"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1111 = var_78_0.localPosition
				var_78_0.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("1111", 3)

				local var_78_2 = var_78_0.childCount

				for iter_78_0 = 0, var_78_2 - 1 do
					local var_78_3 = var_78_0:GetChild(iter_78_0)

					if var_78_3.name == "" or not string.find(var_78_3.name, "split") then
						var_78_3.gameObject:SetActive(true)
					else
						var_78_3.gameObject:SetActive(false)
					end
				end
			end

			local var_78_4 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_4 then
				local var_78_5 = (arg_75_1.time_ - var_78_1) / var_78_4
				local var_78_6 = Vector3.New(-100, -290, -350)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1111, var_78_6, var_78_5)
			end

			if arg_75_1.time_ >= var_78_1 + var_78_4 and arg_75_1.time_ < var_78_1 + var_78_4 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_78_7 = arg_75_1.actors_["1111"]
			local var_78_8 = 0

			if var_78_8 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 and arg_75_1.var_.actorSpriteComps1111 == nil then
				arg_75_1.var_.actorSpriteComps1111 = var_78_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 then
				local var_78_10 = (arg_75_1.time_ - var_78_8) / var_78_9

				if arg_75_1.var_.actorSpriteComps1111 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_78_2 then
							local var_78_11 = Mathf.Lerp(iter_78_2.color.r, 1, var_78_10)

							iter_78_2.color = Color.New(var_78_11, var_78_11, var_78_11)
						end
					end
				end
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 and arg_75_1.var_.actorSpriteComps1111 then
				local var_78_12 = 1

				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = Color.New(var_78_12, var_78_12, var_78_12)
					end
				end

				arg_75_1.var_.actorSpriteComps1111 = nil
			end

			local var_78_13 = 0
			local var_78_14 = 0.525

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_15 = arg_75_1:FormatText(StoryNameCfg[67].name)

				arg_75_1.leftNameTxt_.text = var_78_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_16 = arg_75_1:GetWordFromCfg(910819019)
				local var_78_17 = arg_75_1:FormatText(var_78_16.content)

				arg_75_1.text_.text = var_78_17

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_18 = 21
				local var_78_19 = utf8.len(var_78_17)
				local var_78_20 = var_78_18 <= 0 and var_78_14 or var_78_14 * (var_78_19 / var_78_18)

				if var_78_20 > 0 and var_78_14 < var_78_20 then
					arg_75_1.talkMaxDuration = var_78_20

					if var_78_20 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_13
					end
				end

				arg_75_1.text_.text = var_78_17
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_21 = math.max(var_78_14, arg_75_1.talkMaxDuration)

			if var_78_13 <= arg_75_1.time_ and arg_75_1.time_ < var_78_13 + var_78_21 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_13) / var_78_21

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_13 + var_78_21 and arg_75_1.time_ < var_78_13 + var_78_21 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play910819020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 910819020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play910819021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1111"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and arg_79_1.var_.actorSpriteComps1111 == nil then
				arg_79_1.var_.actorSpriteComps1111 = var_82_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_2 = 2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.actorSpriteComps1111 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_82_1 then
							local var_82_4 = Mathf.Lerp(iter_82_1.color.r, 0.5, var_82_3)

							iter_82_1.color = Color.New(var_82_4, var_82_4, var_82_4)
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and arg_79_1.var_.actorSpriteComps1111 then
				local var_82_5 = 0.5

				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = Color.New(var_82_5, var_82_5, var_82_5)
					end
				end

				arg_79_1.var_.actorSpriteComps1111 = nil
			end

			local var_82_6 = 0
			local var_82_7 = 0.325

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(910819020)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 13
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_14 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_14 and arg_79_1.time_ < var_82_6 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play910819021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 910819021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
			arg_83_1.auto_ = false
		end

		function arg_83_1.playNext_(arg_85_0)
			arg_83_1.onStoryFinished_()
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1111"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1111 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1111", 3)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(-100, -290, -350)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1111, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_86_7 = arg_83_1.actors_["1111"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and arg_83_1.var_.actorSpriteComps1111 == nil then
				arg_83_1.var_.actorSpriteComps1111 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 2

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps1111 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_86_2 then
							local var_86_11 = Mathf.Lerp(iter_86_2.color.r, 1, var_86_10)

							iter_86_2.color = Color.New(var_86_11, var_86_11, var_86_11)
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and arg_83_1.var_.actorSpriteComps1111 then
				local var_86_12 = 1

				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = Color.New(var_86_12, var_86_12, var_86_12)
					end
				end

				arg_83_1.var_.actorSpriteComps1111 = nil
			end

			local var_86_13 = 0
			local var_86_14 = 1

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				local var_86_15 = "play"
				local var_86_16 = "effect"

				arg_83_1:AudioAction(var_86_15, var_86_16, "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_86_17 = 0
			local var_86_18 = 0.275

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_19 = arg_83_1:FormatText(StoryNameCfg[67].name)

				arg_83_1.leftNameTxt_.text = var_86_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_20 = arg_83_1:GetWordFromCfg(910819021)
				local var_86_21 = arg_83_1:FormatText(var_86_20.content)

				arg_83_1.text_.text = var_86_21

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_22 = 11
				local var_86_23 = utf8.len(var_86_21)
				local var_86_24 = var_86_22 <= 0 and var_86_18 or var_86_18 * (var_86_23 / var_86_22)

				if var_86_24 > 0 and var_86_18 < var_86_24 then
					arg_83_1.talkMaxDuration = var_86_24

					if var_86_24 + var_86_17 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_24 + var_86_17
					end
				end

				arg_83_1.text_.text = var_86_21
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_18, arg_83_1.talkMaxDuration)

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_17) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_17 + var_86_25 and arg_83_1.time_ < var_86_17 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST18a"
	},
	voices = {}
}
