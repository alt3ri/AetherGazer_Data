return {
	Play910822001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910822001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910822002(arg_1_1)
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
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = "1111"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_4_24), arg_1_1.canvasGo_.transform)

				var_4_25.transform:SetSiblingIndex(1)

				var_4_25.name = var_4_24
				var_4_25.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_24] = var_4_25
			end

			local var_4_26 = arg_1_1.actors_["1111"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1111", 3)

				local var_4_28 = var_4_26.childCount

				for iter_4_2 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_2)

					if var_4_29.name == "split_1" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(-100, -290, -350)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_4_33 = arg_1_1.actors_["1111"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and arg_1_1.var_.actorSpriteComps1111 == nil then
				arg_1_1.var_.actorSpriteComps1111 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 2

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps1111 then
					for iter_4_3, iter_4_4 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_4_4 then
							local var_4_37 = Mathf.Lerp(iter_4_4.color.r, 0.5, var_4_36)

							iter_4_4.color = Color.New(var_4_37, var_4_37, var_4_37)
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and arg_1_1.var_.actorSpriteComps1111 then
				local var_4_38 = 0.5

				for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_4_6 then
						iter_4_6.color = Color.New(var_4_38, var_4_38, var_4_38)
					end
				end

				arg_1_1.var_.actorSpriteComps1111 = nil
			end

			local var_4_39 = 0
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "effect"

				arg_1_1:AudioAction(var_4_41, var_4_42, "ui_skip", "ui_bgm_lower", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_43 = 2
			local var_4_44 = 0.275

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_45 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_45:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_46 = arg_1_1:FormatText(StoryNameCfg[623].name)

				arg_1_1.leftNameTxt_.text = var_4_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(910822001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 11
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_44 or var_4_44 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_44 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_43 = var_4_43 + 0.3

					if var_4_51 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_43
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_43 + 0.3
			local var_4_53 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play910822002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910822002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910822003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1111"].transform
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.var_.moveOldPos1111 = var_10_0.localPosition
				var_10_0.localScale = Vector3.New(1, 1, 1)

				arg_7_1:CheckSpriteTmpPos("1111", 3)

				local var_10_2 = var_10_0.childCount

				for iter_10_0 = 0, var_10_2 - 1 do
					local var_10_3 = var_10_0:GetChild(iter_10_0)

					if var_10_3.name == "" or not string.find(var_10_3.name, "split") then
						var_10_3.gameObject:SetActive(true)
					else
						var_10_3.gameObject:SetActive(false)
					end
				end
			end

			local var_10_4 = 0.001

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_4 then
				local var_10_5 = (arg_7_1.time_ - var_10_1) / var_10_4
				local var_10_6 = Vector3.New(-100, -290, -350)

				var_10_0.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1111, var_10_6, var_10_5)
			end

			if arg_7_1.time_ >= var_10_1 + var_10_4 and arg_7_1.time_ < var_10_1 + var_10_4 + arg_10_0 then
				var_10_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_10_7 = arg_7_1.actors_["1111"]
			local var_10_8 = 0

			if var_10_8 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 and arg_7_1.var_.actorSpriteComps1111 == nil then
				arg_7_1.var_.actorSpriteComps1111 = var_10_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_10_9 = 2

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_9 then
				local var_10_10 = (arg_7_1.time_ - var_10_8) / var_10_9

				if arg_7_1.var_.actorSpriteComps1111 then
					for iter_10_1, iter_10_2 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_10_2 then
							local var_10_11 = Mathf.Lerp(iter_10_2.color.r, 1, var_10_10)

							iter_10_2.color = Color.New(var_10_11, var_10_11, var_10_11)
						end
					end
				end
			end

			if arg_7_1.time_ >= var_10_8 + var_10_9 and arg_7_1.time_ < var_10_8 + var_10_9 + arg_10_0 and arg_7_1.var_.actorSpriteComps1111 then
				local var_10_12 = 1

				for iter_10_3, iter_10_4 in pairs(arg_7_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_10_4 then
						iter_10_4.color = Color.New(var_10_12, var_10_12, var_10_12)
					end
				end

				arg_7_1.var_.actorSpriteComps1111 = nil
			end

			local var_10_13 = 0
			local var_10_14 = 0.55

			if var_10_13 < arg_7_1.time_ and arg_7_1.time_ <= var_10_13 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_15 = arg_7_1:FormatText(StoryNameCfg[67].name)

				arg_7_1.leftNameTxt_.text = var_10_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(910822002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_18 = 22
				local var_10_19 = utf8.len(var_10_17)
				local var_10_20 = var_10_18 <= 0 and var_10_14 or var_10_14 * (var_10_19 / var_10_18)

				if var_10_20 > 0 and var_10_14 < var_10_20 then
					arg_7_1.talkMaxDuration = var_10_20

					if var_10_20 + var_10_13 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_13
					end
				end

				arg_7_1.text_.text = var_10_17
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_21 = math.max(var_10_14, arg_7_1.talkMaxDuration)

			if var_10_13 <= arg_7_1.time_ and arg_7_1.time_ < var_10_13 + var_10_21 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_13) / var_10_21

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_13 + var_10_21 and arg_7_1.time_ < var_10_13 + var_10_21 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play910822003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910822003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910822004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["1111"]
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 and arg_11_1.var_.actorSpriteComps1111 == nil then
				arg_11_1.var_.actorSpriteComps1111 = var_14_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_14_2 = 2

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2

				if arg_11_1.var_.actorSpriteComps1111 then
					for iter_14_0, iter_14_1 in pairs(arg_11_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_14_1 then
							local var_14_4 = Mathf.Lerp(iter_14_1.color.r, 0.5, var_14_3)

							iter_14_1.color = Color.New(var_14_4, var_14_4, var_14_4)
						end
					end
				end
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 and arg_11_1.var_.actorSpriteComps1111 then
				local var_14_5 = 0.5

				for iter_14_2, iter_14_3 in pairs(arg_11_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_14_3 then
						iter_14_3.color = Color.New(var_14_5, var_14_5, var_14_5)
					end
				end

				arg_11_1.var_.actorSpriteComps1111 = nil
			end

			local var_14_6 = 0
			local var_14_7 = 0.525

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_8 = arg_11_1:FormatText(StoryNameCfg[7].name)

				arg_11_1.leftNameTxt_.text = var_14_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_9 = arg_11_1:GetWordFromCfg(910822003)
				local var_14_10 = arg_11_1:FormatText(var_14_9.content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_11 = 21
				local var_14_12 = utf8.len(var_14_10)
				local var_14_13 = var_14_11 <= 0 and var_14_7 or var_14_7 * (var_14_12 / var_14_11)

				if var_14_13 > 0 and var_14_7 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_6 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_6
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_14 = math.max(var_14_7, arg_11_1.talkMaxDuration)

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_14 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_6) / var_14_14

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_6 + var_14_14 and arg_11_1.time_ < var_14_6 + var_14_14 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play910822004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910822004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910822005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1111"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1111 = var_18_0.localPosition
				var_18_0.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1111", 3)

				local var_18_2 = var_18_0.childCount

				for iter_18_0 = 0, var_18_2 - 1 do
					local var_18_3 = var_18_0:GetChild(iter_18_0)

					if var_18_3.name == "" or not string.find(var_18_3.name, "split") then
						var_18_3.gameObject:SetActive(true)
					else
						var_18_3.gameObject:SetActive(false)
					end
				end
			end

			local var_18_4 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_4 then
				local var_18_5 = (arg_15_1.time_ - var_18_1) / var_18_4
				local var_18_6 = Vector3.New(-100, -290, -350)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1111, var_18_6, var_18_5)
			end

			if arg_15_1.time_ >= var_18_1 + var_18_4 and arg_15_1.time_ < var_18_1 + var_18_4 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_18_7 = arg_15_1.actors_["1111"]
			local var_18_8 = 0

			if var_18_8 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 and arg_15_1.var_.actorSpriteComps1111 == nil then
				arg_15_1.var_.actorSpriteComps1111 = var_18_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_9 = 2

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_9 then
				local var_18_10 = (arg_15_1.time_ - var_18_8) / var_18_9

				if arg_15_1.var_.actorSpriteComps1111 then
					for iter_18_1, iter_18_2 in pairs(arg_15_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_18_2 then
							local var_18_11 = Mathf.Lerp(iter_18_2.color.r, 1, var_18_10)

							iter_18_2.color = Color.New(var_18_11, var_18_11, var_18_11)
						end
					end
				end
			end

			if arg_15_1.time_ >= var_18_8 + var_18_9 and arg_15_1.time_ < var_18_8 + var_18_9 + arg_18_0 and arg_15_1.var_.actorSpriteComps1111 then
				local var_18_12 = 1

				for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_18_4 then
						iter_18_4.color = Color.New(var_18_12, var_18_12, var_18_12)
					end
				end

				arg_15_1.var_.actorSpriteComps1111 = nil
			end

			local var_18_13 = 0
			local var_18_14 = 0.45

			if var_18_13 < arg_15_1.time_ and arg_15_1.time_ <= var_18_13 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_15 = arg_15_1:FormatText(StoryNameCfg[67].name)

				arg_15_1.leftNameTxt_.text = var_18_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_16 = arg_15_1:GetWordFromCfg(910822004)
				local var_18_17 = arg_15_1:FormatText(var_18_16.content)

				arg_15_1.text_.text = var_18_17

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_18 = 18
				local var_18_19 = utf8.len(var_18_17)
				local var_18_20 = var_18_18 <= 0 and var_18_14 or var_18_14 * (var_18_19 / var_18_18)

				if var_18_20 > 0 and var_18_14 < var_18_20 then
					arg_15_1.talkMaxDuration = var_18_20

					if var_18_20 + var_18_13 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_20 + var_18_13
					end
				end

				arg_15_1.text_.text = var_18_17
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_21 = math.max(var_18_14, arg_15_1.talkMaxDuration)

			if var_18_13 <= arg_15_1.time_ and arg_15_1.time_ < var_18_13 + var_18_21 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_13) / var_18_21

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_13 + var_18_21 and arg_15_1.time_ < var_18_13 + var_18_21 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play910822005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910822005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910822006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1111"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and arg_19_1.var_.actorSpriteComps1111 == nil then
				arg_19_1.var_.actorSpriteComps1111 = var_22_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_2 = 2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.actorSpriteComps1111 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_22_1 then
							local var_22_4 = Mathf.Lerp(iter_22_1.color.r, 0.5, var_22_3)

							iter_22_1.color = Color.New(var_22_4, var_22_4, var_22_4)
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and arg_19_1.var_.actorSpriteComps1111 then
				local var_22_5 = 0.5

				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = Color.New(var_22_5, var_22_5, var_22_5)
					end
				end

				arg_19_1.var_.actorSpriteComps1111 = nil
			end

			local var_22_6 = 0
			local var_22_7 = 0.05

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_8 = arg_19_1:FormatText(StoryNameCfg[7].name)

				arg_19_1.leftNameTxt_.text = var_22_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_9 = arg_19_1:GetWordFromCfg(910822005)
				local var_22_10 = arg_19_1:FormatText(var_22_9.content)

				arg_19_1.text_.text = var_22_10

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 2
				local var_22_12 = utf8.len(var_22_10)
				local var_22_13 = var_22_11 <= 0 and var_22_7 or var_22_7 * (var_22_12 / var_22_11)

				if var_22_13 > 0 and var_22_7 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_10
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_14 and arg_19_1.time_ < var_22_6 + var_22_14 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play910822006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910822006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910822007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1111"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1111 = var_26_0.localPosition
				var_26_0.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1111", 3)

				local var_26_2 = var_26_0.childCount

				for iter_26_0 = 0, var_26_2 - 1 do
					local var_26_3 = var_26_0:GetChild(iter_26_0)

					if var_26_3.name == "split_3" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_4 then
				local var_26_5 = (arg_23_1.time_ - var_26_1) / var_26_4
				local var_26_6 = Vector3.New(-100, -290, -350)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1111, var_26_6, var_26_5)
			end

			if arg_23_1.time_ >= var_26_1 + var_26_4 and arg_23_1.time_ < var_26_1 + var_26_4 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_26_7 = arg_23_1.actors_["1111"]
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 and arg_23_1.var_.actorSpriteComps1111 == nil then
				arg_23_1.var_.actorSpriteComps1111 = var_26_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_9 = 2

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 then
				local var_26_10 = (arg_23_1.time_ - var_26_8) / var_26_9

				if arg_23_1.var_.actorSpriteComps1111 then
					for iter_26_1, iter_26_2 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_26_2 then
							local var_26_11 = Mathf.Lerp(iter_26_2.color.r, 1, var_26_10)

							iter_26_2.color = Color.New(var_26_11, var_26_11, var_26_11)
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 and arg_23_1.var_.actorSpriteComps1111 then
				local var_26_12 = 1

				for iter_26_3, iter_26_4 in pairs(arg_23_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_26_4 then
						iter_26_4.color = Color.New(var_26_12, var_26_12, var_26_12)
					end
				end

				arg_23_1.var_.actorSpriteComps1111 = nil
			end

			local var_26_13 = 0
			local var_26_14 = 0.65

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_15 = arg_23_1:FormatText(StoryNameCfg[67].name)

				arg_23_1.leftNameTxt_.text = var_26_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_16 = arg_23_1:GetWordFromCfg(910822006)
				local var_26_17 = arg_23_1:FormatText(var_26_16.content)

				arg_23_1.text_.text = var_26_17

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_18 = 26
				local var_26_19 = utf8.len(var_26_17)
				local var_26_20 = var_26_18 <= 0 and var_26_14 or var_26_14 * (var_26_19 / var_26_18)

				if var_26_20 > 0 and var_26_14 < var_26_20 then
					arg_23_1.talkMaxDuration = var_26_20

					if var_26_20 + var_26_13 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_20 + var_26_13
					end
				end

				arg_23_1.text_.text = var_26_17
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_21 = math.max(var_26_14, arg_23_1.talkMaxDuration)

			if var_26_13 <= arg_23_1.time_ and arg_23_1.time_ < var_26_13 + var_26_21 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_13) / var_26_21

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_13 + var_26_21 and arg_23_1.time_ < var_26_13 + var_26_21 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play910822007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910822007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910822008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1111"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and arg_27_1.var_.actorSpriteComps1111 == nil then
				arg_27_1.var_.actorSpriteComps1111 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1111 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_30_1 then
							local var_30_4 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

							iter_30_1.color = Color.New(var_30_4, var_30_4, var_30_4)
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and arg_27_1.var_.actorSpriteComps1111 then
				local var_30_5 = 0.5

				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = Color.New(var_30_5, var_30_5, var_30_5)
					end
				end

				arg_27_1.var_.actorSpriteComps1111 = nil
			end

			local var_30_6 = 0
			local var_30_7 = 0.75

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_8 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_9 = arg_27_1:GetWordFromCfg(910822007)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 30
				local var_30_12 = utf8.len(var_30_10)
				local var_30_13 = var_30_11 <= 0 and var_30_7 or var_30_7 * (var_30_12 / var_30_11)

				if var_30_13 > 0 and var_30_7 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play910822008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910822008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910822009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1111"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1111 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1111", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "split_3" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(-100, -290, -350)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1111, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_34_7 = arg_31_1.actors_["1111"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 and arg_31_1.var_.actorSpriteComps1111 == nil then
				arg_31_1.var_.actorSpriteComps1111 = var_34_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_9 = 2

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 then
				local var_34_10 = (arg_31_1.time_ - var_34_8) / var_34_9

				if arg_31_1.var_.actorSpriteComps1111 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_34_2 then
							local var_34_11 = Mathf.Lerp(iter_34_2.color.r, 1, var_34_10)

							iter_34_2.color = Color.New(var_34_11, var_34_11, var_34_11)
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 and arg_31_1.var_.actorSpriteComps1111 then
				local var_34_12 = 1

				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_34_4 then
						iter_34_4.color = Color.New(var_34_12, var_34_12, var_34_12)
					end
				end

				arg_31_1.var_.actorSpriteComps1111 = nil
			end

			local var_34_13 = 0
			local var_34_14 = 0.45

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_15 = arg_31_1:FormatText(StoryNameCfg[67].name)

				arg_31_1.leftNameTxt_.text = var_34_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_16 = arg_31_1:GetWordFromCfg(910822008)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_18 = 18
				local var_34_19 = utf8.len(var_34_17)
				local var_34_20 = var_34_18 <= 0 and var_34_14 or var_34_14 * (var_34_19 / var_34_18)

				if var_34_20 > 0 and var_34_14 < var_34_20 then
					arg_31_1.talkMaxDuration = var_34_20

					if var_34_20 + var_34_13 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_20 + var_34_13
					end
				end

				arg_31_1.text_.text = var_34_17
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_14, arg_31_1.talkMaxDuration)

			if var_34_13 <= arg_31_1.time_ and arg_31_1.time_ < var_34_13 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_13) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_13 + var_34_21 and arg_31_1.time_ < var_34_13 + var_34_21 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	Play910822009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910822009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910822010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1111"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and arg_35_1.var_.actorSpriteComps1111 == nil then
				arg_35_1.var_.actorSpriteComps1111 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps1111 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_38_1 then
							local var_38_4 = Mathf.Lerp(iter_38_1.color.r, 0.5, var_38_3)

							iter_38_1.color = Color.New(var_38_4, var_38_4, var_38_4)
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and arg_35_1.var_.actorSpriteComps1111 then
				local var_38_5 = 0.5

				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = Color.New(var_38_5, var_38_5, var_38_5)
					end
				end

				arg_35_1.var_.actorSpriteComps1111 = nil
			end

			local var_38_6 = 0
			local var_38_7 = 0.975

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_8 = arg_35_1:FormatText(StoryNameCfg[7].name)

				arg_35_1.leftNameTxt_.text = var_38_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_9 = arg_35_1:GetWordFromCfg(910822009)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 39
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_7 or var_38_7 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_7 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play910822010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910822010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910822011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.925

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(910822010)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 37
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play910822011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910822011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910822012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.175

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(910822011)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 7
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play910822012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910822012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910822013(arg_47_1)
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
			local var_50_14 = 0.25

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

				local var_50_16 = arg_47_1:GetWordFromCfg(910822012)
				local var_50_17 = arg_47_1:FormatText(var_50_16.content)

				arg_47_1.text_.text = var_50_17

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_18 = 10
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
	Play910822013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910822013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910822014(arg_51_1)
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
			local var_54_7 = 0.625

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

				local var_54_9 = arg_51_1:GetWordFromCfg(910822013)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 25
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
	Play910822014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910822014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910822015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1111"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1111 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1111", 3)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "split_3" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(-100, -290, -350)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1111, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(-100, -290, -350)
			end

			local var_58_7 = arg_55_1.actors_["1111"]
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 and arg_55_1.var_.actorSpriteComps1111 == nil then
				arg_55_1.var_.actorSpriteComps1111 = var_58_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = (arg_55_1.time_ - var_58_8) / var_58_9

				if arg_55_1.var_.actorSpriteComps1111 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_58_2 then
							local var_58_11 = Mathf.Lerp(iter_58_2.color.r, 1, var_58_10)

							iter_58_2.color = Color.New(var_58_11, var_58_11, var_58_11)
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 and arg_55_1.var_.actorSpriteComps1111 then
				local var_58_12 = 1

				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = Color.New(var_58_12, var_58_12, var_58_12)
					end
				end

				arg_55_1.var_.actorSpriteComps1111 = nil
			end

			local var_58_13 = 0
			local var_58_14 = 0.15

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_15 = arg_55_1:FormatText(StoryNameCfg[67].name)

				arg_55_1.leftNameTxt_.text = var_58_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_16 = arg_55_1:GetWordFromCfg(910822014)
				local var_58_17 = arg_55_1:FormatText(var_58_16.content)

				arg_55_1.text_.text = var_58_17

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_18 = 6
				local var_58_19 = utf8.len(var_58_17)
				local var_58_20 = var_58_18 <= 0 and var_58_14 or var_58_14 * (var_58_19 / var_58_18)

				if var_58_20 > 0 and var_58_14 < var_58_20 then
					arg_55_1.talkMaxDuration = var_58_20

					if var_58_20 + var_58_13 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_20 + var_58_13
					end
				end

				arg_55_1.text_.text = var_58_17
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_21 = math.max(var_58_14, arg_55_1.talkMaxDuration)

			if var_58_13 <= arg_55_1.time_ and arg_55_1.time_ < var_58_13 + var_58_21 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_13) / var_58_21

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_13 + var_58_21 and arg_55_1.time_ < var_58_13 + var_58_21 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play910822015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910822015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910822016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1111"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and arg_59_1.var_.actorSpriteComps1111 == nil then
				arg_59_1.var_.actorSpriteComps1111 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps1111 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1111:ToTable()) do
						if iter_62_1 then
							local var_62_4 = Mathf.Lerp(iter_62_1.color.r, 0.5, var_62_3)

							iter_62_1.color = Color.New(var_62_4, var_62_4, var_62_4)
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and arg_59_1.var_.actorSpriteComps1111 then
				local var_62_5 = 0.5

				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1111:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = Color.New(var_62_5, var_62_5, var_62_5)
					end
				end

				arg_59_1.var_.actorSpriteComps1111 = nil
			end

			local var_62_6 = 0
			local var_62_7 = 0.6

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(910822015)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 24
				local var_62_11 = utf8.len(var_62_9)
				local var_62_12 = var_62_10 <= 0 and var_62_7 or var_62_7 * (var_62_11 / var_62_10)

				if var_62_12 > 0 and var_62_7 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_13 and arg_59_1.time_ < var_62_6 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	Play910822016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910822016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910822017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.15

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

				local var_66_3 = arg_63_1:GetWordFromCfg(910822016)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 6
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
	Play910822017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910822017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
			arg_67_1.auto_ = false
		end

		function arg_67_1.playNext_(arg_69_0)
			arg_67_1.onStoryFinished_()
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
			local var_70_14 = 1

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				local var_70_15 = "play"
				local var_70_16 = "effect"

				arg_67_1:AudioAction(var_70_15, var_70_16, "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_70_17 = 0
			local var_70_18 = 0.4

			if var_70_17 < arg_67_1.time_ and arg_67_1.time_ <= var_70_17 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_19 = arg_67_1:FormatText(StoryNameCfg[67].name)

				arg_67_1.leftNameTxt_.text = var_70_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_20 = arg_67_1:GetWordFromCfg(910822017)
				local var_70_21 = arg_67_1:FormatText(var_70_20.content)

				arg_67_1.text_.text = var_70_21

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_22 = 16
				local var_70_23 = utf8.len(var_70_21)
				local var_70_24 = var_70_22 <= 0 and var_70_18 or var_70_18 * (var_70_23 / var_70_22)

				if var_70_24 > 0 and var_70_18 < var_70_24 then
					arg_67_1.talkMaxDuration = var_70_24

					if var_70_24 + var_70_17 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_24 + var_70_17
					end
				end

				arg_67_1.text_.text = var_70_21
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_18, arg_67_1.talkMaxDuration)

			if var_70_17 <= arg_67_1.time_ and arg_67_1.time_ < var_70_17 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_17) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_17 + var_70_25 and arg_67_1.time_ < var_70_17 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST18a"
	},
	voices = {}
}
