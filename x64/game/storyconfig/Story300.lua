local var_0_0 = {
	Play100 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100
		arg_1_1.duration_ = 0.666666666666

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				SetActive(arg_1_1.hideBtn_, false)
				SetActive(arg_1_1.narrativeGo_, true)

				local var_4_1 = arg_1_0.narr_chapter_text
				local var_4_2 = arg_1_0.narr_time_text
				local var_4_3 = arg_1_1:GetWordFromCfg(100)

				var_4_1.text = arg_1_1:FormatText(var_4_3.content)

				local var_4_4 = arg_1_1:GetWordFromCfg(100)

				var_4_2.text = arg_1_1:FormatText(var_4_4.content)
				arg_1_1.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				local var_4_5 = arg_1_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_4_5 then
					var_4_5.raycastTarget = false
				end

				SetActive(arg_1_1.narrativeContinueBtn_.gameObject, false)
			end

			local var_4_6 = 0.0333333333333333

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_6 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= var_4_0 + var_4_6 and arg_1_1.time_ < var_4_0 + var_4_6 + arg_4_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_1_0, arg_1_1.narrativeGo_)

			local var_4_7 = 0.0333333333333333

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				local var_4_8 = Object.Instantiate(arg_1_1.narrativeItemGo_)
				local var_4_9 = var_4_8:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_1_0, var_4_8)

				arg_1_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				local var_4_10 = arg_1_1:GetWordFromCfg(100011001)
				local var_4_11 = arg_1_1:FormatText(var_4_10.content)

				arg_1_0.narr_item_content.text = var_4_11

				var_4_8.transform:SetParent(arg_1_1.narrativeItemGo_.transform.parent)

				var_4_8.transform.localPosition = Vector3(0, 0, 0)
				var_4_8.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_4_8, true)
			end

			local var_4_12 = 0.633333333333333

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_12 and arg_1_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_1_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_1_1.time_ >= var_4_7 + var_4_12 and arg_1_1.time_ < var_4_7 + var_4_12 + arg_4_0 then
				-- block empty
			end

			local var_4_13 = "A02a"

			if arg_1_1.bgs_[var_4_13] == nil then
				local var_4_14 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_13)
				var_4_14.name = var_4_13
				var_4_14.transform.parent = arg_1_1.stage_.transform
				var_4_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_13] = var_4_14
			end

			local var_4_15 = arg_1_1.bgs_.A02a.transform
			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.var_.moveOldPosA02a = var_4_15.localPosition
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Vector3.New(0, 0, 0)

				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosA02a, var_4_19, var_4_18)
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, 0, 0)
			end
		end
	end,
	Play101 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 101
		arg_5_1.duration_ = 0.999999999999

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play102(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_1.narrativeGo_)

			local var_8_0 = 0

			if var_8_0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_0 + arg_8_0 then
				local var_8_1 = Object.Instantiate(arg_5_1.narrativeItemGo_)
				local var_8_2 = var_8_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_5_0, var_8_1)

				arg_5_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1013")

				local var_8_3 = arg_5_1:GetWordFromCfg(100011001)
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
	Play102 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102
		arg_9_1.duration_ = 0.999999999999

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play103(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_9_0, arg_9_1.narrativeGo_)

			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_1 = Object.Instantiate(arg_9_1.narrativeItemGo_)
				local var_12_2 = var_12_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_12_1)

				arg_9_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				local var_12_3 = arg_9_1:GetWordFromCfg(100011002)
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
	Play103 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 103
		arg_13_1.duration_ = 0.999999999999

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play104(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_13_0, arg_13_1.narrativeGo_)

			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_1 = Object.Instantiate(arg_13_1.narrativeItemGo_)
				local var_16_2 = var_16_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_13_0, var_16_1)

				arg_13_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1026")

				local var_16_3 = arg_13_1:GetWordFromCfg(100011003)
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
	Play104 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 104
		arg_17_1.duration_ = 0.999999999999

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play105(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_17_0, arg_17_1.narrativeGo_)

			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				local var_20_1 = Object.Instantiate(arg_17_1.narrativeItemGo_)
				local var_20_2 = var_20_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_17_0, var_20_1)

				arg_17_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				local var_20_3 = arg_17_1:GetWordFromCfg(100011004)
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
	Play105 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 105
		arg_21_1.duration_ = 0.999999999999

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play106(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_21_0, arg_21_1.narrativeGo_)

			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_1 = Object.Instantiate(arg_21_1.narrativeItemGo_)
				local var_24_2 = var_24_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_21_0, var_24_1)

				arg_21_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1032")

				local var_24_3 = arg_21_1:GetWordFromCfg(100011005)
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
	Play106 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 106
		arg_25_1.duration_ = 0.999999999999

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play107(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_25_0, arg_25_1.narrativeGo_)

			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_1 = Object.Instantiate(arg_25_1.narrativeItemGo_)
				local var_28_2 = var_28_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_25_0, var_28_1)

				arg_25_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				local var_28_3 = arg_25_1:GetWordFromCfg(100011006)
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
	Play107 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 107
		arg_29_1.duration_ = 0.999999999999

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play108(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_29_0, arg_29_1.narrativeGo_)

			local var_32_0 = 0

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_1 = Object.Instantiate(arg_29_1.narrativeItemGo_)
				local var_32_2 = var_32_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_29_0, var_32_1)

				arg_29_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				local var_32_3 = arg_29_1:GetWordFromCfg(100011007)
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
	Play108 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 108
		arg_33_1.duration_ = 0.999999999999

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play109(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_33_0, arg_33_1.narrativeGo_)

			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				local var_36_1 = Object.Instantiate(arg_33_1.narrativeItemGo_)
				local var_36_2 = var_36_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_33_0, var_36_1)

				arg_33_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				local var_36_3 = arg_33_1:GetWordFromCfg(100011008)
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
	Play109 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 109
		arg_37_1.duration_ = 0.999999999999

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play110(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_37_0, arg_37_1.narrativeGo_)

			local var_40_0 = 0

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				local var_40_1 = Object.Instantiate(arg_37_1.narrativeItemGo_)
				local var_40_2 = var_40_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_37_0, var_40_1)

				arg_37_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				local var_40_3 = arg_37_1:GetWordFromCfg(100011009)
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
	Play110 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 110
		arg_41_1.duration_ = 0.999999999999

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play111(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_41_0, arg_41_1.narrativeGo_)

			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				local var_44_1 = Object.Instantiate(arg_41_1.narrativeItemGo_)
				local var_44_2 = var_44_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_41_0, var_44_1)

				arg_41_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				local var_44_3 = arg_41_1:GetWordFromCfg(100011010)
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
	Play111 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111
		arg_45_1.duration_ = 0.999999999999

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play112(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_45_0, arg_45_1.narrativeGo_)

			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_1 = Object.Instantiate(arg_45_1.narrativeItemGo_)
				local var_48_2 = var_48_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_45_0, var_48_1)

				arg_45_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				local var_48_3 = arg_45_1:GetWordFromCfg(100011008)
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
	Play112 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 112
		arg_49_1.duration_ = 0.999999999999

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
			arg_49_1.auto_ = false
		end

		function arg_49_1.playNext_(arg_51_0)
			arg_49_1.onStoryFinished_()
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				local var_52_1 = Object.Instantiate(arg_49_1.narrativeItemGo_)
				local var_52_2 = var_52_1:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(arg_49_0, var_52_1)

				arg_49_0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "1050")

				local var_52_3 = arg_49_1:GetWordFromCfg(100011006)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_0.narr_item_content.text = var_52_4

				var_52_1.transform:SetParent(arg_49_1.narrativeItemGo_.transform.parent)

				var_52_1.transform.localPosition = Vector3(0, 0, 0)
				var_52_1.transform.localScale = Vector3(1, 1, 1)

				SetActive(var_52_1, true)
			end

			local var_52_5 = 0.866666666666667

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_5 and arg_49_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_49_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_49_1.time_ >= var_52_0 + var_52_5 and arg_49_1.time_ < var_52_0 + var_52_5 + arg_52_0 then
				-- block empty
			end

			ComponentBinder.GetInstance():BindCfgUI(arg_49_0, arg_49_1.narrativeGo_)

			local var_52_6 = 0.866666666666667

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				-- block empty
			end

			local var_52_7 = 0.0666666666666667

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 and arg_49_1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				arg_49_1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				arg_49_1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				local var_52_8 = arg_49_1.narrativeListGo_:GetComponent(typeof(Image))

				if var_52_8 then
					var_52_8.raycastTarget = true
				end

				SetActive(arg_49_1.narrativeContinueBtn_.gameObject, true)
			end
		end
	end,
	assets = {},
	voices = {}
}

var_0_0.narrativeChapter = 100
var_0_0.narrativeTime = 100
var_0_0.narrativeData = {
	{
		"story_1011",
		100011001
	},
	{
		"1013",
		100011001
	},
	{
		"story_1019",
		100011002
	},
	{
		"story_1026",
		100011003
	},
	{
		"story_1027",
		100011004
	},
	{
		"story_1032",
		100011005
	},
	{
		"story_1035",
		100011006
	},
	{
		"story_1036",
		100011007
	},
	{
		"story_1037",
		100011008
	},
	{
		"story_1038",
		100011009
	},
	{
		"story_1039",
		100011010
	},
	{
		"story_1048",
		100011008
	},
	{
		"1050",
		100011006
	}
}

return var_0_0
