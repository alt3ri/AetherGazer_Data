local var_0_0 = {
	Play900401003 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900401003
		arg_1_1.duration_ = 1.033399999999

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900401004(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "Volume"

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
				local var_4_5 = arg_1_1.bgs_.Volume

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
					if iter_4_0 ~= "Volume" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				SetActive(arg_1_1.hideBtn_, false)
				SetActive(arg_1_1.narrativeGo_, true)

				local var_4_17 = arg_1_0.narr_chapter_text
				local var_4_18 = arg_1_0.narr_time_text
				local var_4_19 = arg_1_1:GetWordFromCfg(900401001)

				var_4_17.text = arg_1_1:FormatText(var_4_19.content)

				local var_4_20 = arg_1_1:GetWordFromCfg(900401002)

				var_4_18.text = arg_1_1:FormatText(var_4_20.content)
				arg_1_1.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				local var_4_21 = arg_1_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_4_21 then
					var_4_21.raycastTarget = false
				end

				SetActive(arg_1_1.narrativeContinueBtn_.gameObject, false)
			end

			local var_4_22 = 0.0334

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_22 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= var_4_16 + var_4_22 and arg_1_1.time_ < var_4_16 + var_4_22 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			local var_4_23 = 0.0334

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				local var_4_24 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_25 = var_4_24:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_24)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				local var_4_26 = arg_1_1:GetWordFromCfg(900401003)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_0.narr_item_content.text = var_4_27

				var_4_24.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_24.transform.localPosition = Vector3(0, 0, 0)
				var_4_24.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_24, true)
			end

			local var_4_28 = 1

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_28 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= var_4_23 + var_4_28 and arg_1_1.time_ < var_4_23 + var_4_28 + arg_4_0 then
				-- block empty
			end

			local var_4_29 = 0
			local var_4_30 = 0.2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "music"

				arg_1_1:AudioAction(var_4_31, var_4_32, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_33 = 0.6
			local var_4_34 = 0.4

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")
			end
		end
	end,
	Play900401004 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 900401004
		arg_5_1.duration_ = 0.999999999999

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play900401005(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			local var_8_0 = 0

			if var_8_0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_0 + arg_8_0 then
				local var_8_1 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_2 = var_8_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_1)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				local var_8_3 = arg_5_1:GetWordFromCfg(900401004)
				local var_8_4 = arg_5_1:FormatText(var_8_3.content)

				arg_5_0.narr_item_content.text = var_8_4

				var_8_1.transform:SetParent(arg_5_1.narrativeItemGo_.transform.parent)

				var_8_1.transform.localPosition = Vector3(0, 0, 0)
				var_8_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_8_1, true)
			end

			local var_8_5 = 1

			if var_8_0 <= arg_5_1.time_ and arg_5_1.time_ < var_8_0 + var_8_5 and arg_5_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_5_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_5_1.time_ >= var_8_0 + var_8_5 and arg_5_1.time_ < var_8_0 + var_8_5 + arg_8_0 then
				-- block empty
			end
		end
	end,
	Play900401005 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 900401005
		arg_9_1.duration_ = 0.999999999999

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play900401006(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_1 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_2 = var_12_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_1)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_12_3 = arg_9_1:GetWordFromCfg(900401005)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_0.narr_item_content.text = var_12_4

				var_12_1.transform:SetParent(arg_9_1.narrativeItemGo_.transform.parent)

				var_12_1.transform.localPosition = Vector3(0, 0, 0)
				var_12_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_12_1, true)
			end

			local var_12_5 = 1

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_5 and arg_9_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_9_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_9_1.time_ >= var_12_0 + var_12_5 and arg_9_1.time_ < var_12_0 + var_12_5 + arg_12_0 then
				-- block empty
			end
		end
	end,
	Play900401006 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 900401006
		arg_13_1.duration_ = 0.999999999999

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play900401007(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_1 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_2 = var_16_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_1)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_16_3 = arg_13_1:GetWordFromCfg(900401006)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_0.narr_item_content.text = var_16_4

				var_16_1.transform:SetParent(arg_13_1.narrativeItemGo_.transform.parent)

				var_16_1.transform.localPosition = Vector3(0, 0, 0)
				var_16_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_16_1, true)
			end

			local var_16_5 = 1

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_5 and arg_13_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_13_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_13_1.time_ >= var_16_0 + var_16_5 and arg_13_1.time_ < var_16_0 + var_16_5 + arg_16_0 then
				-- block empty
			end
		end
	end,
	Play900401007 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 900401007
		arg_17_1.duration_ = 0.999999999999

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play900401008(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				local var_20_1 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_2 = var_20_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_1)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				local var_20_3 = arg_17_1:GetWordFromCfg(900401007)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_0.narr_item_content.text = var_20_4

				var_20_1.transform:SetParent(arg_17_1.narrativeItemGo_.transform.parent)

				var_20_1.transform.localPosition = Vector3(0, 0, 0)
				var_20_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_20_1, true)
			end

			local var_20_5 = 1

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_5 and arg_17_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_17_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_17_1.time_ >= var_20_0 + var_20_5 and arg_17_1.time_ < var_20_0 + var_20_5 + arg_20_0 then
				-- block empty
			end
		end
	end,
	Play900401008 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 900401008
		arg_21_1.duration_ = 0.999999999999

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play900401009(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_1 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_2 = var_24_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_1)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				local var_24_3 = arg_21_1:GetWordFromCfg(900401008)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_0.narr_item_content.text = var_24_4

				var_24_1.transform:SetParent(arg_21_1.narrativeItemGo_.transform.parent)

				var_24_1.transform.localPosition = Vector3(0, 0, 0)
				var_24_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_24_1, true)
			end

			local var_24_5 = 1

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_5 and arg_21_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_21_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_21_1.time_ >= var_24_0 + var_24_5 and arg_21_1.time_ < var_24_0 + var_24_5 + arg_24_0 then
				-- block empty
			end
		end
	end,
	Play900401009 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 900401009
		arg_25_1.duration_ = 0.999999999999

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play900401010(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_1 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_2 = var_28_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_1)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10026_split_1")

				local var_28_3 = arg_25_1:GetWordFromCfg(900401009)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_0.narr_item_content.text = var_28_4

				var_28_1.transform:SetParent(arg_25_1.narrativeItemGo_.transform.parent)

				var_28_1.transform.localPosition = Vector3(0, 0, 0)
				var_28_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_28_1, true)
			end

			local var_28_5 = 1

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_5 and arg_25_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_25_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_25_1.time_ >= var_28_0 + var_28_5 and arg_25_1.time_ < var_28_0 + var_28_5 + arg_28_0 then
				-- block empty
			end
		end
	end,
	Play900401010 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 900401010
		arg_29_1.duration_ = 0.999999999999

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play900401011(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_1 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_2 = var_32_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_1)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10026_split_1")

				local var_32_3 = arg_29_1:GetWordFromCfg(900401010)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_0.narr_item_content.text = var_32_4

				var_32_1.transform:SetParent(arg_29_1.narrativeItemGo_.transform.parent)

				var_32_1.transform.localPosition = Vector3(0, 0, 0)
				var_32_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_32_1, true)
			end

			local var_32_5 = 1

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_5 and arg_29_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_29_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_29_1.time_ >= var_32_0 + var_32_5 and arg_29_1.time_ < var_32_0 + var_32_5 + arg_32_0 then
				-- block empty
			end
		end
	end,
	Play900401011 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 900401011
		arg_33_1.duration_ = 0.999999999999

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play900401012(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_1 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_2 = var_36_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_1)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10026_split_1")

				local var_36_3 = arg_33_1:GetWordFromCfg(900401011)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_0.narr_item_content.text = var_36_4

				var_36_1.transform:SetParent(arg_33_1.narrativeItemGo_.transform.parent)

				var_36_1.transform.localPosition = Vector3(0, 0, 0)
				var_36_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_36_1, true)
			end

			local var_36_5 = 1

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_5 and arg_33_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_33_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_33_1.time_ >= var_36_0 + var_36_5 and arg_33_1.time_ < var_36_0 + var_36_5 + arg_36_0 then
				-- block empty
			end
		end
	end,
	Play900401012 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 900401012
		arg_37_1.duration_ = 0.999999999999

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play900401013(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				local var_40_1 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_2 = var_40_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_1)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				local var_40_3 = arg_37_1:GetWordFromCfg(900401012)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_0.narr_item_content.text = var_40_4

				var_40_1.transform:SetParent(arg_37_1.narrativeItemGo_.transform.parent)

				var_40_1.transform.localPosition = Vector3(0, 0, 0)
				var_40_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_40_1, true)
			end

			local var_40_5 = 1

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_5 and arg_37_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_37_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_37_1.time_ >= var_40_0 + var_40_5 and arg_37_1.time_ < var_40_0 + var_40_5 + arg_40_0 then
				-- block empty
			end
		end
	end,
	Play900401013 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 900401013
		arg_41_1.duration_ = 0.999999999999

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play900401014(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				local var_44_1 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_2 = var_44_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_1)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				local var_44_3 = arg_41_1:GetWordFromCfg(900401013)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_0.narr_item_content.text = var_44_4

				var_44_1.transform:SetParent(arg_41_1.narrativeItemGo_.transform.parent)

				var_44_1.transform.localPosition = Vector3(0, 0, 0)
				var_44_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_44_1, true)
			end

			local var_44_5 = 1

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_5 and arg_41_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_41_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_41_1.time_ >= var_44_0 + var_44_5 and arg_41_1.time_ < var_44_0 + var_44_5 + arg_44_0 then
				-- block empty
			end
		end
	end,
	Play900401014 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 900401014
		arg_45_1.duration_ = 0.999999999999

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play900401015(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_1 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_2 = var_48_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_1)

				arg_45_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				local var_48_3 = arg_45_1:GetWordFromCfg(900401014)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_0.narr_item_content.text = var_48_4

				var_48_1.transform:SetParent(arg_45_1.narrativeItemGo_.transform.parent)

				var_48_1.transform.localPosition = Vector3(0, 0, 0)
				var_48_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_48_1, true)
			end

			local var_48_5 = 1

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_5 and arg_45_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_45_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_45_1.time_ >= var_48_0 + var_48_5 and arg_45_1.time_ < var_48_0 + var_48_5 + arg_48_0 then
				-- block empty
			end
		end
	end,
	Play900401015 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 900401015
		arg_49_1.duration_ = 0.999999999999

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play900401016(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				local var_52_1 = Object.Instantiate(arg_49_1.narrativeItemGo_)
				local var_52_2 = var_52_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_49_0, var_52_1)

				arg_49_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				local var_52_3 = arg_49_1:GetWordFromCfg(900401015)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_0.narr_item_content.text = var_52_4

				var_52_1.transform:SetParent(arg_49_1.narrativeItemGo_.transform.parent)

				var_52_1.transform.localPosition = Vector3(0, 0, 0)
				var_52_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_52_1, true)
			end

			local var_52_5 = 1

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_5 and arg_49_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_49_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_49_1.time_ >= var_52_0 + var_52_5 and arg_49_1.time_ < var_52_0 + var_52_5 + arg_52_0 then
				-- block empty
			end
		end
	end,
	Play900401016 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 900401016
		arg_53_1.duration_ = 0.999999999999

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play900401017(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_53_0, arg_53_1.narrativeGo_)

			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_1 = Object.Instantiate(arg_53_1.narrativeItemGo_)
				local var_56_2 = var_56_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_53_0, var_56_1)

				arg_53_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_56_3 = arg_53_1:GetWordFromCfg(900401016)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_0.narr_item_content.text = var_56_4

				var_56_1.transform:SetParent(arg_53_1.narrativeItemGo_.transform.parent)

				var_56_1.transform.localPosition = Vector3(0, 0, 0)
				var_56_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_56_1, true)
			end

			local var_56_5 = 1

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_5 and arg_53_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_53_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_53_1.time_ >= var_56_0 + var_56_5 and arg_53_1.time_ < var_56_0 + var_56_5 + arg_56_0 then
				-- block empty
			end
		end
	end,
	Play900401017 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 900401017
		arg_57_1.duration_ = 0.999999999999

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play900401018(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_57_0, arg_57_1.narrativeGo_)

			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				local var_60_1 = Object.Instantiate(arg_57_1.narrativeItemGo_)
				local var_60_2 = var_60_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_57_0, var_60_1)

				arg_57_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_60_3 = arg_57_1:GetWordFromCfg(900401017)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_0.narr_item_content.text = var_60_4

				var_60_1.transform:SetParent(arg_57_1.narrativeItemGo_.transform.parent)

				var_60_1.transform.localPosition = Vector3(0, 0, 0)
				var_60_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_60_1, true)
			end

			local var_60_5 = 1

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_5 and arg_57_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_57_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_57_1.time_ >= var_60_0 + var_60_5 and arg_57_1.time_ < var_60_0 + var_60_5 + arg_60_0 then
				-- block empty
			end
		end
	end,
	Play900401018 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 900401018
		arg_61_1.duration_ = 0.999999999999

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play900401019(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_61_0, arg_61_1.narrativeGo_)

			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				local var_64_1 = Object.Instantiate(arg_61_1.narrativeItemGo_)
				local var_64_2 = var_64_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_61_0, var_64_1)

				arg_61_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_64_3 = arg_61_1:GetWordFromCfg(900401018)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_0.narr_item_content.text = var_64_4

				var_64_1.transform:SetParent(arg_61_1.narrativeItemGo_.transform.parent)

				var_64_1.transform.localPosition = Vector3(0, 0, 0)
				var_64_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_64_1, true)
			end

			local var_64_5 = 1

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_5 and arg_61_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_61_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_61_1.time_ >= var_64_0 + var_64_5 and arg_61_1.time_ < var_64_0 + var_64_5 + arg_64_0 then
				-- block empty
			end
		end
	end,
	Play900401019 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 900401019
		arg_65_1.duration_ = 0.999999999999

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play900401020(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_65_0, arg_65_1.narrativeGo_)

			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				local var_68_1 = Object.Instantiate(arg_65_1.narrativeItemGo_)
				local var_68_2 = var_68_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_65_0, var_68_1)

				arg_65_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_3")

				local var_68_3 = arg_65_1:GetWordFromCfg(900401019)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_0.narr_item_content.text = var_68_4

				var_68_1.transform:SetParent(arg_65_1.narrativeItemGo_.transform.parent)

				var_68_1.transform.localPosition = Vector3(0, 0, 0)
				var_68_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_68_1, true)
			end

			local var_68_5 = 1

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_5 and arg_65_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_65_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_65_1.time_ >= var_68_0 + var_68_5 and arg_65_1.time_ < var_68_0 + var_68_5 + arg_68_0 then
				-- block empty
			end
		end
	end,
	Play900401020 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 900401020
		arg_69_1.duration_ = 0.999999999999

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play900401021(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_69_0, arg_69_1.narrativeGo_)

			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				local var_72_1 = Object.Instantiate(arg_69_1.narrativeItemGo_)
				local var_72_2 = var_72_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_69_0, var_72_1)

				arg_69_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_72_3 = arg_69_1:GetWordFromCfg(900401020)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_0.narr_item_content.text = var_72_4

				var_72_1.transform:SetParent(arg_69_1.narrativeItemGo_.transform.parent)

				var_72_1.transform.localPosition = Vector3(0, 0, 0)
				var_72_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_72_1, true)
			end

			local var_72_5 = 1

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_5 and arg_69_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_69_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_69_1.time_ >= var_72_0 + var_72_5 and arg_69_1.time_ < var_72_0 + var_72_5 + arg_72_0 then
				-- block empty
			end
		end
	end,
	Play900401021 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 900401021
		arg_73_1.duration_ = 0.999999999999

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play900401022(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_73_0, arg_73_1.narrativeGo_)

			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				local var_76_1 = Object.Instantiate(arg_73_1.narrativeItemGo_)
				local var_76_2 = var_76_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_73_0, var_76_1)

				arg_73_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				local var_76_3 = arg_73_1:GetWordFromCfg(900401021)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_0.narr_item_content.text = var_76_4

				var_76_1.transform:SetParent(arg_73_1.narrativeItemGo_.transform.parent)

				var_76_1.transform.localPosition = Vector3(0, 0, 0)
				var_76_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_76_1, true)
			end

			local var_76_5 = 1

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_5 and arg_73_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_73_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_73_1.time_ >= var_76_0 + var_76_5 and arg_73_1.time_ < var_76_0 + var_76_5 + arg_76_0 then
				-- block empty
			end
		end
	end,
	Play900401022 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 900401022
		arg_77_1.duration_ = 0.999999999999

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play900401023(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_77_0, arg_77_1.narrativeGo_)

			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				local var_80_1 = Object.Instantiate(arg_77_1.narrativeItemGo_)
				local var_80_2 = var_80_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_77_0, var_80_1)

				arg_77_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				local var_80_3 = arg_77_1:GetWordFromCfg(900401022)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_0.narr_item_content.text = var_80_4

				var_80_1.transform:SetParent(arg_77_1.narrativeItemGo_.transform.parent)

				var_80_1.transform.localPosition = Vector3(0, 0, 0)
				var_80_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_80_1, true)
			end

			local var_80_5 = 1

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_5 and arg_77_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_77_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_77_1.time_ >= var_80_0 + var_80_5 and arg_77_1.time_ < var_80_0 + var_80_5 + arg_80_0 then
				-- block empty
			end
		end
	end,
	Play900401023 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 900401023
		arg_81_1.duration_ = 0.999999999999

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play900401024(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_81_0, arg_81_1.narrativeGo_)

			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				local var_84_1 = Object.Instantiate(arg_81_1.narrativeItemGo_)
				local var_84_2 = var_84_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_81_0, var_84_1)

				arg_81_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				local var_84_3 = arg_81_1:GetWordFromCfg(900401023)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_0.narr_item_content.text = var_84_4

				var_84_1.transform:SetParent(arg_81_1.narrativeItemGo_.transform.parent)

				var_84_1.transform.localPosition = Vector3(0, 0, 0)
				var_84_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_84_1, true)
			end

			local var_84_5 = 1

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_5 and arg_81_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_81_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_81_1.time_ >= var_84_0 + var_84_5 and arg_81_1.time_ < var_84_0 + var_84_5 + arg_84_0 then
				-- block empty
			end
		end
	end,
	Play900401024 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 900401024
		arg_85_1.duration_ = 0.999999999999

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play900401025(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_85_0, arg_85_1.narrativeGo_)

			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_1 = Object.Instantiate(arg_85_1.narrativeItemGo_)
				local var_88_2 = var_88_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_85_0, var_88_1)

				arg_85_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119_1_split_6")

				local var_88_3 = arg_85_1:GetWordFromCfg(900401024)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_0.narr_item_content.text = var_88_4

				var_88_1.transform:SetParent(arg_85_1.narrativeItemGo_.transform.parent)

				var_88_1.transform.localPosition = Vector3(0, 0, 0)
				var_88_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_88_1, true)
			end

			local var_88_5 = 1

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_5 and arg_85_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_85_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_85_1.time_ >= var_88_0 + var_88_5 and arg_85_1.time_ < var_88_0 + var_88_5 + arg_88_0 then
				-- block empty
			end
		end
	end,
	Play900401025 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 900401025
		arg_89_1.duration_ = 1.033399999999

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_89_0, arg_89_1.narrativeGo_)

			local var_92_0 = 0

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				local var_92_1 = Object.Instantiate(arg_89_1.narrativeItemGo_)
				local var_92_2 = var_92_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_89_0, var_92_1)

				arg_89_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_1")

				local var_92_3 = arg_89_1:GetWordFromCfg(900401025)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_0.narr_item_content.text = var_92_4

				var_92_1.transform:SetParent(arg_89_1.narrativeItemGo_.transform.parent)

				var_92_1.transform.localPosition = Vector3(0, 0, 0)
				var_92_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_92_1, true)
			end

			local var_92_5 = 1

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_5 and arg_89_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_89_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_89_1.time_ >= var_92_0 + var_92_5 and arg_89_1.time_ < var_92_0 + var_92_5 + arg_92_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_89_0, arg_89_1.narrativeGo_)

			local var_92_6 = 1

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				-- block empty
			end

			local var_92_7 = 0.0334

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_7 and arg_89_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_89_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_89_1.time_ >= var_92_6 + var_92_7 and arg_89_1.time_ < var_92_6 + var_92_7 + arg_92_0 then
				arg_89_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_92_8 = arg_89_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_92_8 then
					var_92_8.raycastTarget = true
				end

				SetActive(arg_89_1.narrativeContinueBtn_.gameObject, true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/Volume"
	},
	voices = {}
}

var_0_0.narrativeChapter = 900401001
var_0_0.narrativeTime = 900401002
var_0_0.narrativeData = {
	{
		"story_littleboyb",
		900401003
	},
	{
		"story_10022_split_6",
		900401004
	},
	{
		"story_yakuzab",
		900401005
	},
	{
		"story_yakuzab",
		900401006
	},
	{
		"story_citizenwc",
		900401007
	},
	{
		"story_citizenwc",
		900401008
	},
	{
		"story_10026_split_1",
		900401009
	},
	{
		"story_10026_split_1",
		900401010
	},
	{
		"story_10026_split_1",
		900401011
	},
	{
		"story_littleboyb",
		900401012
	},
	{
		"story_10022_split_6",
		900401013
	},
	{
		"story_10022_split_1",
		900401014
	},
	{
		"story_10022_split_1",
		900401015
	},
	{
		"story_yakuzab",
		900401016
	},
	{
		"story_yakuzab",
		900401017
	},
	{
		"story_yakuzab",
		900401018
	},
	{
		"story_10022_split_3",
		900401019
	},
	{
		"story_yakuzab",
		900401020
	},
	{
		"story_yakuzab",
		900401021
	},
	{
		"story_10022_split_6",
		900401022
	},
	{
		"story_10022_split_6",
		900401023
	},
	{
		"story_1119_1_split_6",
		900401024
	},
	{
		"story_10022_split_1",
		900401025
	}
}

return var_0_0
