return {
	Play317132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K09f"

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
				local var_4_5 = arg_1_1.bgs_.K09f

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
					if iter_4_0 ~= "K09f" then
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
			local var_4_23 = 0.166666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_26 = 0.433333333333333
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "music"

				arg_1_1:AudioAction(var_4_28, var_4_29, "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 0.625

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

				local var_4_33 = arg_1_1:GetWordFromCfg(317132001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 25
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
	Play317132002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 317132002
		arg_7_1.duration_ = 4.1

		local var_7_0 = {
			zh = 2.533,
			ja = 4.1
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
				arg_7_0:Play317132003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1093ui_story"

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

			local var_10_4 = arg_7_1.actors_["1093ui_story"].transform
			local var_10_5 = 0

			if var_10_5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.var_.moveOldPos1093ui_story = var_10_4.localPosition
			end

			local var_10_6 = 0.001

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_6 then
				local var_10_7 = (arg_7_1.time_ - var_10_5) / var_10_6
				local var_10_8 = Vector3.New(0, -1.11, -5.88)

				var_10_4.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1093ui_story, var_10_8, var_10_7)

				local var_10_9 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_9.x, var_10_9.y, var_10_9.z)

				local var_10_10 = var_10_4.localEulerAngles

				var_10_10.z = 0
				var_10_10.x = 0
				var_10_4.localEulerAngles = var_10_10
			end

			if arg_7_1.time_ >= var_10_5 + var_10_6 and arg_7_1.time_ < var_10_5 + var_10_6 + arg_10_0 then
				var_10_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_10_11 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_11.x, var_10_11.y, var_10_11.z)

				local var_10_12 = var_10_4.localEulerAngles

				var_10_12.z = 0
				var_10_12.x = 0
				var_10_4.localEulerAngles = var_10_12
			end

			local var_10_13 = arg_7_1.actors_["1093ui_story"]
			local var_10_14 = 0

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 and arg_7_1.var_.characterEffect1093ui_story == nil then
				arg_7_1.var_.characterEffect1093ui_story = var_10_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_15 = 0.200000002980232

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_15 then
				local var_10_16 = (arg_7_1.time_ - var_10_14) / var_10_15

				if arg_7_1.var_.characterEffect1093ui_story then
					arg_7_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_14 + var_10_15 and arg_7_1.time_ < var_10_14 + var_10_15 + arg_10_0 and arg_7_1.var_.characterEffect1093ui_story then
				arg_7_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_10_17 = 0

			if var_10_17 < arg_7_1.time_ and arg_7_1.time_ <= var_10_17 + arg_10_0 then
				arg_7_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/1093/1093action/1093action1_1")
			end

			local var_10_18 = 0

			if var_10_18 < arg_7_1.time_ and arg_7_1.time_ <= var_10_18 + arg_10_0 then
				arg_7_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_19 = 0
			local var_10_20 = 0.4

			if var_10_19 < arg_7_1.time_ and arg_7_1.time_ <= var_10_19 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_21 = arg_7_1:FormatText(StoryNameCfg[73].name)

				arg_7_1.leftNameTxt_.text = var_10_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_22 = arg_7_1:GetWordFromCfg(317132002)
				local var_10_23 = arg_7_1:FormatText(var_10_22.content)

				arg_7_1.text_.text = var_10_23

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_24 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_317132", "317132002", "story_v_out_317132.awb") ~= 0 then
					local var_10_27 = manager.audio:GetVoiceLength("story_v_out_317132", "317132002", "story_v_out_317132.awb") / 1000

					if var_10_27 + var_10_19 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_27 + var_10_19
					end

					if var_10_22.prefab_name ~= "" and arg_7_1.actors_[var_10_22.prefab_name] ~= nil then
						local var_10_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_22.prefab_name].transform, "story_v_out_317132", "317132002", "story_v_out_317132.awb")

						arg_7_1:RecordAudio("317132002", var_10_28)
						arg_7_1:RecordAudio("317132002", var_10_28)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_317132", "317132002", "story_v_out_317132.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_317132", "317132002", "story_v_out_317132.awb")
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
	Play317132003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 317132003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play317132004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["1093ui_story"].transform
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.var_.moveOldPos1093ui_story = var_14_0.localPosition
			end

			local var_14_2 = 0.001

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2
				local var_14_4 = Vector3.New(0, 100, 0)

				var_14_0.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1093ui_story, var_14_4, var_14_3)

				local var_14_5 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_5.x, var_14_5.y, var_14_5.z)

				local var_14_6 = var_14_0.localEulerAngles

				var_14_6.z = 0
				var_14_6.x = 0
				var_14_0.localEulerAngles = var_14_6
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 then
				var_14_0.localPosition = Vector3.New(0, 100, 0)

				local var_14_7 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_7.x, var_14_7.y, var_14_7.z)

				local var_14_8 = var_14_0.localEulerAngles

				var_14_8.z = 0
				var_14_8.x = 0
				var_14_0.localEulerAngles = var_14_8
			end

			local var_14_9 = 0
			local var_14_10 = 0.55

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_11 = arg_11_1:GetWordFromCfg(317132003)
				local var_14_12 = arg_11_1:FormatText(var_14_11.content)

				arg_11_1.text_.text = var_14_12

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_13 = 22
				local var_14_14 = utf8.len(var_14_12)
				local var_14_15 = var_14_13 <= 0 and var_14_10 or var_14_10 * (var_14_14 / var_14_13)

				if var_14_15 > 0 and var_14_10 < var_14_15 then
					arg_11_1.talkMaxDuration = var_14_15

					if var_14_15 + var_14_9 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_15 + var_14_9
					end
				end

				arg_11_1.text_.text = var_14_12
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_16 = math.max(var_14_10, arg_11_1.talkMaxDuration)

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_16 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_9) / var_14_16

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_9 + var_14_16 and arg_11_1.time_ < var_14_9 + var_14_16 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play317132004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 317132004
		arg_15_1.duration_ = 1.3

		local var_15_0 = {
			zh = 1.033,
			ja = 1.3
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
				arg_15_0:Play317132005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "2079ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Object.Instantiate(Asset.Load("Char/" .. var_18_0), arg_15_1.stage_.transform)

				var_18_1.name = var_18_0
				var_18_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_[var_18_0] = var_18_1

				local var_18_2 = var_18_1:GetComponentInChildren(typeof(CharacterEffect))

				var_18_2.enabled = true

				local var_18_3 = GameObjectTools.GetOrAddComponent(var_18_1, typeof(DynamicBoneHelper))

				if var_18_3 then
					var_18_3:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_2.transform, false)

				arg_15_1.var_[var_18_0 .. "Animator"] = var_18_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
				arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_4 = arg_15_1.actors_["2079ui_story"].transform
			local var_18_5 = 0

			if var_18_5 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 then
				arg_15_1.var_.moveOldPos2079ui_story = var_18_4.localPosition
			end

			local var_18_6 = 0.001

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_6 then
				local var_18_7 = (arg_15_1.time_ - var_18_5) / var_18_6
				local var_18_8 = Vector3.New(0, -1.28, -5.6)

				var_18_4.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos2079ui_story, var_18_8, var_18_7)

				local var_18_9 = manager.ui.mainCamera.transform.position - var_18_4.position

				var_18_4.forward = Vector3.New(var_18_9.x, var_18_9.y, var_18_9.z)

				local var_18_10 = var_18_4.localEulerAngles

				var_18_10.z = 0
				var_18_10.x = 0
				var_18_4.localEulerAngles = var_18_10
			end

			if arg_15_1.time_ >= var_18_5 + var_18_6 and arg_15_1.time_ < var_18_5 + var_18_6 + arg_18_0 then
				var_18_4.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_18_11 = manager.ui.mainCamera.transform.position - var_18_4.position

				var_18_4.forward = Vector3.New(var_18_11.x, var_18_11.y, var_18_11.z)

				local var_18_12 = var_18_4.localEulerAngles

				var_18_12.z = 0
				var_18_12.x = 0
				var_18_4.localEulerAngles = var_18_12
			end

			local var_18_13 = arg_15_1.actors_["2079ui_story"]
			local var_18_14 = 0

			if var_18_14 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 and arg_15_1.var_.characterEffect2079ui_story == nil then
				arg_15_1.var_.characterEffect2079ui_story = var_18_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_15 = 0.200000002980232

			if var_18_14 <= arg_15_1.time_ and arg_15_1.time_ < var_18_14 + var_18_15 then
				local var_18_16 = (arg_15_1.time_ - var_18_14) / var_18_15

				if arg_15_1.var_.characterEffect2079ui_story then
					arg_15_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_14 + var_18_15 and arg_15_1.time_ < var_18_14 + var_18_15 + arg_18_0 and arg_15_1.var_.characterEffect2079ui_story then
				arg_15_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_18_17 = 0

			if var_18_17 < arg_15_1.time_ and arg_15_1.time_ <= var_18_17 + arg_18_0 then
				arg_15_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_18_18 = 0

			if var_18_18 < arg_15_1.time_ and arg_15_1.time_ <= var_18_18 + arg_18_0 then
				arg_15_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_18_19 = 0
			local var_18_20 = 0.15

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_21 = arg_15_1:FormatText(StoryNameCfg[529].name)

				arg_15_1.leftNameTxt_.text = var_18_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_22 = arg_15_1:GetWordFromCfg(317132004)
				local var_18_23 = arg_15_1:FormatText(var_18_22.content)

				arg_15_1.text_.text = var_18_23

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_24 = 6
				local var_18_25 = utf8.len(var_18_23)
				local var_18_26 = var_18_24 <= 0 and var_18_20 or var_18_20 * (var_18_25 / var_18_24)

				if var_18_26 > 0 and var_18_20 < var_18_26 then
					arg_15_1.talkMaxDuration = var_18_26

					if var_18_26 + var_18_19 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_26 + var_18_19
					end
				end

				arg_15_1.text_.text = var_18_23
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317132", "317132004", "story_v_out_317132.awb") ~= 0 then
					local var_18_27 = manager.audio:GetVoiceLength("story_v_out_317132", "317132004", "story_v_out_317132.awb") / 1000

					if var_18_27 + var_18_19 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_27 + var_18_19
					end

					if var_18_22.prefab_name ~= "" and arg_15_1.actors_[var_18_22.prefab_name] ~= nil then
						local var_18_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_22.prefab_name].transform, "story_v_out_317132", "317132004", "story_v_out_317132.awb")

						arg_15_1:RecordAudio("317132004", var_18_28)
						arg_15_1:RecordAudio("317132004", var_18_28)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_317132", "317132004", "story_v_out_317132.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_317132", "317132004", "story_v_out_317132.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_29 = math.max(var_18_20, arg_15_1.talkMaxDuration)

			if var_18_19 <= arg_15_1.time_ and arg_15_1.time_ < var_18_19 + var_18_29 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_19) / var_18_29

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_19 + var_18_29 and arg_15_1.time_ < var_18_19 + var_18_29 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play317132005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 317132005
		arg_19_1.duration_ = 1.166

		local var_19_0 = {
			zh = 1.066,
			ja = 1.166
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
				arg_19_0:Play317132006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1015ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Object.Instantiate(Asset.Load("Char/" .. var_22_0), arg_19_1.stage_.transform)

				var_22_1.name = var_22_0
				var_22_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_[var_22_0] = var_22_1

				local var_22_2 = var_22_1:GetComponentInChildren(typeof(CharacterEffect))

				var_22_2.enabled = true

				local var_22_3 = GameObjectTools.GetOrAddComponent(var_22_1, typeof(DynamicBoneHelper))

				if var_22_3 then
					var_22_3:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_2.transform, false)

				arg_19_1.var_[var_22_0 .. "Animator"] = var_22_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
				arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_4 = arg_19_1.actors_["1015ui_story"].transform
			local var_22_5 = 0

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.var_.moveOldPos1015ui_story = var_22_4.localPosition
			end

			local var_22_6 = 0.001

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_6 then
				local var_22_7 = (arg_19_1.time_ - var_22_5) / var_22_6
				local var_22_8 = Vector3.New(0, -1.15, -6.2)

				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1015ui_story, var_22_8, var_22_7)

				local var_22_9 = manager.ui.mainCamera.transform.position - var_22_4.position

				var_22_4.forward = Vector3.New(var_22_9.x, var_22_9.y, var_22_9.z)

				local var_22_10 = var_22_4.localEulerAngles

				var_22_10.z = 0
				var_22_10.x = 0
				var_22_4.localEulerAngles = var_22_10
			end

			if arg_19_1.time_ >= var_22_5 + var_22_6 and arg_19_1.time_ < var_22_5 + var_22_6 + arg_22_0 then
				var_22_4.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_22_11 = manager.ui.mainCamera.transform.position - var_22_4.position

				var_22_4.forward = Vector3.New(var_22_11.x, var_22_11.y, var_22_11.z)

				local var_22_12 = var_22_4.localEulerAngles

				var_22_12.z = 0
				var_22_12.x = 0
				var_22_4.localEulerAngles = var_22_12
			end

			local var_22_13 = arg_19_1.actors_["1015ui_story"]
			local var_22_14 = 0

			if var_22_14 < arg_19_1.time_ and arg_19_1.time_ <= var_22_14 + arg_22_0 and arg_19_1.var_.characterEffect1015ui_story == nil then
				arg_19_1.var_.characterEffect1015ui_story = var_22_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_15 = 0.200000002980232

			if var_22_14 <= arg_19_1.time_ and arg_19_1.time_ < var_22_14 + var_22_15 then
				local var_22_16 = (arg_19_1.time_ - var_22_14) / var_22_15

				if arg_19_1.var_.characterEffect1015ui_story then
					arg_19_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_14 + var_22_15 and arg_19_1.time_ < var_22_14 + var_22_15 + arg_22_0 and arg_19_1.var_.characterEffect1015ui_story then
				arg_19_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_22_17 = 0

			if var_22_17 < arg_19_1.time_ and arg_19_1.time_ <= var_22_17 + arg_22_0 then
				arg_19_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_19 = arg_19_1.actors_["2079ui_story"].transform
			local var_22_20 = 0

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.var_.moveOldPos2079ui_story = var_22_19.localPosition
			end

			local var_22_21 = 0.001

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_21 then
				local var_22_22 = (arg_19_1.time_ - var_22_20) / var_22_21
				local var_22_23 = Vector3.New(0, 100, 0)

				var_22_19.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos2079ui_story, var_22_23, var_22_22)

				local var_22_24 = manager.ui.mainCamera.transform.position - var_22_19.position

				var_22_19.forward = Vector3.New(var_22_24.x, var_22_24.y, var_22_24.z)

				local var_22_25 = var_22_19.localEulerAngles

				var_22_25.z = 0
				var_22_25.x = 0
				var_22_19.localEulerAngles = var_22_25
			end

			if arg_19_1.time_ >= var_22_20 + var_22_21 and arg_19_1.time_ < var_22_20 + var_22_21 + arg_22_0 then
				var_22_19.localPosition = Vector3.New(0, 100, 0)

				local var_22_26 = manager.ui.mainCamera.transform.position - var_22_19.position

				var_22_19.forward = Vector3.New(var_22_26.x, var_22_26.y, var_22_26.z)

				local var_22_27 = var_22_19.localEulerAngles

				var_22_27.z = 0
				var_22_27.x = 0
				var_22_19.localEulerAngles = var_22_27
			end

			local var_22_28 = arg_19_1.actors_["2079ui_story"]
			local var_22_29 = 0

			if var_22_29 < arg_19_1.time_ and arg_19_1.time_ <= var_22_29 + arg_22_0 and arg_19_1.var_.characterEffect2079ui_story == nil then
				arg_19_1.var_.characterEffect2079ui_story = var_22_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_30 = 0.200000002980232

			if var_22_29 <= arg_19_1.time_ and arg_19_1.time_ < var_22_29 + var_22_30 then
				local var_22_31 = (arg_19_1.time_ - var_22_29) / var_22_30

				if arg_19_1.var_.characterEffect2079ui_story then
					local var_22_32 = Mathf.Lerp(0, 0.5, var_22_31)

					arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_19_1.var_.characterEffect2079ui_story.fillRatio = var_22_32
				end
			end

			if arg_19_1.time_ >= var_22_29 + var_22_30 and arg_19_1.time_ < var_22_29 + var_22_30 + arg_22_0 and arg_19_1.var_.characterEffect2079ui_story then
				local var_22_33 = 0.5

				arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_19_1.var_.characterEffect2079ui_story.fillRatio = var_22_33
			end

			local var_22_34 = 0
			local var_22_35 = 0.125

			if var_22_34 < arg_19_1.time_ and arg_19_1.time_ <= var_22_34 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_36 = arg_19_1:FormatText(StoryNameCfg[479].name)

				arg_19_1.leftNameTxt_.text = var_22_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_37 = arg_19_1:GetWordFromCfg(317132005)
				local var_22_38 = arg_19_1:FormatText(var_22_37.content)

				arg_19_1.text_.text = var_22_38

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_39 = 5
				local var_22_40 = utf8.len(var_22_38)
				local var_22_41 = var_22_39 <= 0 and var_22_35 or var_22_35 * (var_22_40 / var_22_39)

				if var_22_41 > 0 and var_22_35 < var_22_41 then
					arg_19_1.talkMaxDuration = var_22_41

					if var_22_41 + var_22_34 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_41 + var_22_34
					end
				end

				arg_19_1.text_.text = var_22_38
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317132", "317132005", "story_v_out_317132.awb") ~= 0 then
					local var_22_42 = manager.audio:GetVoiceLength("story_v_out_317132", "317132005", "story_v_out_317132.awb") / 1000

					if var_22_42 + var_22_34 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_42 + var_22_34
					end

					if var_22_37.prefab_name ~= "" and arg_19_1.actors_[var_22_37.prefab_name] ~= nil then
						local var_22_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_37.prefab_name].transform, "story_v_out_317132", "317132005", "story_v_out_317132.awb")

						arg_19_1:RecordAudio("317132005", var_22_43)
						arg_19_1:RecordAudio("317132005", var_22_43)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_317132", "317132005", "story_v_out_317132.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_317132", "317132005", "story_v_out_317132.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_44 = math.max(var_22_35, arg_19_1.talkMaxDuration)

			if var_22_34 <= arg_19_1.time_ and arg_19_1.time_ < var_22_34 + var_22_44 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_34) / var_22_44

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_34 + var_22_44 and arg_19_1.time_ < var_22_34 + var_22_44 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play317132006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 317132006
		arg_23_1.duration_ = 1.999999999999

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play317132007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["2079ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos2079ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, -1.28, -5.6)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos2079ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["2079ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and arg_23_1.var_.characterEffect2079ui_story == nil then
				arg_23_1.var_.characterEffect2079ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect2079ui_story then
					arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and arg_23_1.var_.characterEffect2079ui_story then
				arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_26_13 = 0

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_26_14 = arg_23_1.actors_["1015ui_story"].transform
			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 then
				arg_23_1.var_.moveOldPos1015ui_story = var_26_14.localPosition
			end

			local var_26_16 = 0.001

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_16 then
				local var_26_17 = (arg_23_1.time_ - var_26_15) / var_26_16
				local var_26_18 = Vector3.New(0, 100, 0)

				var_26_14.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1015ui_story, var_26_18, var_26_17)

				local var_26_19 = manager.ui.mainCamera.transform.position - var_26_14.position

				var_26_14.forward = Vector3.New(var_26_19.x, var_26_19.y, var_26_19.z)

				local var_26_20 = var_26_14.localEulerAngles

				var_26_20.z = 0
				var_26_20.x = 0
				var_26_14.localEulerAngles = var_26_20
			end

			if arg_23_1.time_ >= var_26_15 + var_26_16 and arg_23_1.time_ < var_26_15 + var_26_16 + arg_26_0 then
				var_26_14.localPosition = Vector3.New(0, 100, 0)

				local var_26_21 = manager.ui.mainCamera.transform.position - var_26_14.position

				var_26_14.forward = Vector3.New(var_26_21.x, var_26_21.y, var_26_21.z)

				local var_26_22 = var_26_14.localEulerAngles

				var_26_22.z = 0
				var_26_22.x = 0
				var_26_14.localEulerAngles = var_26_22
			end

			local var_26_23 = 0
			local var_26_24 = 0.125

			if var_26_23 < arg_23_1.time_ and arg_23_1.time_ <= var_26_23 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_25 = arg_23_1:FormatText(StoryNameCfg[530].name)

				arg_23_1.leftNameTxt_.text = var_26_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_26 = arg_23_1:GetWordFromCfg(317132006)
				local var_26_27 = arg_23_1:FormatText(var_26_26.content)

				arg_23_1.text_.text = var_26_27

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_28 = 6
				local var_26_29 = utf8.len(var_26_27)
				local var_26_30 = var_26_28 <= 0 and var_26_24 or var_26_24 * (var_26_29 / var_26_28)

				if var_26_30 > 0 and var_26_24 < var_26_30 then
					arg_23_1.talkMaxDuration = var_26_30

					if var_26_30 + var_26_23 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_30 + var_26_23
					end
				end

				arg_23_1.text_.text = var_26_27
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317132", "317132006", "story_v_out_317132.awb") ~= 0 then
					local var_26_31 = manager.audio:GetVoiceLength("story_v_out_317132", "317132006", "story_v_out_317132.awb") / 1000

					if var_26_31 + var_26_23 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_31 + var_26_23
					end

					if var_26_26.prefab_name ~= "" and arg_23_1.actors_[var_26_26.prefab_name] ~= nil then
						local var_26_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_26.prefab_name].transform, "story_v_out_317132", "317132006", "story_v_out_317132.awb")

						arg_23_1:RecordAudio("317132006", var_26_32)
						arg_23_1:RecordAudio("317132006", var_26_32)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317132", "317132006", "story_v_out_317132.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317132", "317132006", "story_v_out_317132.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_33 = math.max(var_26_24, arg_23_1.talkMaxDuration)

			if var_26_23 <= arg_23_1.time_ and arg_23_1.time_ < var_26_23 + var_26_33 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_23) / var_26_33

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_23 + var_26_33 and arg_23_1.time_ < var_26_23 + var_26_33 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play317132007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 317132007
		arg_27_1.duration_ = 3.6

		local var_27_0 = {
			zh = 3.333,
			ja = 3.6
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
				arg_27_0:Play317132008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["2079ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos2079ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -1.28, -5.6)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos2079ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["2079ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and arg_27_1.var_.characterEffect2079ui_story == nil then
				arg_27_1.var_.characterEffect2079ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect2079ui_story then
					arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and arg_27_1.var_.characterEffect2079ui_story then
				arg_27_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_15 = "2078ui_story"

			if arg_27_1.actors_[var_30_15] == nil then
				local var_30_16 = Object.Instantiate(Asset.Load("Char/" .. var_30_15), arg_27_1.stage_.transform)

				var_30_16.name = var_30_15
				var_30_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_[var_30_15] = var_30_16

				local var_30_17 = var_30_16:GetComponentInChildren(typeof(CharacterEffect))

				var_30_17.enabled = true

				local var_30_18 = GameObjectTools.GetOrAddComponent(var_30_16, typeof(DynamicBoneHelper))

				if var_30_18 then
					var_30_18:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_17.transform, false)

				arg_27_1.var_[var_30_15 .. "Animator"] = var_30_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_[var_30_15 .. "Animator"].applyRootMotion = true
				arg_27_1.var_[var_30_15 .. "LipSync"] = var_30_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_19 = arg_27_1.actors_["2078ui_story"]
			local var_30_20 = 0

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 and arg_27_1.var_.characterEffect2078ui_story == nil then
				arg_27_1.var_.characterEffect2078ui_story = var_30_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_21 = 0.200000002980232

			if var_30_20 <= arg_27_1.time_ and arg_27_1.time_ < var_30_20 + var_30_21 then
				local var_30_22 = (arg_27_1.time_ - var_30_20) / var_30_21

				if arg_27_1.var_.characterEffect2078ui_story then
					local var_30_23 = Mathf.Lerp(0, 0.5, var_30_22)

					arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_27_1.var_.characterEffect2078ui_story.fillRatio = var_30_23
				end
			end

			if arg_27_1.time_ >= var_30_20 + var_30_21 and arg_27_1.time_ < var_30_20 + var_30_21 + arg_30_0 and arg_27_1.var_.characterEffect2078ui_story then
				local var_30_24 = 0.5

				arg_27_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_27_1.var_.characterEffect2078ui_story.fillRatio = var_30_24
			end

			local var_30_25 = 0
			local var_30_26 = 0.6

			if var_30_25 < arg_27_1.time_ and arg_27_1.time_ <= var_30_25 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_27 = arg_27_1:FormatText(StoryNameCfg[529].name)

				arg_27_1.leftNameTxt_.text = var_30_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_28 = arg_27_1:GetWordFromCfg(317132007)
				local var_30_29 = arg_27_1:FormatText(var_30_28.content)

				arg_27_1.text_.text = var_30_29

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_30 = 24
				local var_30_31 = utf8.len(var_30_29)
				local var_30_32 = var_30_30 <= 0 and var_30_26 or var_30_26 * (var_30_31 / var_30_30)

				if var_30_32 > 0 and var_30_26 < var_30_32 then
					arg_27_1.talkMaxDuration = var_30_32

					if var_30_32 + var_30_25 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_32 + var_30_25
					end
				end

				arg_27_1.text_.text = var_30_29
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317132", "317132007", "story_v_out_317132.awb") ~= 0 then
					local var_30_33 = manager.audio:GetVoiceLength("story_v_out_317132", "317132007", "story_v_out_317132.awb") / 1000

					if var_30_33 + var_30_25 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_33 + var_30_25
					end

					if var_30_28.prefab_name ~= "" and arg_27_1.actors_[var_30_28.prefab_name] ~= nil then
						local var_30_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_28.prefab_name].transform, "story_v_out_317132", "317132007", "story_v_out_317132.awb")

						arg_27_1:RecordAudio("317132007", var_30_34)
						arg_27_1:RecordAudio("317132007", var_30_34)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_317132", "317132007", "story_v_out_317132.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_317132", "317132007", "story_v_out_317132.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_35 = math.max(var_30_26, arg_27_1.talkMaxDuration)

			if var_30_25 <= arg_27_1.time_ and arg_27_1.time_ < var_30_25 + var_30_35 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_25) / var_30_35

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_25 + var_30_35 and arg_27_1.time_ < var_30_25 + var_30_35 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play317132008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317132008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
			arg_31_1.auto_ = false
		end

		function arg_31_1.playNext_(arg_33_0)
			arg_31_1.onStoryFinished_()
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["2079ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos2079ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos2079ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["2079ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and arg_31_1.var_.characterEffect2079ui_story == nil then
				arg_31_1.var_.characterEffect2079ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect2079ui_story then
					local var_34_13 = Mathf.Lerp(0, 0.5, var_34_12)

					arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_31_1.var_.characterEffect2079ui_story.fillRatio = var_34_13
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and arg_31_1.var_.characterEffect2079ui_story then
				local var_34_14 = 0.5

				arg_31_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_31_1.var_.characterEffect2079ui_story.fillRatio = var_34_14
			end

			local var_34_15 = 0
			local var_34_16 = 1.05

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_17 = arg_31_1:GetWordFromCfg(317132008)
				local var_34_18 = arg_31_1:FormatText(var_34_17.content)

				arg_31_1.text_.text = var_34_18

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_19 = 42
				local var_34_20 = utf8.len(var_34_18)
				local var_34_21 = var_34_19 <= 0 and var_34_16 or var_34_16 * (var_34_20 / var_34_19)

				if var_34_21 > 0 and var_34_16 < var_34_21 then
					arg_31_1.talkMaxDuration = var_34_21

					if var_34_21 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_21 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_18
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_22 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_22

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_22 and arg_31_1.time_ < var_34_15 + var_34_22 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/K09f"
	},
	voices = {
		"story_v_out_317132.awb"
	}
}
