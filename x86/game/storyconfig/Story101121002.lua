return {
	Play112102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112102001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H04"

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
				local var_4_5 = arg_1_1.bgs_.H04

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
					if iter_4_0 ~= "H04" then
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

			local var_4_22 = 2
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general.awb")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 1.175

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

				local var_4_33 = arg_1_1:GetWordFromCfg(112102001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 47
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
	Play112102002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112102002
		arg_7_1.duration_ = 11.4

		local var_7_0 = {
			ja = 11.4,
			ko = 9.8,
			zh = 9.866,
			en = 9.733
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112102003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1081ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(Asset.Load("Char/" .. var_10_0), arg_7_1.stage_.transform)

				var_10_1.name = var_10_0
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_0] = var_10_1

				local var_10_2 = var_10_1:GetComponentInChildren(typeof(CharacterEffect))

				var_10_2.enabled = true

				local var_10_3 = GameObjectTools.GetOrAddComponent(var_10_1, typeof(DynamicBoneHelper))

				if var_10_3 then
					var_10_3:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_2.transform, false)

				arg_7_1.var_[var_10_0 .. "Animator"] = var_10_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_4 = arg_7_1.actors_["1081ui_story"].transform
			local var_10_5 = 0

			if var_10_5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.var_.moveOldPos1081ui_story = var_10_4.localPosition
			end

			local var_10_6 = 0.001

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_6 then
				local var_10_7 = (arg_7_1.time_ - var_10_5) / var_10_6
				local var_10_8 = Vector3.New(0, -0.92, -5.8)

				var_10_4.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1081ui_story, var_10_8, var_10_7)

				local var_10_9 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_9.x, var_10_9.y, var_10_9.z)

				local var_10_10 = var_10_4.localEulerAngles

				var_10_10.z = 0
				var_10_10.x = 0
				var_10_4.localEulerAngles = var_10_10
			end

			if arg_7_1.time_ >= var_10_5 + var_10_6 and arg_7_1.time_ < var_10_5 + var_10_6 + arg_10_0 then
				var_10_4.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_10_11 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_11.x, var_10_11.y, var_10_11.z)

				local var_10_12 = var_10_4.localEulerAngles

				var_10_12.z = 0
				var_10_12.x = 0
				var_10_4.localEulerAngles = var_10_12
			end

			local var_10_13 = 0

			if var_10_13 < arg_7_1.time_ and arg_7_1.time_ <= var_10_13 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action1_1")
			end

			local var_10_14 = 0

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_10_15 = arg_7_1.actors_["1081ui_story"]
			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 and arg_7_1.var_.characterEffect1081ui_story == nil then
				arg_7_1.var_.characterEffect1081ui_story = var_10_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_17 = 0.2

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17

				if arg_7_1.var_.characterEffect1081ui_story then
					arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 and arg_7_1.var_.characterEffect1081ui_story then
				arg_7_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_10_19 = 0
			local var_10_20 = 0.775

			if var_10_19 < arg_7_1.time_ and arg_7_1.time_ <= var_10_19 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_21 = arg_7_1:FormatText(StoryNameCfg[202].name)

				arg_7_1.leftNameTxt_.text = var_10_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_22 = arg_7_1:GetWordFromCfg(112102002)
				local var_10_23 = arg_7_1:FormatText(var_10_22.content)

				arg_7_1.text_.text = var_10_23

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_24 = 31
				local var_10_25 = utf8.len(var_10_23)
				local var_10_26 = var_10_24 <= 0 and var_10_20 or var_10_20 * (var_10_25 / var_10_24)

				if var_10_26 > 0 and var_10_20 < var_10_26 then
					arg_7_1.talkMaxDuration = var_10_26

					if var_10_26 + var_10_19 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_26 + var_10_19
					end
				end

				arg_7_1.text_.text = var_10_23
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102002", "story_v_out_112102.awb") ~= 0 then
					local var_10_27 = manager.audio:GetVoiceLength("story_v_out_112102", "112102002", "story_v_out_112102.awb") / 1000

					if var_10_27 + var_10_19 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_27 + var_10_19
					end

					if var_10_22.prefab_name ~= "" and arg_7_1.actors_[var_10_22.prefab_name] ~= nil then
						local var_10_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_22.prefab_name].transform, "story_v_out_112102", "112102002", "story_v_out_112102.awb")

						arg_7_1:RecordAudio("112102002", var_10_28)
						arg_7_1:RecordAudio("112102002", var_10_28)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112102", "112102002", "story_v_out_112102.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112102", "112102002", "story_v_out_112102.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_29 = math.max(var_10_20, arg_7_1.talkMaxDuration)

			if var_10_19 <= arg_7_1.time_ and arg_7_1.time_ < var_10_19 + var_10_29 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_19) / var_10_29

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_19 + var_10_29 and arg_7_1.time_ < var_10_19 + var_10_29 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play112102003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112102003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112102004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_14_1 = arg_11_1.actors_["1081ui_story"]
			local var_14_2 = 0

			if var_14_2 < arg_11_1.time_ and arg_11_1.time_ <= var_14_2 + arg_14_0 and arg_11_1.var_.characterEffect1081ui_story == nil then
				arg_11_1.var_.characterEffect1081ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_3 = 0.2

			if var_14_2 <= arg_11_1.time_ and arg_11_1.time_ < var_14_2 + var_14_3 then
				local var_14_4 = (arg_11_1.time_ - var_14_2) / var_14_3

				if arg_11_1.var_.characterEffect1081ui_story then
					local var_14_5 = Mathf.Lerp(0, 0.5, var_14_4)

					arg_11_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1081ui_story.fillRatio = var_14_5
				end
			end

			if arg_11_1.time_ >= var_14_2 + var_14_3 and arg_11_1.time_ < var_14_2 + var_14_3 + arg_14_0 and arg_11_1.var_.characterEffect1081ui_story then
				local var_14_6 = 0.5

				arg_11_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1081ui_story.fillRatio = var_14_6
			end

			local var_14_7 = 0
			local var_14_8 = 0.575

			if var_14_7 < arg_11_1.time_ and arg_11_1.time_ <= var_14_7 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_9 = arg_11_1:GetWordFromCfg(112102003)
				local var_14_10 = arg_11_1:FormatText(var_14_9.content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_11 = 23
				local var_14_12 = utf8.len(var_14_10)
				local var_14_13 = var_14_11 <= 0 and var_14_8 or var_14_8 * (var_14_12 / var_14_11)

				if var_14_13 > 0 and var_14_8 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_7 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_7
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_14 = math.max(var_14_8, arg_11_1.talkMaxDuration)

			if var_14_7 <= arg_11_1.time_ and arg_11_1.time_ < var_14_7 + var_14_14 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_7) / var_14_14

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_7 + var_14_14 and arg_11_1.time_ < var_14_7 + var_14_14 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play112102004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112102004
		arg_15_1.duration_ = 9.366

		local var_15_0 = {
			ja = 9.333,
			ko = 7.166,
			zh = 9.366,
			en = 5.933
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112102005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action7_1")
			end

			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_18_2 = arg_15_1.actors_["1081ui_story"]
			local var_18_3 = 0

			if var_18_3 < arg_15_1.time_ and arg_15_1.time_ <= var_18_3 + arg_18_0 and arg_15_1.var_.characterEffect1081ui_story == nil then
				arg_15_1.var_.characterEffect1081ui_story = var_18_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.2

			if var_18_3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_3 + var_18_4 then
				local var_18_5 = (arg_15_1.time_ - var_18_3) / var_18_4

				if arg_15_1.var_.characterEffect1081ui_story then
					arg_15_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_3 + var_18_4 and arg_15_1.time_ < var_18_3 + var_18_4 + arg_18_0 and arg_15_1.var_.characterEffect1081ui_story then
				arg_15_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_18_6 = 0
			local var_18_7 = 0.75

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_8 = arg_15_1:FormatText(StoryNameCfg[202].name)

				arg_15_1.leftNameTxt_.text = var_18_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_9 = arg_15_1:GetWordFromCfg(112102004)
				local var_18_10 = arg_15_1:FormatText(var_18_9.content)

				arg_15_1.text_.text = var_18_10

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_11 = 30
				local var_18_12 = utf8.len(var_18_10)
				local var_18_13 = var_18_11 <= 0 and var_18_7 or var_18_7 * (var_18_12 / var_18_11)

				if var_18_13 > 0 and var_18_7 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_10
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102004", "story_v_out_112102.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_112102", "112102004", "story_v_out_112102.awb") / 1000

					if var_18_14 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_6
					end

					if var_18_9.prefab_name ~= "" and arg_15_1.actors_[var_18_9.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_9.prefab_name].transform, "story_v_out_112102", "112102004", "story_v_out_112102.awb")

						arg_15_1:RecordAudio("112102004", var_18_15)
						arg_15_1:RecordAudio("112102004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_112102", "112102004", "story_v_out_112102.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_112102", "112102004", "story_v_out_112102.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_16 and arg_15_1.time_ < var_18_6 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play112102005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112102005
		arg_19_1.duration_ = 11

		local var_19_0 = {
			ja = 7.966,
			ko = 6.7,
			zh = 11,
			en = 8.366
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112102006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_22_1 = 0
			local var_22_2 = 0.9

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_3 = arg_19_1:FormatText(StoryNameCfg[202].name)

				arg_19_1.leftNameTxt_.text = var_22_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(112102005)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 36
				local var_22_7 = utf8.len(var_22_5)
				local var_22_8 = var_22_6 <= 0 and var_22_2 or var_22_2 * (var_22_7 / var_22_6)

				if var_22_8 > 0 and var_22_2 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102005", "story_v_out_112102.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_112102", "112102005", "story_v_out_112102.awb") / 1000

					if var_22_9 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_1
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_112102", "112102005", "story_v_out_112102.awb")

						arg_19_1:RecordAudio("112102005", var_22_10)
						arg_19_1:RecordAudio("112102005", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_112102", "112102005", "story_v_out_112102.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_112102", "112102005", "story_v_out_112102.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_11 and arg_19_1.time_ < var_22_1 + var_22_11 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play112102006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112102006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play112102007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1081ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and arg_23_1.var_.characterEffect1081ui_story == nil then
				arg_23_1.var_.characterEffect1081ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1081ui_story then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1081ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and arg_23_1.var_.characterEffect1081ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1081ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0
			local var_26_7 = 0.45

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_8 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_9 = arg_23_1:GetWordFromCfg(112102006)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 18
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
	Play112102007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112102007
		arg_27_1.duration_ = 13.733

		local var_27_0 = {
			ja = 13.7,
			ko = 12.9,
			zh = 11.633,
			en = 13.733
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112102008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_30_1 = arg_27_1.actors_["1081ui_story"]
			local var_30_2 = 0

			if var_30_2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 and arg_27_1.var_.characterEffect1081ui_story == nil then
				arg_27_1.var_.characterEffect1081ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_3 = 0.2

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_3 then
				local var_30_4 = (arg_27_1.time_ - var_30_2) / var_30_3

				if arg_27_1.var_.characterEffect1081ui_story then
					arg_27_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_2 + var_30_3 and arg_27_1.time_ < var_30_2 + var_30_3 + arg_30_0 and arg_27_1.var_.characterEffect1081ui_story then
				arg_27_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action7_2")
			end

			local var_30_6 = 0
			local var_30_7 = 1.275

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_8 = arg_27_1:FormatText(StoryNameCfg[202].name)

				arg_27_1.leftNameTxt_.text = var_30_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_9 = arg_27_1:GetWordFromCfg(112102007)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102007", "story_v_out_112102.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_112102", "112102007", "story_v_out_112102.awb") / 1000

					if var_30_14 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_6
					end

					if var_30_9.prefab_name ~= "" and arg_27_1.actors_[var_30_9.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_9.prefab_name].transform, "story_v_out_112102", "112102007", "story_v_out_112102.awb")

						arg_27_1:RecordAudio("112102007", var_30_15)
						arg_27_1:RecordAudio("112102007", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_112102", "112102007", "story_v_out_112102.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_112102", "112102007", "story_v_out_112102.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_16 and arg_27_1.time_ < var_30_6 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play112102008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 112102008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play112102009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1081ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and arg_31_1.var_.characterEffect1081ui_story == nil then
				arg_31_1.var_.characterEffect1081ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1081ui_story then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1081ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and arg_31_1.var_.characterEffect1081ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1081ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0
			local var_34_7 = 1

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(112102008)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 40
				local var_34_11 = utf8.len(var_34_9)
				local var_34_12 = var_34_10 <= 0 and var_34_7 or var_34_7 * (var_34_11 / var_34_10)

				if var_34_12 > 0 and var_34_7 < var_34_12 then
					arg_31_1.talkMaxDuration = var_34_12

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_13 and arg_31_1.time_ < var_34_6 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	Play112102009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 112102009
		arg_35_1.duration_ = 7.1

		local var_35_0 = {
			ja = 7.1,
			ko = 5.566,
			zh = 4.8,
			en = 6.366
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play112102010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_38_1 = arg_35_1.actors_["1081ui_story"]
			local var_38_2 = 0

			if var_38_2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 and arg_35_1.var_.characterEffect1081ui_story == nil then
				arg_35_1.var_.characterEffect1081ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_3 = 0.2

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_3 then
				local var_38_4 = (arg_35_1.time_ - var_38_2) / var_38_3

				if arg_35_1.var_.characterEffect1081ui_story then
					arg_35_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_2 + var_38_3 and arg_35_1.time_ < var_38_2 + var_38_3 + arg_38_0 and arg_35_1.var_.characterEffect1081ui_story then
				arg_35_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_38_5 = 0
			local var_38_6 = 0.625

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_7 = arg_35_1:FormatText(StoryNameCfg[202].name)

				arg_35_1.leftNameTxt_.text = var_38_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(112102009)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 25
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_6 or var_38_6 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_6 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102009", "story_v_out_112102.awb") ~= 0 then
					local var_38_13 = manager.audio:GetVoiceLength("story_v_out_112102", "112102009", "story_v_out_112102.awb") / 1000

					if var_38_13 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_5
					end

					if var_38_8.prefab_name ~= "" and arg_35_1.actors_[var_38_8.prefab_name] ~= nil then
						local var_38_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_8.prefab_name].transform, "story_v_out_112102", "112102009", "story_v_out_112102.awb")

						arg_35_1:RecordAudio("112102009", var_38_14)
						arg_35_1:RecordAudio("112102009", var_38_14)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_112102", "112102009", "story_v_out_112102.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_112102", "112102009", "story_v_out_112102.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_15 and arg_35_1.time_ < var_38_5 + var_38_15 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play112102010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 112102010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play112102011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1081ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and arg_39_1.var_.characterEffect1081ui_story == nil then
				arg_39_1.var_.characterEffect1081ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1081ui_story then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1081ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and arg_39_1.var_.characterEffect1081ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1081ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.825

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_9 = arg_39_1:GetWordFromCfg(112102010)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 33
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play112102011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112102011
		arg_43_1.duration_ = 16.7

		local var_43_0 = {
			ja = 13.9,
			ko = 10.233,
			zh = 11.3,
			en = 16.7
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112102012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_46_1 = arg_43_1.actors_["1081ui_story"]
			local var_46_2 = 0

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 and arg_43_1.var_.characterEffect1081ui_story == nil then
				arg_43_1.var_.characterEffect1081ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.2

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_3 then
				local var_46_4 = (arg_43_1.time_ - var_46_2) / var_46_3

				if arg_43_1.var_.characterEffect1081ui_story then
					arg_43_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_2 + var_46_3 and arg_43_1.time_ < var_46_2 + var_46_3 + arg_46_0 and arg_43_1.var_.characterEffect1081ui_story then
				arg_43_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_46_5 = 0
			local var_46_6 = 1.425

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_7 = arg_43_1:FormatText(StoryNameCfg[202].name)

				arg_43_1.leftNameTxt_.text = var_46_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:GetWordFromCfg(112102011)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 57
				local var_46_11 = utf8.len(var_46_9)
				local var_46_12 = var_46_10 <= 0 and var_46_6 or var_46_6 * (var_46_11 / var_46_10)

				if var_46_12 > 0 and var_46_6 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102011", "story_v_out_112102.awb") ~= 0 then
					local var_46_13 = manager.audio:GetVoiceLength("story_v_out_112102", "112102011", "story_v_out_112102.awb") / 1000

					if var_46_13 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_5
					end

					if var_46_8.prefab_name ~= "" and arg_43_1.actors_[var_46_8.prefab_name] ~= nil then
						local var_46_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_8.prefab_name].transform, "story_v_out_112102", "112102011", "story_v_out_112102.awb")

						arg_43_1:RecordAudio("112102011", var_46_14)
						arg_43_1:RecordAudio("112102011", var_46_14)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_112102", "112102011", "story_v_out_112102.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_112102", "112102011", "story_v_out_112102.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_15 = math.max(var_46_6, arg_43_1.talkMaxDuration)

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_15 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_5) / var_46_15

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_5 + var_46_15 and arg_43_1.time_ < var_46_5 + var_46_15 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play112102012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112102012
		arg_47_1.duration_ = 7.833

		local var_47_0 = {
			ja = 7.833,
			ko = 4.2,
			zh = 4.266,
			en = 5.733
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112102013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action5_1")
			end

			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_50_2 = 0
			local var_50_3 = 0.425

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_4 = arg_47_1:FormatText(StoryNameCfg[202].name)

				arg_47_1.leftNameTxt_.text = var_50_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_5 = arg_47_1:GetWordFromCfg(112102012)
				local var_50_6 = arg_47_1:FormatText(var_50_5.content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 17
				local var_50_8 = utf8.len(var_50_6)
				local var_50_9 = var_50_7 <= 0 and var_50_3 or var_50_3 * (var_50_8 / var_50_7)

				if var_50_9 > 0 and var_50_3 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102012", "story_v_out_112102.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_112102", "112102012", "story_v_out_112102.awb") / 1000

					if var_50_10 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_2
					end

					if var_50_5.prefab_name ~= "" and arg_47_1.actors_[var_50_5.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_5.prefab_name].transform, "story_v_out_112102", "112102012", "story_v_out_112102.awb")

						arg_47_1:RecordAudio("112102012", var_50_11)
						arg_47_1:RecordAudio("112102012", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_112102", "112102012", "story_v_out_112102.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_112102", "112102012", "story_v_out_112102.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_12 and arg_47_1.time_ < var_50_2 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end
	end,
	Play112102013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112102013
		arg_51_1.duration_ = 11.5

		local var_51_0 = {
			ja = 8.7,
			ko = 9.3,
			zh = 10.2,
			en = 11.5
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
				arg_51_0:Play112102014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1081ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1081ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, 100, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1081ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, 100, 0)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = "1039ui_story"

			if arg_51_1.actors_[var_54_9] == nil then
				local var_54_10 = Object.Instantiate(Asset.Load("Char/" .. var_54_9), arg_51_1.stage_.transform)

				var_54_10.name = var_54_9
				var_54_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_[var_54_9] = var_54_10

				local var_54_11 = var_54_10:GetComponentInChildren(typeof(CharacterEffect))

				var_54_11.enabled = true

				local var_54_12 = GameObjectTools.GetOrAddComponent(var_54_10, typeof(DynamicBoneHelper))

				if var_54_12 then
					var_54_12:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_11.transform, false)

				arg_51_1.var_[var_54_9 .. "Animator"] = var_54_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_[var_54_9 .. "Animator"].applyRootMotion = true
				arg_51_1.var_[var_54_9 .. "LipSync"] = var_54_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_13 = arg_51_1.actors_["1039ui_story"].transform
			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1.var_.moveOldPos1039ui_story = var_54_13.localPosition
			end

			local var_54_15 = 0.001

			if var_54_14 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_15 then
				local var_54_16 = (arg_51_1.time_ - var_54_14) / var_54_15
				local var_54_17 = Vector3.New(0, -1.01, -5.9)

				var_54_13.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1039ui_story, var_54_17, var_54_16)

				local var_54_18 = manager.ui.mainCamera.transform.position - var_54_13.position

				var_54_13.forward = Vector3.New(var_54_18.x, var_54_18.y, var_54_18.z)

				local var_54_19 = var_54_13.localEulerAngles

				var_54_19.z = 0
				var_54_19.x = 0
				var_54_13.localEulerAngles = var_54_19
			end

			if arg_51_1.time_ >= var_54_14 + var_54_15 and arg_51_1.time_ < var_54_14 + var_54_15 + arg_54_0 then
				var_54_13.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_54_20 = manager.ui.mainCamera.transform.position - var_54_13.position

				var_54_13.forward = Vector3.New(var_54_20.x, var_54_20.y, var_54_20.z)

				local var_54_21 = var_54_13.localEulerAngles

				var_54_21.z = 0
				var_54_21.x = 0
				var_54_13.localEulerAngles = var_54_21
			end

			local var_54_22 = 0

			if var_54_22 < arg_51_1.time_ and arg_51_1.time_ <= var_54_22 + arg_54_0 then
				arg_51_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action5_1")
			end

			local var_54_23 = 0

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 then
				arg_51_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_54_24 = arg_51_1.actors_["1039ui_story"]
			local var_54_25 = 0

			if var_54_25 < arg_51_1.time_ and arg_51_1.time_ <= var_54_25 + arg_54_0 and arg_51_1.var_.characterEffect1039ui_story == nil then
				arg_51_1.var_.characterEffect1039ui_story = var_54_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_26 = 0.2

			if var_54_25 <= arg_51_1.time_ and arg_51_1.time_ < var_54_25 + var_54_26 then
				local var_54_27 = (arg_51_1.time_ - var_54_25) / var_54_26

				if arg_51_1.var_.characterEffect1039ui_story then
					arg_51_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_25 + var_54_26 and arg_51_1.time_ < var_54_25 + var_54_26 + arg_54_0 and arg_51_1.var_.characterEffect1039ui_story then
				arg_51_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_54_28 = 0
			local var_54_29 = 1.075

			if var_54_28 < arg_51_1.time_ and arg_51_1.time_ <= var_54_28 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_30 = arg_51_1:FormatText(StoryNameCfg[9].name)

				arg_51_1.leftNameTxt_.text = var_54_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_31 = arg_51_1:GetWordFromCfg(112102013)
				local var_54_32 = arg_51_1:FormatText(var_54_31.content)

				arg_51_1.text_.text = var_54_32

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_33 = 43
				local var_54_34 = utf8.len(var_54_32)
				local var_54_35 = var_54_33 <= 0 and var_54_29 or var_54_29 * (var_54_34 / var_54_33)

				if var_54_35 > 0 and var_54_29 < var_54_35 then
					arg_51_1.talkMaxDuration = var_54_35

					if var_54_35 + var_54_28 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_35 + var_54_28
					end
				end

				arg_51_1.text_.text = var_54_32
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102013", "story_v_out_112102.awb") ~= 0 then
					local var_54_36 = manager.audio:GetVoiceLength("story_v_out_112102", "112102013", "story_v_out_112102.awb") / 1000

					if var_54_36 + var_54_28 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_36 + var_54_28
					end

					if var_54_31.prefab_name ~= "" and arg_51_1.actors_[var_54_31.prefab_name] ~= nil then
						local var_54_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_31.prefab_name].transform, "story_v_out_112102", "112102013", "story_v_out_112102.awb")

						arg_51_1:RecordAudio("112102013", var_54_37)
						arg_51_1:RecordAudio("112102013", var_54_37)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112102", "112102013", "story_v_out_112102.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112102", "112102013", "story_v_out_112102.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_38 = math.max(var_54_29, arg_51_1.talkMaxDuration)

			if var_54_28 <= arg_51_1.time_ and arg_51_1.time_ < var_54_28 + var_54_38 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_28) / var_54_38

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_28 + var_54_38 and arg_51_1.time_ < var_54_28 + var_54_38 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play112102014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112102014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112102015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1039ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1039ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1039ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = 0
			local var_58_10 = 0.375

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_11 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_12 = arg_55_1:GetWordFromCfg(112102014)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.text_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_14 = 15
				local var_58_15 = utf8.len(var_58_13)
				local var_58_16 = var_58_14 <= 0 and var_58_10 or var_58_10 * (var_58_15 / var_58_14)

				if var_58_16 > 0 and var_58_10 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_9 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_9
					end
				end

				arg_55_1.text_.text = var_58_13
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_17 = math.max(var_58_10, arg_55_1.talkMaxDuration)

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_17 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_9) / var_58_17

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_9 + var_58_17 and arg_55_1.time_ < var_58_9 + var_58_17 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play112102015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112102015
		arg_59_1.duration_ = 6.3

		local var_59_0 = {
			ja = 5.3,
			ko = 6.066,
			zh = 5.666,
			en = 6.3
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play112102016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1081ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1081ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -0.92, -5.8)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1081ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action1_1")
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_62_11 = arg_59_1.actors_["1081ui_story"]
			local var_62_12 = 0

			if var_62_12 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 and arg_59_1.var_.characterEffect1081ui_story == nil then
				arg_59_1.var_.characterEffect1081ui_story = var_62_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_13 = 0.2

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_13 then
				local var_62_14 = (arg_59_1.time_ - var_62_12) / var_62_13

				if arg_59_1.var_.characterEffect1081ui_story then
					arg_59_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_12 + var_62_13 and arg_59_1.time_ < var_62_12 + var_62_13 + arg_62_0 and arg_59_1.var_.characterEffect1081ui_story then
				arg_59_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_62_15 = 0
			local var_62_16 = 0.725

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[202].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(112102015)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 29
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102015", "story_v_out_112102.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_112102", "112102015", "story_v_out_112102.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_112102", "112102015", "story_v_out_112102.awb")

						arg_59_1:RecordAudio("112102015", var_62_24)
						arg_59_1:RecordAudio("112102015", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112102", "112102015", "story_v_out_112102.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112102", "112102015", "story_v_out_112102.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	Play112102016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112102016
		arg_63_1.duration_ = 9.133

		local var_63_0 = {
			ja = 9.133,
			ko = 7.6,
			zh = 7.4,
			en = 6.8
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
				arg_63_0:Play112102017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_1 = 0
			local var_66_2 = 1.025

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_3 = arg_63_1:FormatText(StoryNameCfg[202].name)

				arg_63_1.leftNameTxt_.text = var_66_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(112102016)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 41
				local var_66_7 = utf8.len(var_66_5)
				local var_66_8 = var_66_6 <= 0 and var_66_2 or var_66_2 * (var_66_7 / var_66_6)

				if var_66_8 > 0 and var_66_2 < var_66_8 then
					arg_63_1.talkMaxDuration = var_66_8

					if var_66_8 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102016", "story_v_out_112102.awb") ~= 0 then
					local var_66_9 = manager.audio:GetVoiceLength("story_v_out_112102", "112102016", "story_v_out_112102.awb") / 1000

					if var_66_9 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_1
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_out_112102", "112102016", "story_v_out_112102.awb")

						arg_63_1:RecordAudio("112102016", var_66_10)
						arg_63_1:RecordAudio("112102016", var_66_10)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112102", "112102016", "story_v_out_112102.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112102", "112102016", "story_v_out_112102.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_11 and arg_63_1.time_ < var_66_1 + var_66_11 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end
	end,
	Play112102017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112102017
		arg_67_1.duration_ = 7.6

		local var_67_0 = {
			ja = 4.6,
			ko = 7.6,
			zh = 6.366,
			en = 5.233
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
				arg_67_0:Play112102018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_70_1 = 0
			local var_70_2 = 0.8

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_3 = arg_67_1:FormatText(StoryNameCfg[202].name)

				arg_67_1.leftNameTxt_.text = var_70_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(112102017)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 32
				local var_70_7 = utf8.len(var_70_5)
				local var_70_8 = var_70_6 <= 0 and var_70_2 or var_70_2 * (var_70_7 / var_70_6)

				if var_70_8 > 0 and var_70_2 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102017", "story_v_out_112102.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_out_112102", "112102017", "story_v_out_112102.awb") / 1000

					if var_70_9 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_1
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_112102", "112102017", "story_v_out_112102.awb")

						arg_67_1:RecordAudio("112102017", var_70_10)
						arg_67_1:RecordAudio("112102017", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112102", "112102017", "story_v_out_112102.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112102", "112102017", "story_v_out_112102.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_11 and arg_67_1.time_ < var_70_1 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play112102018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 112102018
		arg_71_1.duration_ = 8.766

		local var_71_0 = {
			ja = 8.766,
			ko = 8.1,
			zh = 7.233,
			en = 6.766
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
				arg_71_0:Play112102019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_74_1 = 0
			local var_74_2 = 1.05

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_3 = arg_71_1:FormatText(StoryNameCfg[202].name)

				arg_71_1.leftNameTxt_.text = var_74_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(112102018)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 42
				local var_74_7 = utf8.len(var_74_5)
				local var_74_8 = var_74_6 <= 0 and var_74_2 or var_74_2 * (var_74_7 / var_74_6)

				if var_74_8 > 0 and var_74_2 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102018", "story_v_out_112102.awb") ~= 0 then
					local var_74_9 = manager.audio:GetVoiceLength("story_v_out_112102", "112102018", "story_v_out_112102.awb") / 1000

					if var_74_9 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_1
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_112102", "112102018", "story_v_out_112102.awb")

						arg_71_1:RecordAudio("112102018", var_74_10)
						arg_71_1:RecordAudio("112102018", var_74_10)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_112102", "112102018", "story_v_out_112102.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_112102", "112102018", "story_v_out_112102.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_11 and arg_71_1.time_ < var_74_1 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play112102019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 112102019
		arg_75_1.duration_ = 5.6

		local var_75_0 = {
			ja = 5.6,
			ko = 3.666,
			zh = 3.2,
			en = 5.533
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
				arg_75_0:Play112102020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1081ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1081ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.5

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(-0.7, -0.92, -5.8)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1081ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-0.7, -0.92, -5.8)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = "1148ui_story"

			if arg_75_1.actors_[var_78_9] == nil then
				local var_78_10 = Object.Instantiate(Asset.Load("Char/" .. var_78_9), arg_75_1.stage_.transform)

				var_78_10.name = var_78_9
				var_78_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_[var_78_9] = var_78_10

				local var_78_11 = var_78_10:GetComponentInChildren(typeof(CharacterEffect))

				var_78_11.enabled = true

				local var_78_12 = GameObjectTools.GetOrAddComponent(var_78_10, typeof(DynamicBoneHelper))

				if var_78_12 then
					var_78_12:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_11.transform, false)

				arg_75_1.var_[var_78_9 .. "Animator"] = var_78_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_[var_78_9 .. "Animator"].applyRootMotion = true
				arg_75_1.var_[var_78_9 .. "LipSync"] = var_78_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_13 = arg_75_1.actors_["1148ui_story"].transform
			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.var_.moveOldPos1148ui_story = var_78_13.localPosition
			end

			local var_78_15 = 0.001

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_15 then
				local var_78_16 = (arg_75_1.time_ - var_78_14) / var_78_15
				local var_78_17 = Vector3.New(0.7, -0.8, -6.2)

				var_78_13.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1148ui_story, var_78_17, var_78_16)

				local var_78_18 = manager.ui.mainCamera.transform.position - var_78_13.position

				var_78_13.forward = Vector3.New(var_78_18.x, var_78_18.y, var_78_18.z)

				local var_78_19 = var_78_13.localEulerAngles

				var_78_19.z = 0
				var_78_19.x = 0
				var_78_13.localEulerAngles = var_78_19
			end

			if arg_75_1.time_ >= var_78_14 + var_78_15 and arg_75_1.time_ < var_78_14 + var_78_15 + arg_78_0 then
				var_78_13.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_78_20 = manager.ui.mainCamera.transform.position - var_78_13.position

				var_78_13.forward = Vector3.New(var_78_20.x, var_78_20.y, var_78_20.z)

				local var_78_21 = var_78_13.localEulerAngles

				var_78_21.z = 0
				var_78_21.x = 0
				var_78_13.localEulerAngles = var_78_21
			end

			local var_78_22 = 0

			if var_78_22 < arg_75_1.time_ and arg_75_1.time_ <= var_78_22 + arg_78_0 then
				arg_75_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action2_1")
			end

			local var_78_23 = 0

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_78_24 = arg_75_1.actors_["1148ui_story"]
			local var_78_25 = 0

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 and arg_75_1.var_.characterEffect1148ui_story == nil then
				arg_75_1.var_.characterEffect1148ui_story = var_78_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_26 = 0.2

			if var_78_25 <= arg_75_1.time_ and arg_75_1.time_ < var_78_25 + var_78_26 then
				local var_78_27 = (arg_75_1.time_ - var_78_25) / var_78_26

				if arg_75_1.var_.characterEffect1148ui_story then
					arg_75_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_25 + var_78_26 and arg_75_1.time_ < var_78_25 + var_78_26 + arg_78_0 and arg_75_1.var_.characterEffect1148ui_story then
				arg_75_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_78_28 = 0
			local var_78_29 = 0.4

			if var_78_28 < arg_75_1.time_ and arg_75_1.time_ <= var_78_28 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_30 = arg_75_1:FormatText(StoryNameCfg[8].name)

				arg_75_1.leftNameTxt_.text = var_78_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_31 = arg_75_1:GetWordFromCfg(112102019)
				local var_78_32 = arg_75_1:FormatText(var_78_31.content)

				arg_75_1.text_.text = var_78_32

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_33 = 16
				local var_78_34 = utf8.len(var_78_32)
				local var_78_35 = var_78_33 <= 0 and var_78_29 or var_78_29 * (var_78_34 / var_78_33)

				if var_78_35 > 0 and var_78_29 < var_78_35 then
					arg_75_1.talkMaxDuration = var_78_35

					if var_78_35 + var_78_28 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_35 + var_78_28
					end
				end

				arg_75_1.text_.text = var_78_32
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102019", "story_v_out_112102.awb") ~= 0 then
					local var_78_36 = manager.audio:GetVoiceLength("story_v_out_112102", "112102019", "story_v_out_112102.awb") / 1000

					if var_78_36 + var_78_28 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_36 + var_78_28
					end

					if var_78_31.prefab_name ~= "" and arg_75_1.actors_[var_78_31.prefab_name] ~= nil then
						local var_78_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_31.prefab_name].transform, "story_v_out_112102", "112102019", "story_v_out_112102.awb")

						arg_75_1:RecordAudio("112102019", var_78_37)
						arg_75_1:RecordAudio("112102019", var_78_37)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_112102", "112102019", "story_v_out_112102.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_112102", "112102019", "story_v_out_112102.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_38 = math.max(var_78_29, arg_75_1.talkMaxDuration)

			if var_78_28 <= arg_75_1.time_ and arg_75_1.time_ < var_78_28 + var_78_38 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_28) / var_78_38

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_28 + var_78_38 and arg_75_1.time_ < var_78_28 + var_78_38 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play112102020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 112102020
		arg_79_1.duration_ = 7.533

		local var_79_0 = {
			ja = 6.466,
			ko = 6.466,
			zh = 6.966,
			en = 7.533
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play112102021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1148ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and arg_79_1.var_.characterEffect1148ui_story == nil then
				arg_79_1.var_.characterEffect1148ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1148ui_story then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1148ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and arg_79_1.var_.characterEffect1148ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1148ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/1081/1081action/1081action1_1")
			end

			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_8 = arg_79_1.actors_["1081ui_story"]
			local var_82_9 = 0

			if var_82_9 < arg_79_1.time_ and arg_79_1.time_ <= var_82_9 + arg_82_0 and arg_79_1.var_.characterEffect1081ui_story == nil then
				arg_79_1.var_.characterEffect1081ui_story = var_82_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_10 = 0.2

			if var_82_9 <= arg_79_1.time_ and arg_79_1.time_ < var_82_9 + var_82_10 then
				local var_82_11 = (arg_79_1.time_ - var_82_9) / var_82_10

				if arg_79_1.var_.characterEffect1081ui_story then
					arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_9 + var_82_10 and arg_79_1.time_ < var_82_9 + var_82_10 + arg_82_0 and arg_79_1.var_.characterEffect1081ui_story then
				arg_79_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_82_12 = 0
			local var_82_13 = 0.925

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_14 = arg_79_1:FormatText(StoryNameCfg[202].name)

				arg_79_1.leftNameTxt_.text = var_82_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_15 = arg_79_1:GetWordFromCfg(112102020)
				local var_82_16 = arg_79_1:FormatText(var_82_15.content)

				arg_79_1.text_.text = var_82_16

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 37
				local var_82_18 = utf8.len(var_82_16)
				local var_82_19 = var_82_17 <= 0 and var_82_13 or var_82_13 * (var_82_18 / var_82_17)

				if var_82_19 > 0 and var_82_13 < var_82_19 then
					arg_79_1.talkMaxDuration = var_82_19

					if var_82_19 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_16
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112102", "112102020", "story_v_out_112102.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_112102", "112102020", "story_v_out_112102.awb") / 1000

					if var_82_20 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_12
					end

					if var_82_15.prefab_name ~= "" and arg_79_1.actors_[var_82_15.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_15.prefab_name].transform, "story_v_out_112102", "112102020", "story_v_out_112102.awb")

						arg_79_1:RecordAudio("112102020", var_82_21)
						arg_79_1:RecordAudio("112102020", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_112102", "112102020", "story_v_out_112102.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_112102", "112102020", "story_v_out_112102.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_22 and arg_79_1.time_ < var_82_12 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play112102021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 112102021
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
			local var_86_0 = arg_83_1.actors_["1081ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and arg_83_1.var_.characterEffect1081ui_story == nil then
				arg_83_1.var_.characterEffect1081ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1081ui_story then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1081ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and arg_83_1.var_.characterEffect1081ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1081ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.45

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_8 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:GetWordFromCfg(112102021)
				local var_86_10 = arg_83_1:FormatText(var_86_9.content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 18
				local var_86_12 = utf8.len(var_86_10)
				local var_86_13 = var_86_11 <= 0 and var_86_7 or var_86_7 * (var_86_12 / var_86_11)

				if var_86_13 > 0 and var_86_7 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/H04"
	},
	voices = {
		"story_v_out_112102.awb"
	}
}
