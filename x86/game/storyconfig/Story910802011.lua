return {
	Play910810001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910810001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910810002(arg_1_1)
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

			local var_4_22 = "1070"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. var_4_22), arg_1_1.canvasGo_.transform)

				var_4_23.transform:SetSiblingIndex(1)

				var_4_23.name = var_4_22
				var_4_23.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_22] = var_4_23
			end

			local var_4_24 = arg_1_1.actors_["1070"].transform
			local var_4_25 = 1.8

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPos1070 = var_4_24.localPosition
				var_4_24.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1070", 3)

				local var_4_26 = var_4_24.childCount

				for iter_4_2 = 0, var_4_26 - 1 do
					local var_4_27 = var_4_24:GetChild(iter_4_2)

					if var_4_27.name == "split_6" or not string.find(var_4_27.name, "split") then
						var_4_27.gameObject:SetActive(true)
					else
						var_4_27.gameObject:SetActive(false)
					end
				end
			end

			local var_4_28 = 0.001

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_25) / var_4_28
				local var_4_30 = Vector3.New(0, -350, -180)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1070, var_4_30, var_4_29)
			end

			if arg_1_1.time_ >= var_4_25 + var_4_28 and arg_1_1.time_ < var_4_25 + var_4_28 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0, -350, -180)
			end

			local var_4_31 = arg_1_1.actors_["1070"]
			local var_4_32 = 1.8

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 and arg_1_1.var_.actorSpriteComps1070 == nil then
				arg_1_1.var_.actorSpriteComps1070 = var_4_31:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_33 = 0.034

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33

				if arg_1_1.var_.actorSpriteComps1070 then
					for iter_4_3, iter_4_4 in pairs(arg_1_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_4_4 then
							local var_4_35 = Mathf.Lerp(iter_4_4.color.r, 1, var_4_34)

							iter_4_4.color = Color.New(var_4_35, var_4_35, var_4_35)
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 and arg_1_1.var_.actorSpriteComps1070 then
				local var_4_36 = 1

				for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_4_6 then
						iter_4_6.color = Color.New(var_4_36, var_4_36, var_4_36)
					end
				end

				arg_1_1.var_.actorSpriteComps1070 = nil
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
			local var_4_42 = 0.45

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

				local var_4_44 = arg_1_1:FormatText(StoryNameCfg[318].name)

				arg_1_1.leftNameTxt_.text = var_4_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_45 = arg_1_1:GetWordFromCfg(910810001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_47 = 18
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
	Play910810002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910810002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910810003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1070"].transform
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.var_.moveOldPos1070 = var_10_0.localPosition
				var_10_0.localScale = Vector3.New(1, 1, 1)

				arg_7_1:CheckSpriteTmpPos("1070", 3)

				local var_10_2 = var_10_0.childCount

				for iter_10_0 = 0, var_10_2 - 1 do
					local var_10_3 = var_10_0:GetChild(iter_10_0)

					if var_10_3.name == "split_6" or not string.find(var_10_3.name, "split") then
						var_10_3.gameObject:SetActive(true)
					else
						var_10_3.gameObject:SetActive(false)
					end
				end
			end

			local var_10_4 = 0.001

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_4 then
				local var_10_5 = (arg_7_1.time_ - var_10_1) / var_10_4
				local var_10_6 = Vector3.New(0, -350, -180)

				var_10_0.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1070, var_10_6, var_10_5)
			end

			if arg_7_1.time_ >= var_10_1 + var_10_4 and arg_7_1.time_ < var_10_1 + var_10_4 + arg_10_0 then
				var_10_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_10_7 = arg_7_1.actors_["1070"]
			local var_10_8 = 0

			if var_10_8 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 and arg_7_1.var_.actorSpriteComps1070 == nil then
				arg_7_1.var_.actorSpriteComps1070 = var_10_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_10_9 = 0.034

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_9 then
				local var_10_10 = (arg_7_1.time_ - var_10_8) / var_10_9

				if arg_7_1.var_.actorSpriteComps1070 then
					for iter_10_1, iter_10_2 in pairs(arg_7_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_10_2 then
							local var_10_11 = Mathf.Lerp(iter_10_2.color.r, 0.5, var_10_10)

							iter_10_2.color = Color.New(var_10_11, var_10_11, var_10_11)
						end
					end
				end
			end

			if arg_7_1.time_ >= var_10_8 + var_10_9 and arg_7_1.time_ < var_10_8 + var_10_9 + arg_10_0 and arg_7_1.var_.actorSpriteComps1070 then
				local var_10_12 = 0.5

				for iter_10_3, iter_10_4 in pairs(arg_7_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_10_4 then
						iter_10_4.color = Color.New(var_10_12, var_10_12, var_10_12)
					end
				end

				arg_7_1.var_.actorSpriteComps1070 = nil
			end

			local var_10_13 = 0
			local var_10_14 = 0.175

			if var_10_13 < arg_7_1.time_ and arg_7_1.time_ <= var_10_13 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_15 = arg_7_1:FormatText(StoryNameCfg[7].name)

				arg_7_1.leftNameTxt_.text = var_10_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_16 = arg_7_1:GetWordFromCfg(910810002)
				local var_10_17 = arg_7_1:FormatText(var_10_16.content)

				arg_7_1.text_.text = var_10_17

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_18 = 7
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
	Play910810003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910810003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910810004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["1070"].transform
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.var_.moveOldPos1070 = var_14_0.localPosition
				var_14_0.localScale = Vector3.New(1, 1, 1)

				arg_11_1:CheckSpriteTmpPos("1070", 3)

				local var_14_2 = var_14_0.childCount

				for iter_14_0 = 0, var_14_2 - 1 do
					local var_14_3 = var_14_0:GetChild(iter_14_0)

					if var_14_3.name == "split_2" or not string.find(var_14_3.name, "split") then
						var_14_3.gameObject:SetActive(true)
					else
						var_14_3.gameObject:SetActive(false)
					end
				end
			end

			local var_14_4 = 0.001

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_4 then
				local var_14_5 = (arg_11_1.time_ - var_14_1) / var_14_4
				local var_14_6 = Vector3.New(0, -350, -180)

				var_14_0.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1070, var_14_6, var_14_5)
			end

			if arg_11_1.time_ >= var_14_1 + var_14_4 and arg_11_1.time_ < var_14_1 + var_14_4 + arg_14_0 then
				var_14_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_14_7 = arg_11_1.actors_["1070"]
			local var_14_8 = 0

			if var_14_8 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 and arg_11_1.var_.actorSpriteComps1070 == nil then
				arg_11_1.var_.actorSpriteComps1070 = var_14_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_14_9 = 0.034

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_9 then
				local var_14_10 = (arg_11_1.time_ - var_14_8) / var_14_9

				if arg_11_1.var_.actorSpriteComps1070 then
					for iter_14_1, iter_14_2 in pairs(arg_11_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_14_2 then
							local var_14_11 = Mathf.Lerp(iter_14_2.color.r, 1, var_14_10)

							iter_14_2.color = Color.New(var_14_11, var_14_11, var_14_11)
						end
					end
				end
			end

			if arg_11_1.time_ >= var_14_8 + var_14_9 and arg_11_1.time_ < var_14_8 + var_14_9 + arg_14_0 and arg_11_1.var_.actorSpriteComps1070 then
				local var_14_12 = 1

				for iter_14_3, iter_14_4 in pairs(arg_11_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_14_4 then
						iter_14_4.color = Color.New(var_14_12, var_14_12, var_14_12)
					end
				end

				arg_11_1.var_.actorSpriteComps1070 = nil
			end

			local var_14_13 = 0
			local var_14_14 = 0.425

			if var_14_13 < arg_11_1.time_ and arg_11_1.time_ <= var_14_13 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_15 = arg_11_1:FormatText(StoryNameCfg[318].name)

				arg_11_1.leftNameTxt_.text = var_14_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_16 = arg_11_1:GetWordFromCfg(910810003)
				local var_14_17 = arg_11_1:FormatText(var_14_16.content)

				arg_11_1.text_.text = var_14_17

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_18 = 17
				local var_14_19 = utf8.len(var_14_17)
				local var_14_20 = var_14_18 <= 0 and var_14_14 or var_14_14 * (var_14_19 / var_14_18)

				if var_14_20 > 0 and var_14_14 < var_14_20 then
					arg_11_1.talkMaxDuration = var_14_20

					if var_14_20 + var_14_13 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_13
					end
				end

				arg_11_1.text_.text = var_14_17
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_14, arg_11_1.talkMaxDuration)

			if var_14_13 <= arg_11_1.time_ and arg_11_1.time_ < var_14_13 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_13) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_13 + var_14_21 and arg_11_1.time_ < var_14_13 + var_14_21 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play910810004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910810004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910810005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1070"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1070 = var_18_0.localPosition
				var_18_0.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("1070", 3)

				local var_18_2 = var_18_0.childCount

				for iter_18_0 = 0, var_18_2 - 1 do
					local var_18_3 = var_18_0:GetChild(iter_18_0)

					if var_18_3.name == "split_2" or not string.find(var_18_3.name, "split") then
						var_18_3.gameObject:SetActive(true)
					else
						var_18_3.gameObject:SetActive(false)
					end
				end
			end

			local var_18_4 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_4 then
				local var_18_5 = (arg_15_1.time_ - var_18_1) / var_18_4
				local var_18_6 = Vector3.New(0, -350, -180)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1070, var_18_6, var_18_5)
			end

			if arg_15_1.time_ >= var_18_1 + var_18_4 and arg_15_1.time_ < var_18_1 + var_18_4 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_18_7 = arg_15_1.actors_["1070"]
			local var_18_8 = 0

			if var_18_8 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 and arg_15_1.var_.actorSpriteComps1070 == nil then
				arg_15_1.var_.actorSpriteComps1070 = var_18_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_9 = 0.034

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_9 then
				local var_18_10 = (arg_15_1.time_ - var_18_8) / var_18_9

				if arg_15_1.var_.actorSpriteComps1070 then
					for iter_18_1, iter_18_2 in pairs(arg_15_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_18_2 then
							local var_18_11 = Mathf.Lerp(iter_18_2.color.r, 0.5, var_18_10)

							iter_18_2.color = Color.New(var_18_11, var_18_11, var_18_11)
						end
					end
				end
			end

			if arg_15_1.time_ >= var_18_8 + var_18_9 and arg_15_1.time_ < var_18_8 + var_18_9 + arg_18_0 and arg_15_1.var_.actorSpriteComps1070 then
				local var_18_12 = 0.5

				for iter_18_3, iter_18_4 in pairs(arg_15_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_18_4 then
						iter_18_4.color = Color.New(var_18_12, var_18_12, var_18_12)
					end
				end

				arg_15_1.var_.actorSpriteComps1070 = nil
			end

			local var_18_13 = 0
			local var_18_14 = 0.275

			if var_18_13 < arg_15_1.time_ and arg_15_1.time_ <= var_18_13 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_15 = arg_15_1:FormatText(StoryNameCfg[623].name)

				arg_15_1.leftNameTxt_.text = var_18_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_16 = arg_15_1:GetWordFromCfg(910810004)
				local var_18_17 = arg_15_1:FormatText(var_18_16.content)

				arg_15_1.text_.text = var_18_17

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_18 = 11
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
	Play910810005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910810005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910810006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1070"].transform
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.var_.moveOldPos1070 = var_22_0.localPosition
				var_22_0.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1070", 3)

				local var_22_2 = var_22_0.childCount

				for iter_22_0 = 0, var_22_2 - 1 do
					local var_22_3 = var_22_0:GetChild(iter_22_0)

					if var_22_3.name == "split_2" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_4 then
				local var_22_5 = (arg_19_1.time_ - var_22_1) / var_22_4
				local var_22_6 = Vector3.New(0, -350, -180)

				var_22_0.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1070, var_22_6, var_22_5)
			end

			if arg_19_1.time_ >= var_22_1 + var_22_4 and arg_19_1.time_ < var_22_1 + var_22_4 + arg_22_0 then
				var_22_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_22_7 = arg_19_1.actors_["1070"]
			local var_22_8 = 0

			if var_22_8 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 and arg_19_1.var_.actorSpriteComps1070 == nil then
				arg_19_1.var_.actorSpriteComps1070 = var_22_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_9 = 0.034

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_9 then
				local var_22_10 = (arg_19_1.time_ - var_22_8) / var_22_9

				if arg_19_1.var_.actorSpriteComps1070 then
					for iter_22_1, iter_22_2 in pairs(arg_19_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_22_2 then
							local var_22_11 = Mathf.Lerp(iter_22_2.color.r, 0.5, var_22_10)

							iter_22_2.color = Color.New(var_22_11, var_22_11, var_22_11)
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_8 + var_22_9 and arg_19_1.time_ < var_22_8 + var_22_9 + arg_22_0 and arg_19_1.var_.actorSpriteComps1070 then
				local var_22_12 = 0.5

				for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_22_4 then
						iter_22_4.color = Color.New(var_22_12, var_22_12, var_22_12)
					end
				end

				arg_19_1.var_.actorSpriteComps1070 = nil
			end

			local var_22_13 = 0
			local var_22_14 = 0.75

			if var_22_13 < arg_19_1.time_ and arg_19_1.time_ <= var_22_13 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_15 = arg_19_1:FormatText(StoryNameCfg[7].name)

				arg_19_1.leftNameTxt_.text = var_22_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_16 = arg_19_1:GetWordFromCfg(910810005)
				local var_22_17 = arg_19_1:FormatText(var_22_16.content)

				arg_19_1.text_.text = var_22_17

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_18 = 30
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
	Play910810006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910810006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910810007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1070"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070 = var_26_0.localPosition
				var_26_0.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1070", 3)

				local var_26_2 = var_26_0.childCount

				for iter_26_0 = 0, var_26_2 - 1 do
					local var_26_3 = var_26_0:GetChild(iter_26_0)

					if var_26_3.name == "split_1_1" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_4 then
				local var_26_5 = (arg_23_1.time_ - var_26_1) / var_26_4
				local var_26_6 = Vector3.New(0, -350, -180)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070, var_26_6, var_26_5)
			end

			if arg_23_1.time_ >= var_26_1 + var_26_4 and arg_23_1.time_ < var_26_1 + var_26_4 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_26_7 = arg_23_1.actors_["1070"]
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 and arg_23_1.var_.actorSpriteComps1070 == nil then
				arg_23_1.var_.actorSpriteComps1070 = var_26_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_9 = 0.034

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 then
				local var_26_10 = (arg_23_1.time_ - var_26_8) / var_26_9

				if arg_23_1.var_.actorSpriteComps1070 then
					for iter_26_1, iter_26_2 in pairs(arg_23_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_26_2 then
							local var_26_11 = Mathf.Lerp(iter_26_2.color.r, 1, var_26_10)

							iter_26_2.color = Color.New(var_26_11, var_26_11, var_26_11)
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 and arg_23_1.var_.actorSpriteComps1070 then
				local var_26_12 = 1

				for iter_26_3, iter_26_4 in pairs(arg_23_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_26_4 then
						iter_26_4.color = Color.New(var_26_12, var_26_12, var_26_12)
					end
				end

				arg_23_1.var_.actorSpriteComps1070 = nil
			end

			local var_26_13 = 0
			local var_26_14 = 0.25

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_15 = arg_23_1:FormatText(StoryNameCfg[318].name)

				arg_23_1.leftNameTxt_.text = var_26_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_16 = arg_23_1:GetWordFromCfg(910810006)
				local var_26_17 = arg_23_1:FormatText(var_26_16.content)

				arg_23_1.text_.text = var_26_17

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_18 = 10
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
	Play910810007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910810007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910810008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1070"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1070 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1070", 3)

				local var_30_2 = var_30_0.childCount

				for iter_30_0 = 0, var_30_2 - 1 do
					local var_30_3 = var_30_0:GetChild(iter_30_0)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_4 then
				local var_30_5 = (arg_27_1.time_ - var_30_1) / var_30_4
				local var_30_6 = Vector3.New(0, -350, -180)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1070, var_30_6, var_30_5)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_4 and arg_27_1.time_ < var_30_1 + var_30_4 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_30_7 = arg_27_1.actors_["1070"]
			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 and arg_27_1.var_.actorSpriteComps1070 == nil then
				arg_27_1.var_.actorSpriteComps1070 = var_30_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_9 = 0.034

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 then
				local var_30_10 = (arg_27_1.time_ - var_30_8) / var_30_9

				if arg_27_1.var_.actorSpriteComps1070 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_30_2 then
							local var_30_11 = Mathf.Lerp(iter_30_2.color.r, 1, var_30_10)

							iter_30_2.color = Color.New(var_30_11, var_30_11, var_30_11)
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 and arg_27_1.var_.actorSpriteComps1070 then
				local var_30_12 = 1

				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_30_4 then
						iter_30_4.color = Color.New(var_30_12, var_30_12, var_30_12)
					end
				end

				arg_27_1.var_.actorSpriteComps1070 = nil
			end

			local var_30_13 = 0
			local var_30_14 = 0.8

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_15 = arg_27_1:FormatText(StoryNameCfg[318].name)

				arg_27_1.leftNameTxt_.text = var_30_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_16 = arg_27_1:GetWordFromCfg(910810007)
				local var_30_17 = arg_27_1:FormatText(var_30_16.content)

				arg_27_1.text_.text = var_30_17

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_18 = 32
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
	Play910810008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910810008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910810009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1070"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1070 = var_34_0.localPosition
				var_34_0.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1070", 3)

				local var_34_2 = var_34_0.childCount

				for iter_34_0 = 0, var_34_2 - 1 do
					local var_34_3 = var_34_0:GetChild(iter_34_0)

					if var_34_3.name == "" or not string.find(var_34_3.name, "split") then
						var_34_3.gameObject:SetActive(true)
					else
						var_34_3.gameObject:SetActive(false)
					end
				end
			end

			local var_34_4 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_4 then
				local var_34_5 = (arg_31_1.time_ - var_34_1) / var_34_4
				local var_34_6 = Vector3.New(0, -350, -180)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1070, var_34_6, var_34_5)
			end

			if arg_31_1.time_ >= var_34_1 + var_34_4 and arg_31_1.time_ < var_34_1 + var_34_4 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_34_7 = arg_31_1.actors_["1070"]
			local var_34_8 = 0

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 and arg_31_1.var_.actorSpriteComps1070 == nil then
				arg_31_1.var_.actorSpriteComps1070 = var_34_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_9 = 0.034

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_9 then
				local var_34_10 = (arg_31_1.time_ - var_34_8) / var_34_9

				if arg_31_1.var_.actorSpriteComps1070 then
					for iter_34_1, iter_34_2 in pairs(arg_31_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_34_2 then
							local var_34_11 = Mathf.Lerp(iter_34_2.color.r, 0.5, var_34_10)

							iter_34_2.color = Color.New(var_34_11, var_34_11, var_34_11)
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_8 + var_34_9 and arg_31_1.time_ < var_34_8 + var_34_9 + arg_34_0 and arg_31_1.var_.actorSpriteComps1070 then
				local var_34_12 = 0.5

				for iter_34_3, iter_34_4 in pairs(arg_31_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_34_4 then
						iter_34_4.color = Color.New(var_34_12, var_34_12, var_34_12)
					end
				end

				arg_31_1.var_.actorSpriteComps1070 = nil
			end

			local var_34_13 = 0
			local var_34_14 = 0.225

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_15 = arg_31_1:FormatText(StoryNameCfg[7].name)

				arg_31_1.leftNameTxt_.text = var_34_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_16 = arg_31_1:GetWordFromCfg(910810008)
				local var_34_17 = arg_31_1:FormatText(var_34_16.content)

				arg_31_1.text_.text = var_34_17

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_18 = 9
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
	Play910810009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910810009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910810010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1070"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1070 = var_38_0.localPosition
				var_38_0.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1070", 3)

				local var_38_2 = var_38_0.childCount

				for iter_38_0 = 0, var_38_2 - 1 do
					local var_38_3 = var_38_0:GetChild(iter_38_0)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_1) / var_38_4
				local var_38_6 = Vector3.New(0, -350, -180)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1070, var_38_6, var_38_5)
			end

			if arg_35_1.time_ >= var_38_1 + var_38_4 and arg_35_1.time_ < var_38_1 + var_38_4 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_38_7 = arg_35_1.actors_["1070"]
			local var_38_8 = 0

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 and arg_35_1.var_.actorSpriteComps1070 == nil then
				arg_35_1.var_.actorSpriteComps1070 = var_38_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_9 = 0.034

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_9 then
				local var_38_10 = (arg_35_1.time_ - var_38_8) / var_38_9

				if arg_35_1.var_.actorSpriteComps1070 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_38_2 then
							local var_38_11 = Mathf.Lerp(iter_38_2.color.r, 1, var_38_10)

							iter_38_2.color = Color.New(var_38_11, var_38_11, var_38_11)
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_8 + var_38_9 and arg_35_1.time_ < var_38_8 + var_38_9 + arg_38_0 and arg_35_1.var_.actorSpriteComps1070 then
				local var_38_12 = 1

				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_38_4 then
						iter_38_4.color = Color.New(var_38_12, var_38_12, var_38_12)
					end
				end

				arg_35_1.var_.actorSpriteComps1070 = nil
			end

			local var_38_13 = 0
			local var_38_14 = 0.75

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_15 = arg_35_1:FormatText(StoryNameCfg[318].name)

				arg_35_1.leftNameTxt_.text = var_38_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_16 = arg_35_1:GetWordFromCfg(910810009)
				local var_38_17 = arg_35_1:FormatText(var_38_16.content)

				arg_35_1.text_.text = var_38_17

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_18 = 30
				local var_38_19 = utf8.len(var_38_17)
				local var_38_20 = var_38_18 <= 0 and var_38_14 or var_38_14 * (var_38_19 / var_38_18)

				if var_38_20 > 0 and var_38_14 < var_38_20 then
					arg_35_1.talkMaxDuration = var_38_20

					if var_38_20 + var_38_13 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_20 + var_38_13
					end
				end

				arg_35_1.text_.text = var_38_17
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = math.max(var_38_14, arg_35_1.talkMaxDuration)

			if var_38_13 <= arg_35_1.time_ and arg_35_1.time_ < var_38_13 + var_38_21 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_13) / var_38_21

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_13 + var_38_21 and arg_35_1.time_ < var_38_13 + var_38_21 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play910810010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910810010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910810011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1070"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1070 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1070", 3)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_6" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(0, -350, -180)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1070, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_42_7 = arg_39_1.actors_["1070"]
			local var_42_8 = 0

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 and arg_39_1.var_.actorSpriteComps1070 == nil then
				arg_39_1.var_.actorSpriteComps1070 = var_42_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_9 = 0.034

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_9 then
				local var_42_10 = (arg_39_1.time_ - var_42_8) / var_42_9

				if arg_39_1.var_.actorSpriteComps1070 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_42_2 then
							local var_42_11 = Mathf.Lerp(iter_42_2.color.r, 1, var_42_10)

							iter_42_2.color = Color.New(var_42_11, var_42_11, var_42_11)
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_8 + var_42_9 and arg_39_1.time_ < var_42_8 + var_42_9 + arg_42_0 and arg_39_1.var_.actorSpriteComps1070 then
				local var_42_12 = 1

				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_42_4 then
						iter_42_4.color = Color.New(var_42_12, var_42_12, var_42_12)
					end
				end

				arg_39_1.var_.actorSpriteComps1070 = nil
			end

			local var_42_13 = 0
			local var_42_14 = 0.575

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_15 = arg_39_1:FormatText(StoryNameCfg[318].name)

				arg_39_1.leftNameTxt_.text = var_42_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_16 = arg_39_1:GetWordFromCfg(910810010)
				local var_42_17 = arg_39_1:FormatText(var_42_16.content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_18 = 23
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
	Play910810011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910810011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910810012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1070"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1070 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1070", 3)

				local var_46_2 = var_46_0.childCount

				for iter_46_0 = 0, var_46_2 - 1 do
					local var_46_3 = var_46_0:GetChild(iter_46_0)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_4 then
				local var_46_5 = (arg_43_1.time_ - var_46_1) / var_46_4
				local var_46_6 = Vector3.New(0, -350, -180)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1070, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_46_7 = arg_43_1.actors_["1070"]
			local var_46_8 = 0

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 and arg_43_1.var_.actorSpriteComps1070 == nil then
				arg_43_1.var_.actorSpriteComps1070 = var_46_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 0.034

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 then
				local var_46_10 = (arg_43_1.time_ - var_46_8) / var_46_9

				if arg_43_1.var_.actorSpriteComps1070 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_46_2 then
							local var_46_11 = Mathf.Lerp(iter_46_2.color.r, 0.5, var_46_10)

							iter_46_2.color = Color.New(var_46_11, var_46_11, var_46_11)
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 and arg_43_1.var_.actorSpriteComps1070 then
				local var_46_12 = 0.5

				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_46_4 then
						iter_46_4.color = Color.New(var_46_12, var_46_12, var_46_12)
					end
				end

				arg_43_1.var_.actorSpriteComps1070 = nil
			end

			local var_46_13 = 0
			local var_46_14 = 0.425

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_15 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_16 = arg_43_1:GetWordFromCfg(910810011)
				local var_46_17 = arg_43_1:FormatText(var_46_16.content)

				arg_43_1.text_.text = var_46_17

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_18 = 17
				local var_46_19 = utf8.len(var_46_17)
				local var_46_20 = var_46_18 <= 0 and var_46_14 or var_46_14 * (var_46_19 / var_46_18)

				if var_46_20 > 0 and var_46_14 < var_46_20 then
					arg_43_1.talkMaxDuration = var_46_20

					if var_46_20 + var_46_13 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_13
					end
				end

				arg_43_1.text_.text = var_46_17
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_21 = math.max(var_46_14, arg_43_1.talkMaxDuration)

			if var_46_13 <= arg_43_1.time_ and arg_43_1.time_ < var_46_13 + var_46_21 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_13) / var_46_21

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_13 + var_46_21 and arg_43_1.time_ < var_46_13 + var_46_21 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play910810012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910810012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910810013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1070"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1070 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1070", 3)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_7" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -350, -180)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1070, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_50_7 = arg_47_1.actors_["1070"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and arg_47_1.var_.actorSpriteComps1070 == nil then
				arg_47_1.var_.actorSpriteComps1070 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 0.034

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps1070 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_50_2 then
							local var_50_11 = Mathf.Lerp(iter_50_2.color.r, 0.5, var_50_10)

							iter_50_2.color = Color.New(var_50_11, var_50_11, var_50_11)
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and arg_47_1.var_.actorSpriteComps1070 then
				local var_50_12 = 0.5

				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = Color.New(var_50_12, var_50_12, var_50_12)
					end
				end

				arg_47_1.var_.actorSpriteComps1070 = nil
			end

			local var_50_13 = 0
			local var_50_14 = 1.2

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_15 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_16 = arg_47_1:GetWordFromCfg(910810012)
				local var_50_17 = arg_47_1:FormatText(var_50_16.content)

				arg_47_1.text_.text = var_50_17

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_18 = 48
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
	Play910810013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910810013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910810014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1070"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1070 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1070", 3)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "split_9" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(0, -350, -180)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1070, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_54_7 = arg_51_1.actors_["1070"]
			local var_54_8 = 0

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 and arg_51_1.var_.actorSpriteComps1070 == nil then
				arg_51_1.var_.actorSpriteComps1070 = var_54_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 0.034

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 then
				local var_54_10 = (arg_51_1.time_ - var_54_8) / var_54_9

				if arg_51_1.var_.actorSpriteComps1070 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_54_2 then
							local var_54_11 = Mathf.Lerp(iter_54_2.color.r, 0.5, var_54_10)

							iter_54_2.color = Color.New(var_54_11, var_54_11, var_54_11)
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 and arg_51_1.var_.actorSpriteComps1070 then
				local var_54_12 = 0.5

				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_54_4 then
						iter_54_4.color = Color.New(var_54_12, var_54_12, var_54_12)
					end
				end

				arg_51_1.var_.actorSpriteComps1070 = nil
			end

			local var_54_13 = 0
			local var_54_14 = 0.4

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_15 = arg_51_1:GetWordFromCfg(910810013)
				local var_54_16 = arg_51_1:FormatText(var_54_15.content)

				arg_51_1.text_.text = var_54_16

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 16
				local var_54_18 = utf8.len(var_54_16)
				local var_54_19 = var_54_17 <= 0 and var_54_14 or var_54_14 * (var_54_18 / var_54_17)

				if var_54_19 > 0 and var_54_14 < var_54_19 then
					arg_51_1.talkMaxDuration = var_54_19

					if var_54_19 + var_54_13 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_13
					end
				end

				arg_51_1.text_.text = var_54_16
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_14, arg_51_1.talkMaxDuration)

			if var_54_13 <= arg_51_1.time_ and arg_51_1.time_ < var_54_13 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_13) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_13 + var_54_20 and arg_51_1.time_ < var_54_13 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play910810014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910810014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910810015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1070"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1070 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1070", 3)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "split_9" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(0, -350, -180)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1070, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_58_7 = arg_55_1.actors_["1070"]
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 and arg_55_1.var_.actorSpriteComps1070 == nil then
				arg_55_1.var_.actorSpriteComps1070 = var_58_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 0.034

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = (arg_55_1.time_ - var_58_8) / var_58_9

				if arg_55_1.var_.actorSpriteComps1070 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_58_2 then
							local var_58_11 = Mathf.Lerp(iter_58_2.color.r, 1, var_58_10)

							iter_58_2.color = Color.New(var_58_11, var_58_11, var_58_11)
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 and arg_55_1.var_.actorSpriteComps1070 then
				local var_58_12 = 1

				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = Color.New(var_58_12, var_58_12, var_58_12)
					end
				end

				arg_55_1.var_.actorSpriteComps1070 = nil
			end

			local var_58_13 = 0
			local var_58_14 = 0.55

			if var_58_13 < arg_55_1.time_ and arg_55_1.time_ <= var_58_13 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_15 = arg_55_1:FormatText(StoryNameCfg[318].name)

				arg_55_1.leftNameTxt_.text = var_58_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_16 = arg_55_1:GetWordFromCfg(910810014)
				local var_58_17 = arg_55_1:FormatText(var_58_16.content)

				arg_55_1.text_.text = var_58_17

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_18 = 22
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
	Play910810015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910810015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
			arg_59_1.auto_ = false
		end

		function arg_59_1.playNext_(arg_61_0)
			arg_59_1.onStoryFinished_()
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1070"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1070 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1070", 3)

				local var_62_2 = var_62_0.childCount

				for iter_62_0 = 0, var_62_2 - 1 do
					local var_62_3 = var_62_0:GetChild(iter_62_0)

					if var_62_3.name == "split_2" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_4 then
				local var_62_5 = (arg_59_1.time_ - var_62_1) / var_62_4
				local var_62_6 = Vector3.New(0, -350, -180)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1070, var_62_6, var_62_5)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_4 and arg_59_1.time_ < var_62_1 + var_62_4 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_62_7 = arg_59_1.actors_["1070"]
			local var_62_8 = 0

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 and arg_59_1.var_.actorSpriteComps1070 == nil then
				arg_59_1.var_.actorSpriteComps1070 = var_62_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_9 = 0.034

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 then
				local var_62_10 = (arg_59_1.time_ - var_62_8) / var_62_9

				if arg_59_1.var_.actorSpriteComps1070 then
					for iter_62_1, iter_62_2 in pairs(arg_59_1.var_.actorSpriteComps1070:ToTable()) do
						if iter_62_2 then
							local var_62_11 = Mathf.Lerp(iter_62_2.color.r, 1, var_62_10)

							iter_62_2.color = Color.New(var_62_11, var_62_11, var_62_11)
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 and arg_59_1.var_.actorSpriteComps1070 then
				local var_62_12 = 1

				for iter_62_3, iter_62_4 in pairs(arg_59_1.var_.actorSpriteComps1070:ToTable()) do
					if iter_62_4 then
						iter_62_4.color = Color.New(var_62_12, var_62_12, var_62_12)
					end
				end

				arg_59_1.var_.actorSpriteComps1070 = nil
			end

			local var_62_13 = 0
			local var_62_14 = 1

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				local var_62_15 = "play"
				local var_62_16 = "effect"

				arg_59_1:AudioAction(var_62_15, var_62_16, "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_62_17 = 0
			local var_62_18 = 0.4

			if var_62_17 < arg_59_1.time_ and arg_59_1.time_ <= var_62_17 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_19 = arg_59_1:FormatText(StoryNameCfg[318].name)

				arg_59_1.leftNameTxt_.text = var_62_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_20 = arg_59_1:GetWordFromCfg(910810015)
				local var_62_21 = arg_59_1:FormatText(var_62_20.content)

				arg_59_1.text_.text = var_62_21

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_22 = 16
				local var_62_23 = utf8.len(var_62_21)
				local var_62_24 = var_62_22 <= 0 and var_62_18 or var_62_18 * (var_62_23 / var_62_22)

				if var_62_24 > 0 and var_62_18 < var_62_24 then
					arg_59_1.talkMaxDuration = var_62_24

					if var_62_24 + var_62_17 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_24 + var_62_17
					end
				end

				arg_59_1.text_.text = var_62_21
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_18, arg_59_1.talkMaxDuration)

			if var_62_17 <= arg_59_1.time_ and arg_59_1.time_ < var_62_17 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_17) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_17 + var_62_25 and arg_59_1.time_ < var_62_17 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST12"
	},
	voices = {}
}
