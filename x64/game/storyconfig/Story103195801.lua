return {
	Play319581001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319581001
		arg_1_1.duration_ = 7.933

		local var_1_0 = {
			zh = 4.866,
			ja = 7.933
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319581002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D11"

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
				local var_4_5 = arg_1_1.bgs_.D11

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
					if iter_4_0 ~= "D11" then
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

			local var_4_22 = "10079ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Object.Instantiate(Asset.Load("Char/" .. var_4_22), arg_1_1.stage_.transform)

				var_4_23.name = var_4_22
				var_4_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_22] = var_4_23

				local var_4_24 = var_4_23:GetComponentInChildren(typeof(CharacterEffect))

				var_4_24.enabled = true

				local var_4_25 = GameObjectTools.GetOrAddComponent(var_4_23, typeof(DynamicBoneHelper))

				if var_4_25 then
					var_4_25:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_24.transform, false)

				arg_1_1.var_[var_4_22 .. "Animator"] = var_4_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_26 = arg_1_1.actors_["10079ui_story"].transform
			local var_4_27 = 0

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10079ui_story = var_4_26.localPosition
			end

			local var_4_28 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_27) / var_4_28
				local var_4_30 = Vector3.New(0, -0.95, -6.05)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10079ui_story, var_4_30, var_4_29)

				local var_4_31 = manager.ui.mainCamera.transform.position - var_4_26.position

				var_4_26.forward = Vector3.New(var_4_31.x, var_4_31.y, var_4_31.z)

				local var_4_32 = var_4_26.localEulerAngles

				var_4_32.z = 0
				var_4_32.x = 0
				var_4_26.localEulerAngles = var_4_32
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_26.position

				var_4_26.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_26.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_26.localEulerAngles = var_4_34
			end

			local var_4_35 = arg_1_1.actors_["10079ui_story"]
			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and arg_1_1.var_.characterEffect10079ui_story == nil then
				arg_1_1.var_.characterEffect10079ui_story = var_4_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_37 = 0.200000002980232

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.characterEffect10079ui_story then
					arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and arg_1_1.var_.characterEffect10079ui_story then
				arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_4_40 = 0

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_41 = 0
			local var_4_42 = 0.0666666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_45 = 0.1
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 0.325

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_52 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_53 = arg_1_1:GetWordFromCfg(319581001)
				local var_4_54 = arg_1_1:FormatText(var_4_53.content)

				arg_1_1.text_.text = var_4_54

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_55 = 13
				local var_4_56 = utf8.len(var_4_54)
				local var_4_57 = var_4_55 <= 0 and var_4_50 or var_4_50 * (var_4_56 / var_4_55)

				if var_4_57 > 0 and var_4_50 < var_4_57 then
					arg_1_1.talkMaxDuration = var_4_57
					var_4_49 = var_4_49 + 0.3

					if var_4_57 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_57 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_54
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581001", "story_v_out_319581.awb") ~= 0 then
					local var_4_58 = manager.audio:GetVoiceLength("story_v_out_319581", "319581001", "story_v_out_319581.awb") / 1000

					if var_4_58 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_49
					end

					if var_4_53.prefab_name ~= "" and arg_1_1.actors_[var_4_53.prefab_name] ~= nil then
						local var_4_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_53.prefab_name].transform, "story_v_out_319581", "319581001", "story_v_out_319581.awb")

						arg_1_1:RecordAudio("319581001", var_4_59)
						arg_1_1:RecordAudio("319581001", var_4_59)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319581", "319581001", "story_v_out_319581.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319581", "319581001", "story_v_out_319581.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_60 = var_4_49 + 0.3
			local var_4_61 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_60) / var_4_61

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play319581002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 319581002
		arg_7_1.duration_ = 9.666

		local var_7_0 = {
			zh = 9.666,
			ja = 9.3
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
				arg_7_0:Play319581003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "4040ui_story"

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

			local var_10_4 = arg_7_1.actors_["4040ui_story"].transform
			local var_10_5 = 0

			if var_10_5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 then
				arg_7_1.var_.moveOldPos4040ui_story = var_10_4.localPosition
			end

			local var_10_6 = 0.001

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_6 then
				local var_10_7 = (arg_7_1.time_ - var_10_5) / var_10_6
				local var_10_8 = Vector3.New(0.7, -1.55, -5.5)

				var_10_4.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos4040ui_story, var_10_8, var_10_7)

				local var_10_9 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_9.x, var_10_9.y, var_10_9.z)

				local var_10_10 = var_10_4.localEulerAngles

				var_10_10.z = 0
				var_10_10.x = 0
				var_10_4.localEulerAngles = var_10_10
			end

			if arg_7_1.time_ >= var_10_5 + var_10_6 and arg_7_1.time_ < var_10_5 + var_10_6 + arg_10_0 then
				var_10_4.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_10_11 = manager.ui.mainCamera.transform.position - var_10_4.position

				var_10_4.forward = Vector3.New(var_10_11.x, var_10_11.y, var_10_11.z)

				local var_10_12 = var_10_4.localEulerAngles

				var_10_12.z = 0
				var_10_12.x = 0
				var_10_4.localEulerAngles = var_10_12
			end

			local var_10_13 = arg_7_1.actors_["4040ui_story"]
			local var_10_14 = 0

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 and arg_7_1.var_.characterEffect4040ui_story == nil then
				arg_7_1.var_.characterEffect4040ui_story = var_10_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_15 = 0.200000002980232

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_15 then
				local var_10_16 = (arg_7_1.time_ - var_10_14) / var_10_15

				if arg_7_1.var_.characterEffect4040ui_story then
					arg_7_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_14 + var_10_15 and arg_7_1.time_ < var_10_14 + var_10_15 + arg_10_0 and arg_7_1.var_.characterEffect4040ui_story then
				arg_7_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_10_17 = 0

			if var_10_17 < arg_7_1.time_ and arg_7_1.time_ <= var_10_17 + arg_10_0 then
				arg_7_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_10_18 = 0

			if var_10_18 < arg_7_1.time_ and arg_7_1.time_ <= var_10_18 + arg_10_0 then
				arg_7_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_19 = arg_7_1.actors_["10079ui_story"].transform
			local var_10_20 = 0

			if var_10_20 < arg_7_1.time_ and arg_7_1.time_ <= var_10_20 + arg_10_0 then
				arg_7_1.var_.moveOldPos10079ui_story = var_10_19.localPosition
			end

			local var_10_21 = 0.001

			if var_10_20 <= arg_7_1.time_ and arg_7_1.time_ < var_10_20 + var_10_21 then
				local var_10_22 = (arg_7_1.time_ - var_10_20) / var_10_21
				local var_10_23 = Vector3.New(-0.7, -0.95, -6.05)

				var_10_19.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10079ui_story, var_10_23, var_10_22)

				local var_10_24 = manager.ui.mainCamera.transform.position - var_10_19.position

				var_10_19.forward = Vector3.New(var_10_24.x, var_10_24.y, var_10_24.z)

				local var_10_25 = var_10_19.localEulerAngles

				var_10_25.z = 0
				var_10_25.x = 0
				var_10_19.localEulerAngles = var_10_25
			end

			if arg_7_1.time_ >= var_10_20 + var_10_21 and arg_7_1.time_ < var_10_20 + var_10_21 + arg_10_0 then
				var_10_19.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_10_26 = manager.ui.mainCamera.transform.position - var_10_19.position

				var_10_19.forward = Vector3.New(var_10_26.x, var_10_26.y, var_10_26.z)

				local var_10_27 = var_10_19.localEulerAngles

				var_10_27.z = 0
				var_10_27.x = 0
				var_10_19.localEulerAngles = var_10_27
			end

			local var_10_28 = arg_7_1.actors_["10079ui_story"]
			local var_10_29 = 0

			if var_10_29 < arg_7_1.time_ and arg_7_1.time_ <= var_10_29 + arg_10_0 and arg_7_1.var_.characterEffect10079ui_story == nil then
				arg_7_1.var_.characterEffect10079ui_story = var_10_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_30 = 0.200000002980232

			if var_10_29 <= arg_7_1.time_ and arg_7_1.time_ < var_10_29 + var_10_30 then
				local var_10_31 = (arg_7_1.time_ - var_10_29) / var_10_30

				if arg_7_1.var_.characterEffect10079ui_story then
					local var_10_32 = Mathf.Lerp(0, 0.5, var_10_31)

					arg_7_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_7_1.var_.characterEffect10079ui_story.fillRatio = var_10_32
				end
			end

			if arg_7_1.time_ >= var_10_29 + var_10_30 and arg_7_1.time_ < var_10_29 + var_10_30 + arg_10_0 and arg_7_1.var_.characterEffect10079ui_story then
				local var_10_33 = 0.5

				arg_7_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_7_1.var_.characterEffect10079ui_story.fillRatio = var_10_33
			end

			local var_10_34 = 0
			local var_10_35 = 0.875

			if var_10_34 < arg_7_1.time_ and arg_7_1.time_ <= var_10_34 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_36 = arg_7_1:FormatText(StoryNameCfg[668].name)

				arg_7_1.leftNameTxt_.text = var_10_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_37 = arg_7_1:GetWordFromCfg(319581002)
				local var_10_38 = arg_7_1:FormatText(var_10_37.content)

				arg_7_1.text_.text = var_10_38

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_39 = 35
				local var_10_40 = utf8.len(var_10_38)
				local var_10_41 = var_10_39 <= 0 and var_10_35 or var_10_35 * (var_10_40 / var_10_39)

				if var_10_41 > 0 and var_10_35 < var_10_41 then
					arg_7_1.talkMaxDuration = var_10_41

					if var_10_41 + var_10_34 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_41 + var_10_34
					end
				end

				arg_7_1.text_.text = var_10_38
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581002", "story_v_out_319581.awb") ~= 0 then
					local var_10_42 = manager.audio:GetVoiceLength("story_v_out_319581", "319581002", "story_v_out_319581.awb") / 1000

					if var_10_42 + var_10_34 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_42 + var_10_34
					end

					if var_10_37.prefab_name ~= "" and arg_7_1.actors_[var_10_37.prefab_name] ~= nil then
						local var_10_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_37.prefab_name].transform, "story_v_out_319581", "319581002", "story_v_out_319581.awb")

						arg_7_1:RecordAudio("319581002", var_10_43)
						arg_7_1:RecordAudio("319581002", var_10_43)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_319581", "319581002", "story_v_out_319581.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_319581", "319581002", "story_v_out_319581.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_44 = math.max(var_10_35, arg_7_1.talkMaxDuration)

			if var_10_34 <= arg_7_1.time_ and arg_7_1.time_ < var_10_34 + var_10_44 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_34) / var_10_44

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_34 + var_10_44 and arg_7_1.time_ < var_10_34 + var_10_44 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play319581003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 319581003
		arg_11_1.duration_ = 7.066

		local var_11_0 = {
			zh = 4.466,
			ja = 7.066
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play319581004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 0.4

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_2 = arg_11_1:FormatText(StoryNameCfg[668].name)

				arg_11_1.leftNameTxt_.text = var_14_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:GetWordFromCfg(319581003)
				local var_14_4 = arg_11_1:FormatText(var_14_3.content)

				arg_11_1.text_.text = var_14_4

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581003", "story_v_out_319581.awb") ~= 0 then
					local var_14_8 = manager.audio:GetVoiceLength("story_v_out_319581", "319581003", "story_v_out_319581.awb") / 1000

					if var_14_8 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_8 + var_14_0
					end

					if var_14_3.prefab_name ~= "" and arg_11_1.actors_[var_14_3.prefab_name] ~= nil then
						local var_14_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_3.prefab_name].transform, "story_v_out_319581", "319581003", "story_v_out_319581.awb")

						arg_11_1:RecordAudio("319581003", var_14_9)
						arg_11_1:RecordAudio("319581003", var_14_9)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_319581", "319581003", "story_v_out_319581.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_319581", "319581003", "story_v_out_319581.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_10 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_10 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_10

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_10 and arg_11_1.time_ < var_14_0 + var_14_10 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play319581004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 319581004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play319581005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["4040ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and arg_15_1.var_.characterEffect4040ui_story == nil then
				arg_15_1.var_.characterEffect4040ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect4040ui_story then
					local var_18_4 = Mathf.Lerp(0, 0.5, var_18_3)

					arg_15_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_15_1.var_.characterEffect4040ui_story.fillRatio = var_18_4
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and arg_15_1.var_.characterEffect4040ui_story then
				local var_18_5 = 0.5

				arg_15_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_15_1.var_.characterEffect4040ui_story.fillRatio = var_18_5
			end

			local var_18_6 = 0
			local var_18_7 = 1.1

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_8 = arg_15_1:GetWordFromCfg(319581004)
				local var_18_9 = arg_15_1:FormatText(var_18_8.content)

				arg_15_1.text_.text = var_18_9

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 44
				local var_18_11 = utf8.len(var_18_9)
				local var_18_12 = var_18_10 <= 0 and var_18_7 or var_18_7 * (var_18_11 / var_18_10)

				if var_18_12 > 0 and var_18_7 < var_18_12 then
					arg_15_1.talkMaxDuration = var_18_12

					if var_18_12 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_12 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_9
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_13 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_13 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_13

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_13 and arg_15_1.time_ < var_18_6 + var_18_13 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play319581005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 319581005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play319581006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 0.633333333333333

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				local var_22_2 = "play"
				local var_22_3 = "effect"

				arg_19_1:AudioAction(var_22_2, var_22_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_22_4 = 0
			local var_22_5 = 1

			if var_22_4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				local var_22_6 = "play"
				local var_22_7 = "effect"

				arg_19_1:AudioAction(var_22_6, var_22_7, "se_story", "se_story_communication", "")
			end

			local var_22_8 = 0
			local var_22_9 = 0.8

			if var_22_8 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(319581005)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_12 = 32
				local var_22_13 = utf8.len(var_22_11)
				local var_22_14 = var_22_12 <= 0 and var_22_9 or var_22_9 * (var_22_13 / var_22_12)

				if var_22_14 > 0 and var_22_9 < var_22_14 then
					arg_19_1.talkMaxDuration = var_22_14

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_15 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_15 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_15

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_15 and arg_19_1.time_ < var_22_8 + var_22_15 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play319581006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 319581006
		arg_23_1.duration_ = 4.066

		local var_23_0 = {
			zh = 1.999999999999,
			ja = 4.066
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play319581007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10079ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10079ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10079ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["10079ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and arg_23_1.var_.characterEffect10079ui_story == nil then
				arg_23_1.var_.characterEffect10079ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect10079ui_story then
					arg_23_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and arg_23_1.var_.characterEffect10079ui_story then
				arg_23_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_26_13 = 0

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_26_14 = 0

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 then
				arg_23_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_15 = 0
			local var_26_16 = 1

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 then
				local var_26_17 = "stop"
				local var_26_18 = "effect"

				arg_23_1:AudioAction(var_26_17, var_26_18, "se_story_130", "se_story_130_didi", "")
			end

			local var_26_19 = arg_23_1.actors_["4040ui_story"]
			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 and arg_23_1.var_.characterEffect4040ui_story == nil then
				arg_23_1.var_.characterEffect4040ui_story = var_26_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_21 = 0.200000002980232

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_21 then
				local var_26_22 = (arg_23_1.time_ - var_26_20) / var_26_21

				if arg_23_1.var_.characterEffect4040ui_story then
					local var_26_23 = Mathf.Lerp(0, 0.5, var_26_22)

					arg_23_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_23_1.var_.characterEffect4040ui_story.fillRatio = var_26_23
				end
			end

			if arg_23_1.time_ >= var_26_20 + var_26_21 and arg_23_1.time_ < var_26_20 + var_26_21 + arg_26_0 and arg_23_1.var_.characterEffect4040ui_story then
				local var_26_24 = 0.5

				arg_23_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_23_1.var_.characterEffect4040ui_story.fillRatio = var_26_24
			end

			local var_26_25 = 0
			local var_26_26 = 0.15

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_27 = arg_23_1:FormatText(StoryNameCfg[6].name)

				arg_23_1.leftNameTxt_.text = var_26_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_28 = arg_23_1:GetWordFromCfg(319581006)
				local var_26_29 = arg_23_1:FormatText(var_26_28.content)

				arg_23_1.text_.text = var_26_29

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_30 = 6
				local var_26_31 = utf8.len(var_26_29)
				local var_26_32 = var_26_30 <= 0 and var_26_26 or var_26_26 * (var_26_31 / var_26_30)

				if var_26_32 > 0 and var_26_26 < var_26_32 then
					arg_23_1.talkMaxDuration = var_26_32

					if var_26_32 + var_26_25 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_32 + var_26_25
					end
				end

				arg_23_1.text_.text = var_26_29
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581006", "story_v_out_319581.awb") ~= 0 then
					local var_26_33 = manager.audio:GetVoiceLength("story_v_out_319581", "319581006", "story_v_out_319581.awb") / 1000

					if var_26_33 + var_26_25 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_33 + var_26_25
					end

					if var_26_28.prefab_name ~= "" and arg_23_1.actors_[var_26_28.prefab_name] ~= nil then
						local var_26_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_28.prefab_name].transform, "story_v_out_319581", "319581006", "story_v_out_319581.awb")

						arg_23_1:RecordAudio("319581006", var_26_34)
						arg_23_1:RecordAudio("319581006", var_26_34)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_319581", "319581006", "story_v_out_319581.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_319581", "319581006", "story_v_out_319581.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_35 = math.max(var_26_26, arg_23_1.talkMaxDuration)

			if var_26_25 <= arg_23_1.time_ and arg_23_1.time_ < var_26_25 + var_26_35 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_25) / var_26_35

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_25 + var_26_35 and arg_23_1.time_ < var_26_25 + var_26_35 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play319581007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319581007
		arg_27_1.duration_ = 12.6

		local var_27_0 = {
			zh = 3.7,
			ja = 12.6
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
				arg_27_0:Play319581008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.375

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(319581007)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581007", "story_v_out_319581.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_319581", "319581007", "story_v_out_319581.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_319581", "319581007", "story_v_out_319581.awb")

						arg_27_1:RecordAudio("319581007", var_30_9)
						arg_27_1:RecordAudio("319581007", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_319581", "319581007", "story_v_out_319581.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_319581", "319581007", "story_v_out_319581.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play319581008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319581008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319581009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10079ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and arg_31_1.var_.characterEffect10079ui_story == nil then
				arg_31_1.var_.characterEffect10079ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect10079ui_story then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_31_1.var_.characterEffect10079ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and arg_31_1.var_.characterEffect10079ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_31_1.var_.characterEffect10079ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0
			local var_34_7 = 0.9

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

				local var_34_8 = arg_31_1:GetWordFromCfg(319581008)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 36
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
	Play319581009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319581009
		arg_35_1.duration_ = 4.833

		local var_35_0 = {
			zh = 3.233,
			ja = 4.833
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
				arg_35_0:Play319581010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["4040ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and arg_35_1.var_.characterEffect4040ui_story == nil then
				arg_35_1.var_.characterEffect4040ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect4040ui_story then
					arg_35_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and arg_35_1.var_.characterEffect4040ui_story then
				arg_35_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_38_4 = 0
			local var_38_5 = 0.375

			if var_38_4 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_6 = arg_35_1:FormatText(StoryNameCfg[668].name)

				arg_35_1.leftNameTxt_.text = var_38_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_7 = arg_35_1:GetWordFromCfg(319581009)
				local var_38_8 = arg_35_1:FormatText(var_38_7.content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 15
				local var_38_10 = utf8.len(var_38_8)
				local var_38_11 = var_38_9 <= 0 and var_38_5 or var_38_5 * (var_38_10 / var_38_9)

				if var_38_11 > 0 and var_38_5 < var_38_11 then
					arg_35_1.talkMaxDuration = var_38_11

					if var_38_11 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581009", "story_v_out_319581.awb") ~= 0 then
					local var_38_12 = manager.audio:GetVoiceLength("story_v_out_319581", "319581009", "story_v_out_319581.awb") / 1000

					if var_38_12 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_4
					end

					if var_38_7.prefab_name ~= "" and arg_35_1.actors_[var_38_7.prefab_name] ~= nil then
						local var_38_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_7.prefab_name].transform, "story_v_out_319581", "319581009", "story_v_out_319581.awb")

						arg_35_1:RecordAudio("319581009", var_38_13)
						arg_35_1:RecordAudio("319581009", var_38_13)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319581", "319581009", "story_v_out_319581.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319581", "319581009", "story_v_out_319581.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_14 and arg_35_1.time_ < var_38_4 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play319581010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319581010
		arg_39_1.duration_ = 6.3

		local var_39_0 = {
			zh = 5.166,
			ja = 6.3
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319581011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["4040ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and arg_39_1.var_.characterEffect4040ui_story == nil then
				arg_39_1.var_.characterEffect4040ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect4040ui_story then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_39_1.var_.characterEffect4040ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and arg_39_1.var_.characterEffect4040ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_39_1.var_.characterEffect4040ui_story.fillRatio = var_42_5
			end

			local var_42_6 = arg_39_1.actors_["10079ui_story"].transform
			local var_42_7 = 0

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				arg_39_1.var_.moveOldPos10079ui_story = var_42_6.localPosition
			end

			local var_42_8 = 0.001

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_8 then
				local var_42_9 = (arg_39_1.time_ - var_42_7) / var_42_8
				local var_42_10 = Vector3.New(0, 100, 0)

				var_42_6.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10079ui_story, var_42_10, var_42_9)

				local var_42_11 = manager.ui.mainCamera.transform.position - var_42_6.position

				var_42_6.forward = Vector3.New(var_42_11.x, var_42_11.y, var_42_11.z)

				local var_42_12 = var_42_6.localEulerAngles

				var_42_12.z = 0
				var_42_12.x = 0
				var_42_6.localEulerAngles = var_42_12
			end

			if arg_39_1.time_ >= var_42_7 + var_42_8 and arg_39_1.time_ < var_42_7 + var_42_8 + arg_42_0 then
				var_42_6.localPosition = Vector3.New(0, 100, 0)

				local var_42_13 = manager.ui.mainCamera.transform.position - var_42_6.position

				var_42_6.forward = Vector3.New(var_42_13.x, var_42_13.y, var_42_13.z)

				local var_42_14 = var_42_6.localEulerAngles

				var_42_14.z = 0
				var_42_14.x = 0
				var_42_6.localEulerAngles = var_42_14
			end

			local var_42_15 = arg_39_1.actors_["4040ui_story"].transform
			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.var_.moveOldPos4040ui_story = var_42_15.localPosition
			end

			local var_42_17 = 0.001

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Vector3.New(0, 100, 0)

				var_42_15.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos4040ui_story, var_42_19, var_42_18)

				local var_42_20 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_20.x, var_42_20.y, var_42_20.z)

				local var_42_21 = var_42_15.localEulerAngles

				var_42_21.z = 0
				var_42_21.x = 0
				var_42_15.localEulerAngles = var_42_21
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				var_42_15.localPosition = Vector3.New(0, 100, 0)

				local var_42_22 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_22.x, var_42_22.y, var_42_22.z)

				local var_42_23 = var_42_15.localEulerAngles

				var_42_23.z = 0
				var_42_23.x = 0
				var_42_15.localEulerAngles = var_42_23
			end

			local var_42_24 = arg_39_1.actors_["10079ui_story"]
			local var_42_25 = 0

			if var_42_25 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 and arg_39_1.var_.characterEffect10079ui_story == nil then
				arg_39_1.var_.characterEffect10079ui_story = var_42_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_26 = 0.200000002980232

			if var_42_25 <= arg_39_1.time_ and arg_39_1.time_ < var_42_25 + var_42_26 then
				local var_42_27 = (arg_39_1.time_ - var_42_25) / var_42_26

				if arg_39_1.var_.characterEffect10079ui_story then
					local var_42_28 = Mathf.Lerp(0, 0.5, var_42_27)

					arg_39_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_39_1.var_.characterEffect10079ui_story.fillRatio = var_42_28
				end
			end

			if arg_39_1.time_ >= var_42_25 + var_42_26 and arg_39_1.time_ < var_42_25 + var_42_26 + arg_42_0 and arg_39_1.var_.characterEffect10079ui_story then
				local var_42_29 = 0.5

				arg_39_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_39_1.var_.characterEffect10079ui_story.fillRatio = var_42_29
			end

			local var_42_30 = "1095ui_story"

			if arg_39_1.actors_[var_42_30] == nil then
				local var_42_31 = Object.Instantiate(Asset.Load("Char/" .. var_42_30), arg_39_1.stage_.transform)

				var_42_31.name = var_42_30
				var_42_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_[var_42_30] = var_42_31

				local var_42_32 = var_42_31:GetComponentInChildren(typeof(CharacterEffect))

				var_42_32.enabled = true

				local var_42_33 = GameObjectTools.GetOrAddComponent(var_42_31, typeof(DynamicBoneHelper))

				if var_42_33 then
					var_42_33:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_32.transform, false)

				arg_39_1.var_[var_42_30 .. "Animator"] = var_42_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_[var_42_30 .. "Animator"].applyRootMotion = true
				arg_39_1.var_[var_42_30 .. "LipSync"] = var_42_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_34 = 0

			if var_42_34 < arg_39_1.time_ and arg_39_1.time_ <= var_42_34 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_42_35 = 0

			if var_42_35 < arg_39_1.time_ and arg_39_1.time_ <= var_42_35 + arg_42_0 then
				arg_39_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_36 = arg_39_1.actors_["1095ui_story"].transform
			local var_42_37 = 0

			if var_42_37 < arg_39_1.time_ and arg_39_1.time_ <= var_42_37 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_36.localPosition
			end

			local var_42_38 = 0.001

			if var_42_37 <= arg_39_1.time_ and arg_39_1.time_ < var_42_37 + var_42_38 then
				local var_42_39 = (arg_39_1.time_ - var_42_37) / var_42_38
				local var_42_40 = Vector3.New(0, -0.98, -6.1)

				var_42_36.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, var_42_40, var_42_39)

				local var_42_41 = manager.ui.mainCamera.transform.position - var_42_36.position

				var_42_36.forward = Vector3.New(var_42_41.x, var_42_41.y, var_42_41.z)

				local var_42_42 = var_42_36.localEulerAngles

				var_42_42.z = 0
				var_42_42.x = 0
				var_42_36.localEulerAngles = var_42_42
			end

			if arg_39_1.time_ >= var_42_37 + var_42_38 and arg_39_1.time_ < var_42_37 + var_42_38 + arg_42_0 then
				var_42_36.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_42_43 = manager.ui.mainCamera.transform.position - var_42_36.position

				var_42_36.forward = Vector3.New(var_42_43.x, var_42_43.y, var_42_43.z)

				local var_42_44 = var_42_36.localEulerAngles

				var_42_44.z = 0
				var_42_44.x = 0
				var_42_36.localEulerAngles = var_42_44
			end

			local var_42_45 = arg_39_1.actors_["1095ui_story"]
			local var_42_46 = 0

			if var_42_46 < arg_39_1.time_ and arg_39_1.time_ <= var_42_46 + arg_42_0 and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = var_42_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_47 = 0.200000002980232

			if var_42_46 <= arg_39_1.time_ and arg_39_1.time_ < var_42_46 + var_42_47 then
				local var_42_48 = (arg_39_1.time_ - var_42_46) / var_42_47

				if arg_39_1.var_.characterEffect1095ui_story then
					arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_46 + var_42_47 and arg_39_1.time_ < var_42_46 + var_42_47 + arg_42_0 and arg_39_1.var_.characterEffect1095ui_story then
				arg_39_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_42_49 = arg_39_1.actors_["1095ui_story"]
			local var_42_50 = 0

			if var_42_50 < arg_39_1.time_ and arg_39_1.time_ <= var_42_50 + arg_42_0 then
				if arg_39_1.var_.characterEffect1095ui_story == nil then
					arg_39_1.var_.characterEffect1095ui_story = var_42_49:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_42_51 = arg_39_1.var_.characterEffect1095ui_story

				var_42_51.imageEffect:turnOn(false)

				var_42_51.interferenceEffect.enabled = true
				var_42_51.interferenceEffect.noise = 0.01
				var_42_51.interferenceEffect.simTimeScale = 1
				var_42_51.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_42_52 = arg_39_1.actors_["1095ui_story"]
			local var_42_53 = 0
			local var_42_54 = 2

			if var_42_53 < arg_39_1.time_ and arg_39_1.time_ <= var_42_53 + arg_42_0 then
				if arg_39_1.var_.characterEffect1095ui_story == nil then
					arg_39_1.var_.characterEffect1095ui_story = var_42_52:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_39_1.var_.characterEffect1095ui_story.imageEffect:turnOn(false)
			end

			local var_42_55 = 0
			local var_42_56 = 0.575

			if var_42_55 < arg_39_1.time_ and arg_39_1.time_ <= var_42_55 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_57 = arg_39_1:FormatText(StoryNameCfg[471].name)

				arg_39_1.leftNameTxt_.text = var_42_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_58 = arg_39_1:GetWordFromCfg(319581010)
				local var_42_59 = arg_39_1:FormatText(var_42_58.content)

				arg_39_1.text_.text = var_42_59

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_60 = 23
				local var_42_61 = utf8.len(var_42_59)
				local var_42_62 = var_42_60 <= 0 and var_42_56 or var_42_56 * (var_42_61 / var_42_60)

				if var_42_62 > 0 and var_42_56 < var_42_62 then
					arg_39_1.talkMaxDuration = var_42_62

					if var_42_62 + var_42_55 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_62 + var_42_55
					end
				end

				arg_39_1.text_.text = var_42_59
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581010", "story_v_out_319581.awb") ~= 0 then
					local var_42_63 = manager.audio:GetVoiceLength("story_v_out_319581", "319581010", "story_v_out_319581.awb") / 1000

					if var_42_63 + var_42_55 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_63 + var_42_55
					end

					if var_42_58.prefab_name ~= "" and arg_39_1.actors_[var_42_58.prefab_name] ~= nil then
						local var_42_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_58.prefab_name].transform, "story_v_out_319581", "319581010", "story_v_out_319581.awb")

						arg_39_1:RecordAudio("319581010", var_42_64)
						arg_39_1:RecordAudio("319581010", var_42_64)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319581", "319581010", "story_v_out_319581.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319581", "319581010", "story_v_out_319581.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_65 = math.max(var_42_56, arg_39_1.talkMaxDuration)

			if var_42_55 <= arg_39_1.time_ and arg_39_1.time_ < var_42_55 + var_42_65 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_55) / var_42_65

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_55 + var_42_65 and arg_39_1.time_ < var_42_55 + var_42_65 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play319581011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319581011
		arg_43_1.duration_ = 4.1

		local var_43_0 = {
			zh = 2.3,
			ja = 4.1
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
				arg_43_0:Play319581012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["4040ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos4040ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0.7, -1.55, -5.5)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos4040ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["4040ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and arg_43_1.var_.characterEffect4040ui_story == nil then
				arg_43_1.var_.characterEffect4040ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect4040ui_story then
					local var_46_13 = Mathf.Lerp(0, 0.5, var_46_12)

					arg_43_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_43_1.var_.characterEffect4040ui_story.fillRatio = var_46_13
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and arg_43_1.var_.characterEffect4040ui_story then
				local var_46_14 = 0.5

				arg_43_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_43_1.var_.characterEffect4040ui_story.fillRatio = var_46_14
			end

			local var_46_15 = 0

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_17 = arg_43_1.actors_["10079ui_story"].transform
			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				arg_43_1.var_.moveOldPos10079ui_story = var_46_17.localPosition
			end

			local var_46_19 = 0.001

			if var_46_18 <= arg_43_1.time_ and arg_43_1.time_ < var_46_18 + var_46_19 then
				local var_46_20 = (arg_43_1.time_ - var_46_18) / var_46_19
				local var_46_21 = Vector3.New(-0.7, -0.95, -6.05)

				var_46_17.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10079ui_story, var_46_21, var_46_20)

				local var_46_22 = manager.ui.mainCamera.transform.position - var_46_17.position

				var_46_17.forward = Vector3.New(var_46_22.x, var_46_22.y, var_46_22.z)

				local var_46_23 = var_46_17.localEulerAngles

				var_46_23.z = 0
				var_46_23.x = 0
				var_46_17.localEulerAngles = var_46_23
			end

			if arg_43_1.time_ >= var_46_18 + var_46_19 and arg_43_1.time_ < var_46_18 + var_46_19 + arg_46_0 then
				var_46_17.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_46_24 = manager.ui.mainCamera.transform.position - var_46_17.position

				var_46_17.forward = Vector3.New(var_46_24.x, var_46_24.y, var_46_24.z)

				local var_46_25 = var_46_17.localEulerAngles

				var_46_25.z = 0
				var_46_25.x = 0
				var_46_17.localEulerAngles = var_46_25
			end

			local var_46_26 = arg_43_1.actors_["10079ui_story"]
			local var_46_27 = 0

			if var_46_27 < arg_43_1.time_ and arg_43_1.time_ <= var_46_27 + arg_46_0 and arg_43_1.var_.characterEffect10079ui_story == nil then
				arg_43_1.var_.characterEffect10079ui_story = var_46_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_28 = 0.200000002980232

			if var_46_27 <= arg_43_1.time_ and arg_43_1.time_ < var_46_27 + var_46_28 then
				local var_46_29 = (arg_43_1.time_ - var_46_27) / var_46_28

				if arg_43_1.var_.characterEffect10079ui_story then
					arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_27 + var_46_28 and arg_43_1.time_ < var_46_27 + var_46_28 + arg_46_0 and arg_43_1.var_.characterEffect10079ui_story then
				arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_46_30 = 0

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_46_31 = 0

			if var_46_31 < arg_43_1.time_ and arg_43_1.time_ <= var_46_31 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_32 = arg_43_1.actors_["1095ui_story"].transform
			local var_46_33 = 0

			if var_46_33 < arg_43_1.time_ and arg_43_1.time_ <= var_46_33 + arg_46_0 then
				arg_43_1.var_.moveOldPos1095ui_story = var_46_32.localPosition
			end

			local var_46_34 = 0.001

			if var_46_33 <= arg_43_1.time_ and arg_43_1.time_ < var_46_33 + var_46_34 then
				local var_46_35 = (arg_43_1.time_ - var_46_33) / var_46_34
				local var_46_36 = Vector3.New(0, 100, 0)

				var_46_32.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1095ui_story, var_46_36, var_46_35)

				local var_46_37 = manager.ui.mainCamera.transform.position - var_46_32.position

				var_46_32.forward = Vector3.New(var_46_37.x, var_46_37.y, var_46_37.z)

				local var_46_38 = var_46_32.localEulerAngles

				var_46_38.z = 0
				var_46_38.x = 0
				var_46_32.localEulerAngles = var_46_38
			end

			if arg_43_1.time_ >= var_46_33 + var_46_34 and arg_43_1.time_ < var_46_33 + var_46_34 + arg_46_0 then
				var_46_32.localPosition = Vector3.New(0, 100, 0)

				local var_46_39 = manager.ui.mainCamera.transform.position - var_46_32.position

				var_46_32.forward = Vector3.New(var_46_39.x, var_46_39.y, var_46_39.z)

				local var_46_40 = var_46_32.localEulerAngles

				var_46_40.z = 0
				var_46_40.x = 0
				var_46_32.localEulerAngles = var_46_40
			end

			local var_46_41 = arg_43_1.actors_["1095ui_story"]
			local var_46_42 = 0

			if var_46_42 < arg_43_1.time_ and arg_43_1.time_ <= var_46_42 + arg_46_0 and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = var_46_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_43 = 0.200000002980232

			if var_46_42 <= arg_43_1.time_ and arg_43_1.time_ < var_46_42 + var_46_43 then
				local var_46_44 = (arg_43_1.time_ - var_46_42) / var_46_43

				if arg_43_1.var_.characterEffect1095ui_story then
					local var_46_45 = Mathf.Lerp(0, 0.5, var_46_44)

					arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_45
				end
			end

			if arg_43_1.time_ >= var_46_42 + var_46_43 and arg_43_1.time_ < var_46_42 + var_46_43 + arg_46_0 and arg_43_1.var_.characterEffect1095ui_story then
				local var_46_46 = 0.5

				arg_43_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1095ui_story.fillRatio = var_46_46
			end

			local var_46_47 = 0
			local var_46_48 = 0.2

			if var_46_47 < arg_43_1.time_ and arg_43_1.time_ <= var_46_47 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_49 = arg_43_1:FormatText(StoryNameCfg[6].name)

				arg_43_1.leftNameTxt_.text = var_46_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_50 = arg_43_1:GetWordFromCfg(319581011)
				local var_46_51 = arg_43_1:FormatText(var_46_50.content)

				arg_43_1.text_.text = var_46_51

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_52 = 8
				local var_46_53 = utf8.len(var_46_51)
				local var_46_54 = var_46_52 <= 0 and var_46_48 or var_46_48 * (var_46_53 / var_46_52)

				if var_46_54 > 0 and var_46_48 < var_46_54 then
					arg_43_1.talkMaxDuration = var_46_54

					if var_46_54 + var_46_47 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_54 + var_46_47
					end
				end

				arg_43_1.text_.text = var_46_51
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581011", "story_v_out_319581.awb") ~= 0 then
					local var_46_55 = manager.audio:GetVoiceLength("story_v_out_319581", "319581011", "story_v_out_319581.awb") / 1000

					if var_46_55 + var_46_47 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_55 + var_46_47
					end

					if var_46_50.prefab_name ~= "" and arg_43_1.actors_[var_46_50.prefab_name] ~= nil then
						local var_46_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_50.prefab_name].transform, "story_v_out_319581", "319581011", "story_v_out_319581.awb")

						arg_43_1:RecordAudio("319581011", var_46_56)
						arg_43_1:RecordAudio("319581011", var_46_56)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319581", "319581011", "story_v_out_319581.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319581", "319581011", "story_v_out_319581.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_57 = math.max(var_46_48, arg_43_1.talkMaxDuration)

			if var_46_47 <= arg_43_1.time_ and arg_43_1.time_ < var_46_47 + var_46_57 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_47) / var_46_57

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_47 + var_46_57 and arg_43_1.time_ < var_46_47 + var_46_57 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play319581012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319581012
		arg_47_1.duration_ = 6.2

		local var_47_0 = {
			zh = 2.6,
			ja = 6.2
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
				arg_47_0:Play319581013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["4040ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and arg_47_1.var_.characterEffect4040ui_story == nil then
				arg_47_1.var_.characterEffect4040ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect4040ui_story then
					arg_47_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and arg_47_1.var_.characterEffect4040ui_story then
				arg_47_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["10079ui_story"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and arg_47_1.var_.characterEffect10079ui_story == nil then
				arg_47_1.var_.characterEffect10079ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.characterEffect10079ui_story then
					local var_50_8 = Mathf.Lerp(0, 0.5, var_50_7)

					arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10079ui_story.fillRatio = var_50_8
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and arg_47_1.var_.characterEffect10079ui_story then
				local var_50_9 = 0.5

				arg_47_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10079ui_story.fillRatio = var_50_9
			end

			local var_50_10 = 0
			local var_50_11 = 0.225

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_12 = arg_47_1:FormatText(StoryNameCfg[668].name)

				arg_47_1.leftNameTxt_.text = var_50_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_13 = arg_47_1:GetWordFromCfg(319581012)
				local var_50_14 = arg_47_1:FormatText(var_50_13.content)

				arg_47_1.text_.text = var_50_14

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_15 = 9
				local var_50_16 = utf8.len(var_50_14)
				local var_50_17 = var_50_15 <= 0 and var_50_11 or var_50_11 * (var_50_16 / var_50_15)

				if var_50_17 > 0 and var_50_11 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17

					if var_50_17 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_10
					end
				end

				arg_47_1.text_.text = var_50_14
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581012", "story_v_out_319581.awb") ~= 0 then
					local var_50_18 = manager.audio:GetVoiceLength("story_v_out_319581", "319581012", "story_v_out_319581.awb") / 1000

					if var_50_18 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_10
					end

					if var_50_13.prefab_name ~= "" and arg_47_1.actors_[var_50_13.prefab_name] ~= nil then
						local var_50_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_13.prefab_name].transform, "story_v_out_319581", "319581012", "story_v_out_319581.awb")

						arg_47_1:RecordAudio("319581012", var_50_19)
						arg_47_1:RecordAudio("319581012", var_50_19)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319581", "319581012", "story_v_out_319581.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319581", "319581012", "story_v_out_319581.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_20 = math.max(var_50_11, arg_47_1.talkMaxDuration)

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_20 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_10) / var_50_20

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_10 + var_50_20 and arg_47_1.time_ < var_50_10 + var_50_20 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end
	end,
	Play319581013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319581013
		arg_51_1.duration_ = 2.566

		local var_51_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_51_0:Play319581014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10079ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos10079ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10079ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["10079ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and arg_51_1.var_.characterEffect10079ui_story == nil then
				arg_51_1.var_.characterEffect10079ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect10079ui_story then
					arg_51_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and arg_51_1.var_.characterEffect10079ui_story then
				arg_51_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_15 = arg_51_1.actors_["4040ui_story"]
			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 and arg_51_1.var_.characterEffect4040ui_story == nil then
				arg_51_1.var_.characterEffect4040ui_story = var_54_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_17 = 0.200000002980232

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_17 then
				local var_54_18 = (arg_51_1.time_ - var_54_16) / var_54_17

				if arg_51_1.var_.characterEffect4040ui_story then
					local var_54_19 = Mathf.Lerp(0, 0.5, var_54_18)

					arg_51_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_51_1.var_.characterEffect4040ui_story.fillRatio = var_54_19
				end
			end

			if arg_51_1.time_ >= var_54_16 + var_54_17 and arg_51_1.time_ < var_54_16 + var_54_17 + arg_54_0 and arg_51_1.var_.characterEffect4040ui_story then
				local var_54_20 = 0.5

				arg_51_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_51_1.var_.characterEffect4040ui_story.fillRatio = var_54_20
			end

			local var_54_21 = 0
			local var_54_22 = 0.075

			if var_54_21 < arg_51_1.time_ and arg_51_1.time_ <= var_54_21 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_23 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_24 = arg_51_1:GetWordFromCfg(319581013)
				local var_54_25 = arg_51_1:FormatText(var_54_24.content)

				arg_51_1.text_.text = var_54_25

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_26 = 3
				local var_54_27 = utf8.len(var_54_25)
				local var_54_28 = var_54_26 <= 0 and var_54_22 or var_54_22 * (var_54_27 / var_54_26)

				if var_54_28 > 0 and var_54_22 < var_54_28 then
					arg_51_1.talkMaxDuration = var_54_28

					if var_54_28 + var_54_21 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_28 + var_54_21
					end
				end

				arg_51_1.text_.text = var_54_25
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581013", "story_v_out_319581.awb") ~= 0 then
					local var_54_29 = manager.audio:GetVoiceLength("story_v_out_319581", "319581013", "story_v_out_319581.awb") / 1000

					if var_54_29 + var_54_21 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_29 + var_54_21
					end

					if var_54_24.prefab_name ~= "" and arg_51_1.actors_[var_54_24.prefab_name] ~= nil then
						local var_54_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_24.prefab_name].transform, "story_v_out_319581", "319581013", "story_v_out_319581.awb")

						arg_51_1:RecordAudio("319581013", var_54_30)
						arg_51_1:RecordAudio("319581013", var_54_30)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319581", "319581013", "story_v_out_319581.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319581", "319581013", "story_v_out_319581.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_31 = math.max(var_54_22, arg_51_1.talkMaxDuration)

			if var_54_21 <= arg_51_1.time_ and arg_51_1.time_ < var_54_21 + var_54_31 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_21) / var_54_31

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_21 + var_54_31 and arg_51_1.time_ < var_54_21 + var_54_31 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play319581014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319581014
		arg_55_1.duration_ = 3.2

		local var_55_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319581015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10079ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos10079ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10079ui_story, var_58_4, var_58_3)

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

			local var_58_9 = arg_55_1.actors_["4040ui_story"].transform
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.var_.moveOldPos4040ui_story = var_58_9.localPosition
			end

			local var_58_11 = 0.001

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11
				local var_58_13 = Vector3.New(0, 100, 0)

				var_58_9.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos4040ui_story, var_58_13, var_58_12)

				local var_58_14 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_14.x, var_58_14.y, var_58_14.z)

				local var_58_15 = var_58_9.localEulerAngles

				var_58_15.z = 0
				var_58_15.x = 0
				var_58_9.localEulerAngles = var_58_15
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 then
				var_58_9.localPosition = Vector3.New(0, 100, 0)

				local var_58_16 = manager.ui.mainCamera.transform.position - var_58_9.position

				var_58_9.forward = Vector3.New(var_58_16.x, var_58_16.y, var_58_16.z)

				local var_58_17 = var_58_9.localEulerAngles

				var_58_17.z = 0
				var_58_17.x = 0
				var_58_9.localEulerAngles = var_58_17
			end

			local var_58_18 = arg_55_1.actors_["10079ui_story"]
			local var_58_19 = 0

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 and arg_55_1.var_.characterEffect10079ui_story == nil then
				arg_55_1.var_.characterEffect10079ui_story = var_58_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_20 = 0.200000002980232

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_20 then
				local var_58_21 = (arg_55_1.time_ - var_58_19) / var_58_20

				if arg_55_1.var_.characterEffect10079ui_story then
					local var_58_22 = Mathf.Lerp(0, 0.5, var_58_21)

					arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10079ui_story.fillRatio = var_58_22
				end
			end

			if arg_55_1.time_ >= var_58_19 + var_58_20 and arg_55_1.time_ < var_58_19 + var_58_20 + arg_58_0 and arg_55_1.var_.characterEffect10079ui_story then
				local var_58_23 = 0.5

				arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10079ui_story.fillRatio = var_58_23
			end

			local var_58_24 = 0

			if var_58_24 < arg_55_1.time_ and arg_55_1.time_ <= var_58_24 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_58_25 = 0

			if var_58_25 < arg_55_1.time_ and arg_55_1.time_ <= var_58_25 + arg_58_0 then
				arg_55_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_26 = arg_55_1.actors_["1095ui_story"].transform
			local var_58_27 = 0

			if var_58_27 < arg_55_1.time_ and arg_55_1.time_ <= var_58_27 + arg_58_0 then
				arg_55_1.var_.moveOldPos1095ui_story = var_58_26.localPosition
			end

			local var_58_28 = 0.001

			if var_58_27 <= arg_55_1.time_ and arg_55_1.time_ < var_58_27 + var_58_28 then
				local var_58_29 = (arg_55_1.time_ - var_58_27) / var_58_28
				local var_58_30 = Vector3.New(0, -0.98, -6.1)

				var_58_26.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1095ui_story, var_58_30, var_58_29)

				local var_58_31 = manager.ui.mainCamera.transform.position - var_58_26.position

				var_58_26.forward = Vector3.New(var_58_31.x, var_58_31.y, var_58_31.z)

				local var_58_32 = var_58_26.localEulerAngles

				var_58_32.z = 0
				var_58_32.x = 0
				var_58_26.localEulerAngles = var_58_32
			end

			if arg_55_1.time_ >= var_58_27 + var_58_28 and arg_55_1.time_ < var_58_27 + var_58_28 + arg_58_0 then
				var_58_26.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_58_33 = manager.ui.mainCamera.transform.position - var_58_26.position

				var_58_26.forward = Vector3.New(var_58_33.x, var_58_33.y, var_58_33.z)

				local var_58_34 = var_58_26.localEulerAngles

				var_58_34.z = 0
				var_58_34.x = 0
				var_58_26.localEulerAngles = var_58_34
			end

			local var_58_35 = arg_55_1.actors_["1095ui_story"]
			local var_58_36 = 0

			if var_58_36 < arg_55_1.time_ and arg_55_1.time_ <= var_58_36 + arg_58_0 and arg_55_1.var_.characterEffect1095ui_story == nil then
				arg_55_1.var_.characterEffect1095ui_story = var_58_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_37 = 0.200000002980232

			if var_58_36 <= arg_55_1.time_ and arg_55_1.time_ < var_58_36 + var_58_37 then
				local var_58_38 = (arg_55_1.time_ - var_58_36) / var_58_37

				if arg_55_1.var_.characterEffect1095ui_story then
					arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_36 + var_58_37 and arg_55_1.time_ < var_58_36 + var_58_37 + arg_58_0 and arg_55_1.var_.characterEffect1095ui_story then
				arg_55_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_58_39 = arg_55_1.actors_["4040ui_story"]
			local var_58_40 = 0

			if var_58_40 < arg_55_1.time_ and arg_55_1.time_ <= var_58_40 + arg_58_0 and arg_55_1.var_.characterEffect4040ui_story == nil then
				arg_55_1.var_.characterEffect4040ui_story = var_58_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_41 = 0.200000002980232

			if var_58_40 <= arg_55_1.time_ and arg_55_1.time_ < var_58_40 + var_58_41 then
				local var_58_42 = (arg_55_1.time_ - var_58_40) / var_58_41

				if arg_55_1.var_.characterEffect4040ui_story then
					local var_58_43 = Mathf.Lerp(0, 0.5, var_58_42)

					arg_55_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_55_1.var_.characterEffect4040ui_story.fillRatio = var_58_43
				end
			end

			if arg_55_1.time_ >= var_58_40 + var_58_41 and arg_55_1.time_ < var_58_40 + var_58_41 + arg_58_0 and arg_55_1.var_.characterEffect4040ui_story then
				local var_58_44 = 0.5

				arg_55_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_55_1.var_.characterEffect4040ui_story.fillRatio = var_58_44
			end

			local var_58_45 = 0
			local var_58_46 = 0.175

			if var_58_45 < arg_55_1.time_ and arg_55_1.time_ <= var_58_45 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_47 = arg_55_1:FormatText(StoryNameCfg[471].name)

				arg_55_1.leftNameTxt_.text = var_58_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_48 = arg_55_1:GetWordFromCfg(319581014)
				local var_58_49 = arg_55_1:FormatText(var_58_48.content)

				arg_55_1.text_.text = var_58_49

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_50 = 7
				local var_58_51 = utf8.len(var_58_49)
				local var_58_52 = var_58_50 <= 0 and var_58_46 or var_58_46 * (var_58_51 / var_58_50)

				if var_58_52 > 0 and var_58_46 < var_58_52 then
					arg_55_1.talkMaxDuration = var_58_52

					if var_58_52 + var_58_45 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_52 + var_58_45
					end
				end

				arg_55_1.text_.text = var_58_49
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581014", "story_v_out_319581.awb") ~= 0 then
					local var_58_53 = manager.audio:GetVoiceLength("story_v_out_319581", "319581014", "story_v_out_319581.awb") / 1000

					if var_58_53 + var_58_45 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_53 + var_58_45
					end

					if var_58_48.prefab_name ~= "" and arg_55_1.actors_[var_58_48.prefab_name] ~= nil then
						local var_58_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_48.prefab_name].transform, "story_v_out_319581", "319581014", "story_v_out_319581.awb")

						arg_55_1:RecordAudio("319581014", var_58_54)
						arg_55_1:RecordAudio("319581014", var_58_54)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319581", "319581014", "story_v_out_319581.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319581", "319581014", "story_v_out_319581.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_55 = math.max(var_58_46, arg_55_1.talkMaxDuration)

			if var_58_45 <= arg_55_1.time_ and arg_55_1.time_ < var_58_45 + var_58_55 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_45) / var_58_55

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_45 + var_58_55 and arg_55_1.time_ < var_58_45 + var_58_55 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play319581015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319581015
		arg_59_1.duration_ = 7.933

		local var_59_0 = {
			zh = 7.933,
			ja = 7.533
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
				arg_59_0:Play319581016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10079ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10079ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10079ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["4040ui_story"].transform
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1.var_.moveOldPos4040ui_story = var_62_9.localPosition
			end

			local var_62_11 = 0.001

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11
				local var_62_13 = Vector3.New(0.7, -1.55, -5.5)

				var_62_9.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos4040ui_story, var_62_13, var_62_12)

				local var_62_14 = manager.ui.mainCamera.transform.position - var_62_9.position

				var_62_9.forward = Vector3.New(var_62_14.x, var_62_14.y, var_62_14.z)

				local var_62_15 = var_62_9.localEulerAngles

				var_62_15.z = 0
				var_62_15.x = 0
				var_62_9.localEulerAngles = var_62_15
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 then
				var_62_9.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_62_16 = manager.ui.mainCamera.transform.position - var_62_9.position

				var_62_9.forward = Vector3.New(var_62_16.x, var_62_16.y, var_62_16.z)

				local var_62_17 = var_62_9.localEulerAngles

				var_62_17.z = 0
				var_62_17.x = 0
				var_62_9.localEulerAngles = var_62_17
			end

			local var_62_18 = arg_59_1.actors_["10079ui_story"]
			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 and arg_59_1.var_.characterEffect10079ui_story == nil then
				arg_59_1.var_.characterEffect10079ui_story = var_62_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_20 = 0.200000002980232

			if var_62_19 <= arg_59_1.time_ and arg_59_1.time_ < var_62_19 + var_62_20 then
				local var_62_21 = (arg_59_1.time_ - var_62_19) / var_62_20

				if arg_59_1.var_.characterEffect10079ui_story then
					local var_62_22 = Mathf.Lerp(0, 0.5, var_62_21)

					arg_59_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10079ui_story.fillRatio = var_62_22
				end
			end

			if arg_59_1.time_ >= var_62_19 + var_62_20 and arg_59_1.time_ < var_62_19 + var_62_20 + arg_62_0 and arg_59_1.var_.characterEffect10079ui_story then
				local var_62_23 = 0.5

				arg_59_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10079ui_story.fillRatio = var_62_23
			end

			local var_62_24 = 0

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_26 = arg_59_1.actors_["1095ui_story"].transform
			local var_62_27 = 0

			if var_62_27 < arg_59_1.time_ and arg_59_1.time_ <= var_62_27 + arg_62_0 then
				arg_59_1.var_.moveOldPos1095ui_story = var_62_26.localPosition
			end

			local var_62_28 = 0.001

			if var_62_27 <= arg_59_1.time_ and arg_59_1.time_ < var_62_27 + var_62_28 then
				local var_62_29 = (arg_59_1.time_ - var_62_27) / var_62_28
				local var_62_30 = Vector3.New(0, 100, 0)

				var_62_26.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1095ui_story, var_62_30, var_62_29)

				local var_62_31 = manager.ui.mainCamera.transform.position - var_62_26.position

				var_62_26.forward = Vector3.New(var_62_31.x, var_62_31.y, var_62_31.z)

				local var_62_32 = var_62_26.localEulerAngles

				var_62_32.z = 0
				var_62_32.x = 0
				var_62_26.localEulerAngles = var_62_32
			end

			if arg_59_1.time_ >= var_62_27 + var_62_28 and arg_59_1.time_ < var_62_27 + var_62_28 + arg_62_0 then
				var_62_26.localPosition = Vector3.New(0, 100, 0)

				local var_62_33 = manager.ui.mainCamera.transform.position - var_62_26.position

				var_62_26.forward = Vector3.New(var_62_33.x, var_62_33.y, var_62_33.z)

				local var_62_34 = var_62_26.localEulerAngles

				var_62_34.z = 0
				var_62_34.x = 0
				var_62_26.localEulerAngles = var_62_34
			end

			local var_62_35 = arg_59_1.actors_["1095ui_story"]
			local var_62_36 = 0

			if var_62_36 < arg_59_1.time_ and arg_59_1.time_ <= var_62_36 + arg_62_0 and arg_59_1.var_.characterEffect1095ui_story == nil then
				arg_59_1.var_.characterEffect1095ui_story = var_62_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_37 = 0.200000002980232

			if var_62_36 <= arg_59_1.time_ and arg_59_1.time_ < var_62_36 + var_62_37 then
				local var_62_38 = (arg_59_1.time_ - var_62_36) / var_62_37

				if arg_59_1.var_.characterEffect1095ui_story then
					local var_62_39 = Mathf.Lerp(0, 0.5, var_62_38)

					arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_39
				end
			end

			if arg_59_1.time_ >= var_62_36 + var_62_37 and arg_59_1.time_ < var_62_36 + var_62_37 + arg_62_0 and arg_59_1.var_.characterEffect1095ui_story then
				local var_62_40 = 0.5

				arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_40
			end

			local var_62_41 = arg_59_1.actors_["4040ui_story"]
			local var_62_42 = 0

			if var_62_42 < arg_59_1.time_ and arg_59_1.time_ <= var_62_42 + arg_62_0 and arg_59_1.var_.characterEffect4040ui_story == nil then
				arg_59_1.var_.characterEffect4040ui_story = var_62_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_43 = 0.200000002980232

			if var_62_42 <= arg_59_1.time_ and arg_59_1.time_ < var_62_42 + var_62_43 then
				local var_62_44 = (arg_59_1.time_ - var_62_42) / var_62_43

				if arg_59_1.var_.characterEffect4040ui_story then
					arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_42 + var_62_43 and arg_59_1.time_ < var_62_42 + var_62_43 + arg_62_0 and arg_59_1.var_.characterEffect4040ui_story then
				arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_62_45 = 0

			if var_62_45 < arg_59_1.time_ and arg_59_1.time_ <= var_62_45 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_62_46 = 0

			if var_62_46 < arg_59_1.time_ and arg_59_1.time_ <= var_62_46 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_47 = 0
			local var_62_48 = 0.675

			if var_62_47 < arg_59_1.time_ and arg_59_1.time_ <= var_62_47 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_49 = arg_59_1:FormatText(StoryNameCfg[668].name)

				arg_59_1.leftNameTxt_.text = var_62_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_50 = arg_59_1:GetWordFromCfg(319581015)
				local var_62_51 = arg_59_1:FormatText(var_62_50.content)

				arg_59_1.text_.text = var_62_51

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_52 = 27
				local var_62_53 = utf8.len(var_62_51)
				local var_62_54 = var_62_52 <= 0 and var_62_48 or var_62_48 * (var_62_53 / var_62_52)

				if var_62_54 > 0 and var_62_48 < var_62_54 then
					arg_59_1.talkMaxDuration = var_62_54

					if var_62_54 + var_62_47 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_54 + var_62_47
					end
				end

				arg_59_1.text_.text = var_62_51
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581015", "story_v_out_319581.awb") ~= 0 then
					local var_62_55 = manager.audio:GetVoiceLength("story_v_out_319581", "319581015", "story_v_out_319581.awb") / 1000

					if var_62_55 + var_62_47 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_55 + var_62_47
					end

					if var_62_50.prefab_name ~= "" and arg_59_1.actors_[var_62_50.prefab_name] ~= nil then
						local var_62_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_50.prefab_name].transform, "story_v_out_319581", "319581015", "story_v_out_319581.awb")

						arg_59_1:RecordAudio("319581015", var_62_56)
						arg_59_1:RecordAudio("319581015", var_62_56)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319581", "319581015", "story_v_out_319581.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319581", "319581015", "story_v_out_319581.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_57 = math.max(var_62_48, arg_59_1.talkMaxDuration)

			if var_62_47 <= arg_59_1.time_ and arg_59_1.time_ < var_62_47 + var_62_57 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_47) / var_62_57

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_47 + var_62_57 and arg_59_1.time_ < var_62_47 + var_62_57 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	Play319581016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319581016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319581017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["4040ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and arg_63_1.var_.characterEffect4040ui_story == nil then
				arg_63_1.var_.characterEffect4040ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect4040ui_story then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_63_1.var_.characterEffect4040ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and arg_63_1.var_.characterEffect4040ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_63_1.var_.characterEffect4040ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.625

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(319581016)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 25
				local var_66_11 = utf8.len(var_66_9)
				local var_66_12 = var_66_10 <= 0 and var_66_7 or var_66_7 * (var_66_11 / var_66_10)

				if var_66_12 > 0 and var_66_7 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_13 and arg_63_1.time_ < var_66_6 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end
	end,
	Play319581017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319581017
		arg_67_1.duration_ = 8.266

		local var_67_0 = {
			zh = 6.2,
			ja = 8.266
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
				arg_67_0:Play319581018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10079ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and arg_67_1.var_.characterEffect10079ui_story == nil then
				arg_67_1.var_.characterEffect10079ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect10079ui_story then
					arg_67_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and arg_67_1.var_.characterEffect10079ui_story then
				arg_67_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 0.775

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_6 = arg_67_1:FormatText(StoryNameCfg[6].name)

				arg_67_1.leftNameTxt_.text = var_70_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(319581017)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 31
				local var_70_10 = utf8.len(var_70_8)
				local var_70_11 = var_70_9 <= 0 and var_70_5 or var_70_5 * (var_70_10 / var_70_9)

				if var_70_11 > 0 and var_70_5 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581017", "story_v_out_319581.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_319581", "319581017", "story_v_out_319581.awb") / 1000

					if var_70_12 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_4
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_319581", "319581017", "story_v_out_319581.awb")

						arg_67_1:RecordAudio("319581017", var_70_13)
						arg_67_1:RecordAudio("319581017", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319581", "319581017", "story_v_out_319581.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319581", "319581017", "story_v_out_319581.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_14 and arg_67_1.time_ < var_70_4 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play319581018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319581018
		arg_71_1.duration_ = 12.033

		local var_71_0 = {
			zh = 9.7,
			ja = 12.033
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
				arg_71_0:Play319581019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["4040ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and arg_71_1.var_.characterEffect4040ui_story == nil then
				arg_71_1.var_.characterEffect4040ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect4040ui_story then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_71_1.var_.characterEffect4040ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and arg_71_1.var_.characterEffect4040ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_71_1.var_.characterEffect4040ui_story.fillRatio = var_74_5
			end

			local var_74_6 = arg_71_1.actors_["10079ui_story"].transform
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.var_.moveOldPos10079ui_story = var_74_6.localPosition
			end

			local var_74_8 = 0.001

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8
				local var_74_10 = Vector3.New(0, 100, 0)

				var_74_6.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10079ui_story, var_74_10, var_74_9)

				local var_74_11 = manager.ui.mainCamera.transform.position - var_74_6.position

				var_74_6.forward = Vector3.New(var_74_11.x, var_74_11.y, var_74_11.z)

				local var_74_12 = var_74_6.localEulerAngles

				var_74_12.z = 0
				var_74_12.x = 0
				var_74_6.localEulerAngles = var_74_12
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 then
				var_74_6.localPosition = Vector3.New(0, 100, 0)

				local var_74_13 = manager.ui.mainCamera.transform.position - var_74_6.position

				var_74_6.forward = Vector3.New(var_74_13.x, var_74_13.y, var_74_13.z)

				local var_74_14 = var_74_6.localEulerAngles

				var_74_14.z = 0
				var_74_14.x = 0
				var_74_6.localEulerAngles = var_74_14
			end

			local var_74_15 = arg_71_1.actors_["4040ui_story"].transform
			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.var_.moveOldPos4040ui_story = var_74_15.localPosition
			end

			local var_74_17 = 0.001

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_17 then
				local var_74_18 = (arg_71_1.time_ - var_74_16) / var_74_17
				local var_74_19 = Vector3.New(0, 100, 0)

				var_74_15.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos4040ui_story, var_74_19, var_74_18)

				local var_74_20 = manager.ui.mainCamera.transform.position - var_74_15.position

				var_74_15.forward = Vector3.New(var_74_20.x, var_74_20.y, var_74_20.z)

				local var_74_21 = var_74_15.localEulerAngles

				var_74_21.z = 0
				var_74_21.x = 0
				var_74_15.localEulerAngles = var_74_21
			end

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				var_74_15.localPosition = Vector3.New(0, 100, 0)

				local var_74_22 = manager.ui.mainCamera.transform.position - var_74_15.position

				var_74_15.forward = Vector3.New(var_74_22.x, var_74_22.y, var_74_22.z)

				local var_74_23 = var_74_15.localEulerAngles

				var_74_23.z = 0
				var_74_23.x = 0
				var_74_15.localEulerAngles = var_74_23
			end

			local var_74_24 = arg_71_1.actors_["10079ui_story"]
			local var_74_25 = 0

			if var_74_25 < arg_71_1.time_ and arg_71_1.time_ <= var_74_25 + arg_74_0 and arg_71_1.var_.characterEffect10079ui_story == nil then
				arg_71_1.var_.characterEffect10079ui_story = var_74_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_26 = 0.200000002980232

			if var_74_25 <= arg_71_1.time_ and arg_71_1.time_ < var_74_25 + var_74_26 then
				local var_74_27 = (arg_71_1.time_ - var_74_25) / var_74_26

				if arg_71_1.var_.characterEffect10079ui_story then
					arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_25 + var_74_26 and arg_71_1.time_ < var_74_25 + var_74_26 + arg_74_0 and arg_71_1.var_.characterEffect10079ui_story then
				arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_74_28 = 0

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_74_29 = 0

			if var_74_29 < arg_71_1.time_ and arg_71_1.time_ <= var_74_29 + arg_74_0 then
				arg_71_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_30 = arg_71_1.actors_["1095ui_story"].transform
			local var_74_31 = 0

			if var_74_31 < arg_71_1.time_ and arg_71_1.time_ <= var_74_31 + arg_74_0 then
				arg_71_1.var_.moveOldPos1095ui_story = var_74_30.localPosition
			end

			local var_74_32 = 0.001

			if var_74_31 <= arg_71_1.time_ and arg_71_1.time_ < var_74_31 + var_74_32 then
				local var_74_33 = (arg_71_1.time_ - var_74_31) / var_74_32
				local var_74_34 = Vector3.New(0, -0.98, -6.1)

				var_74_30.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1095ui_story, var_74_34, var_74_33)

				local var_74_35 = manager.ui.mainCamera.transform.position - var_74_30.position

				var_74_30.forward = Vector3.New(var_74_35.x, var_74_35.y, var_74_35.z)

				local var_74_36 = var_74_30.localEulerAngles

				var_74_36.z = 0
				var_74_36.x = 0
				var_74_30.localEulerAngles = var_74_36
			end

			if arg_71_1.time_ >= var_74_31 + var_74_32 and arg_71_1.time_ < var_74_31 + var_74_32 + arg_74_0 then
				var_74_30.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_74_37 = manager.ui.mainCamera.transform.position - var_74_30.position

				var_74_30.forward = Vector3.New(var_74_37.x, var_74_37.y, var_74_37.z)

				local var_74_38 = var_74_30.localEulerAngles

				var_74_38.z = 0
				var_74_38.x = 0
				var_74_30.localEulerAngles = var_74_38
			end

			local var_74_39 = arg_71_1.actors_["1095ui_story"]
			local var_74_40 = 0

			if var_74_40 < arg_71_1.time_ and arg_71_1.time_ <= var_74_40 + arg_74_0 and arg_71_1.var_.characterEffect1095ui_story == nil then
				arg_71_1.var_.characterEffect1095ui_story = var_74_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_41 = 0.200000002980232

			if var_74_40 <= arg_71_1.time_ and arg_71_1.time_ < var_74_40 + var_74_41 then
				local var_74_42 = (arg_71_1.time_ - var_74_40) / var_74_41

				if arg_71_1.var_.characterEffect1095ui_story then
					arg_71_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_40 + var_74_41 and arg_71_1.time_ < var_74_40 + var_74_41 + arg_74_0 and arg_71_1.var_.characterEffect1095ui_story then
				arg_71_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_74_43 = 0
			local var_74_44 = 1.2

			if var_74_43 < arg_71_1.time_ and arg_71_1.time_ <= var_74_43 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_45 = arg_71_1:FormatText(StoryNameCfg[471].name)

				arg_71_1.leftNameTxt_.text = var_74_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_46 = arg_71_1:GetWordFromCfg(319581018)
				local var_74_47 = arg_71_1:FormatText(var_74_46.content)

				arg_71_1.text_.text = var_74_47

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_48 = 48
				local var_74_49 = utf8.len(var_74_47)
				local var_74_50 = var_74_48 <= 0 and var_74_44 or var_74_44 * (var_74_49 / var_74_48)

				if var_74_50 > 0 and var_74_44 < var_74_50 then
					arg_71_1.talkMaxDuration = var_74_50

					if var_74_50 + var_74_43 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_50 + var_74_43
					end
				end

				arg_71_1.text_.text = var_74_47
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581018", "story_v_out_319581.awb") ~= 0 then
					local var_74_51 = manager.audio:GetVoiceLength("story_v_out_319581", "319581018", "story_v_out_319581.awb") / 1000

					if var_74_51 + var_74_43 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_51 + var_74_43
					end

					if var_74_46.prefab_name ~= "" and arg_71_1.actors_[var_74_46.prefab_name] ~= nil then
						local var_74_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_46.prefab_name].transform, "story_v_out_319581", "319581018", "story_v_out_319581.awb")

						arg_71_1:RecordAudio("319581018", var_74_52)
						arg_71_1:RecordAudio("319581018", var_74_52)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319581", "319581018", "story_v_out_319581.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319581", "319581018", "story_v_out_319581.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_53 = math.max(var_74_44, arg_71_1.talkMaxDuration)

			if var_74_43 <= arg_71_1.time_ and arg_71_1.time_ < var_74_43 + var_74_53 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_43) / var_74_53

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_43 + var_74_53 and arg_71_1.time_ < var_74_43 + var_74_53 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play319581019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319581019
		arg_75_1.duration_ = 1.999999999999

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319581020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10079ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos10079ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10079ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["4040ui_story"].transform
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1.var_.moveOldPos4040ui_story = var_78_9.localPosition
			end

			local var_78_11 = 0.001

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11
				local var_78_13 = Vector3.New(0.7, -1.55, -5.5)

				var_78_9.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos4040ui_story, var_78_13, var_78_12)

				local var_78_14 = manager.ui.mainCamera.transform.position - var_78_9.position

				var_78_9.forward = Vector3.New(var_78_14.x, var_78_14.y, var_78_14.z)

				local var_78_15 = var_78_9.localEulerAngles

				var_78_15.z = 0
				var_78_15.x = 0
				var_78_9.localEulerAngles = var_78_15
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 then
				var_78_9.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_78_16 = manager.ui.mainCamera.transform.position - var_78_9.position

				var_78_9.forward = Vector3.New(var_78_16.x, var_78_16.y, var_78_16.z)

				local var_78_17 = var_78_9.localEulerAngles

				var_78_17.z = 0
				var_78_17.x = 0
				var_78_9.localEulerAngles = var_78_17
			end

			local var_78_18 = arg_75_1.actors_["10079ui_story"]
			local var_78_19 = 0

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 and arg_75_1.var_.characterEffect10079ui_story == nil then
				arg_75_1.var_.characterEffect10079ui_story = var_78_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_20 = 0.200000002980232

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_20 then
				local var_78_21 = (arg_75_1.time_ - var_78_19) / var_78_20

				if arg_75_1.var_.characterEffect10079ui_story then
					arg_75_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_19 + var_78_20 and arg_75_1.time_ < var_78_19 + var_78_20 + arg_78_0 and arg_75_1.var_.characterEffect10079ui_story then
				arg_75_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_78_22 = 0

			if var_78_22 < arg_75_1.time_ and arg_75_1.time_ <= var_78_22 + arg_78_0 then
				arg_75_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_78_23 = 0

			if var_78_23 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_24 = arg_75_1.actors_["1095ui_story"].transform
			local var_78_25 = 0

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 then
				arg_75_1.var_.moveOldPos1095ui_story = var_78_24.localPosition
			end

			local var_78_26 = 0.001

			if var_78_25 <= arg_75_1.time_ and arg_75_1.time_ < var_78_25 + var_78_26 then
				local var_78_27 = (arg_75_1.time_ - var_78_25) / var_78_26
				local var_78_28 = Vector3.New(0, 100, 0)

				var_78_24.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1095ui_story, var_78_28, var_78_27)

				local var_78_29 = manager.ui.mainCamera.transform.position - var_78_24.position

				var_78_24.forward = Vector3.New(var_78_29.x, var_78_29.y, var_78_29.z)

				local var_78_30 = var_78_24.localEulerAngles

				var_78_30.z = 0
				var_78_30.x = 0
				var_78_24.localEulerAngles = var_78_30
			end

			if arg_75_1.time_ >= var_78_25 + var_78_26 and arg_75_1.time_ < var_78_25 + var_78_26 + arg_78_0 then
				var_78_24.localPosition = Vector3.New(0, 100, 0)

				local var_78_31 = manager.ui.mainCamera.transform.position - var_78_24.position

				var_78_24.forward = Vector3.New(var_78_31.x, var_78_31.y, var_78_31.z)

				local var_78_32 = var_78_24.localEulerAngles

				var_78_32.z = 0
				var_78_32.x = 0
				var_78_24.localEulerAngles = var_78_32
			end

			local var_78_33 = arg_75_1.actors_["1095ui_story"]
			local var_78_34 = 0

			if var_78_34 < arg_75_1.time_ and arg_75_1.time_ <= var_78_34 + arg_78_0 and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = var_78_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_35 = 0.200000002980232

			if var_78_34 <= arg_75_1.time_ and arg_75_1.time_ < var_78_34 + var_78_35 then
				local var_78_36 = (arg_75_1.time_ - var_78_34) / var_78_35

				if arg_75_1.var_.characterEffect1095ui_story then
					local var_78_37 = Mathf.Lerp(0, 0.5, var_78_36)

					arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1095ui_story.fillRatio = var_78_37
				end
			end

			if arg_75_1.time_ >= var_78_34 + var_78_35 and arg_75_1.time_ < var_78_34 + var_78_35 + arg_78_0 and arg_75_1.var_.characterEffect1095ui_story then
				local var_78_38 = 0.5

				arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1095ui_story.fillRatio = var_78_38
			end

			local var_78_39 = arg_75_1.actors_["4040ui_story"]
			local var_78_40 = 0

			if var_78_40 < arg_75_1.time_ and arg_75_1.time_ <= var_78_40 + arg_78_0 and arg_75_1.var_.characterEffect4040ui_story == nil then
				arg_75_1.var_.characterEffect4040ui_story = var_78_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_41 = 0.200000002980232

			if var_78_40 <= arg_75_1.time_ and arg_75_1.time_ < var_78_40 + var_78_41 then
				local var_78_42 = (arg_75_1.time_ - var_78_40) / var_78_41

				if arg_75_1.var_.characterEffect4040ui_story then
					local var_78_43 = Mathf.Lerp(0, 0.5, var_78_42)

					arg_75_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_75_1.var_.characterEffect4040ui_story.fillRatio = var_78_43
				end
			end

			if arg_75_1.time_ >= var_78_40 + var_78_41 and arg_75_1.time_ < var_78_40 + var_78_41 + arg_78_0 and arg_75_1.var_.characterEffect4040ui_story then
				local var_78_44 = 0.5

				arg_75_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_75_1.var_.characterEffect4040ui_story.fillRatio = var_78_44
			end

			local var_78_45 = 0

			if var_78_45 < arg_75_1.time_ and arg_75_1.time_ <= var_78_45 + arg_78_0 then
				arg_75_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_78_46 = 0

			if var_78_46 < arg_75_1.time_ and arg_75_1.time_ <= var_78_46 + arg_78_0 then
				arg_75_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_47 = 0
			local var_78_48 = 0.1

			if var_78_47 < arg_75_1.time_ and arg_75_1.time_ <= var_78_47 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_49 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_50 = arg_75_1:GetWordFromCfg(319581019)
				local var_78_51 = arg_75_1:FormatText(var_78_50.content)

				arg_75_1.text_.text = var_78_51

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_52 = 4
				local var_78_53 = utf8.len(var_78_51)
				local var_78_54 = var_78_52 <= 0 and var_78_48 or var_78_48 * (var_78_53 / var_78_52)

				if var_78_54 > 0 and var_78_48 < var_78_54 then
					arg_75_1.talkMaxDuration = var_78_54

					if var_78_54 + var_78_47 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_54 + var_78_47
					end
				end

				arg_75_1.text_.text = var_78_51
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581019", "story_v_out_319581.awb") ~= 0 then
					local var_78_55 = manager.audio:GetVoiceLength("story_v_out_319581", "319581019", "story_v_out_319581.awb") / 1000

					if var_78_55 + var_78_47 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_55 + var_78_47
					end

					if var_78_50.prefab_name ~= "" and arg_75_1.actors_[var_78_50.prefab_name] ~= nil then
						local var_78_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_50.prefab_name].transform, "story_v_out_319581", "319581019", "story_v_out_319581.awb")

						arg_75_1:RecordAudio("319581019", var_78_56)
						arg_75_1:RecordAudio("319581019", var_78_56)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319581", "319581019", "story_v_out_319581.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319581", "319581019", "story_v_out_319581.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_57 = math.max(var_78_48, arg_75_1.talkMaxDuration)

			if var_78_47 <= arg_75_1.time_ and arg_75_1.time_ < var_78_47 + var_78_57 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_47) / var_78_57

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_47 + var_78_57 and arg_75_1.time_ < var_78_47 + var_78_57 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play319581020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319581020
		arg_79_1.duration_ = 3.4

		local var_79_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_79_0:Play319581021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["4040ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos4040ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0.7, -1.55, -5.5)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos4040ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["4040ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and arg_79_1.var_.characterEffect4040ui_story == nil then
				arg_79_1.var_.characterEffect4040ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect4040ui_story then
					arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and arg_79_1.var_.characterEffect4040ui_story then
				arg_79_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_15 = arg_79_1.actors_["10079ui_story"]
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 and arg_79_1.var_.characterEffect10079ui_story == nil then
				arg_79_1.var_.characterEffect10079ui_story = var_82_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_17 = 0.200000002980232

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17

				if arg_79_1.var_.characterEffect10079ui_story then
					local var_82_19 = Mathf.Lerp(0, 0.5, var_82_18)

					arg_79_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10079ui_story.fillRatio = var_82_19
				end
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 and arg_79_1.var_.characterEffect10079ui_story then
				local var_82_20 = 0.5

				arg_79_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10079ui_story.fillRatio = var_82_20
			end

			local var_82_21 = 0
			local var_82_22 = 0.125

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[668].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(319581020)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 5
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581020", "story_v_out_319581.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_319581", "319581020", "story_v_out_319581.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_319581", "319581020", "story_v_out_319581.awb")

						arg_79_1:RecordAudio("319581020", var_82_30)
						arg_79_1:RecordAudio("319581020", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319581", "319581020", "story_v_out_319581.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319581", "319581020", "story_v_out_319581.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play319581021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319581021
		arg_83_1.duration_ = 5.1

		local var_83_0 = {
			zh = 3.1,
			ja = 5.1
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319581022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["4040ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and arg_83_1.var_.characterEffect4040ui_story == nil then
				arg_83_1.var_.characterEffect4040ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect4040ui_story then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_83_1.var_.characterEffect4040ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and arg_83_1.var_.characterEffect4040ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_83_1.var_.characterEffect4040ui_story.fillRatio = var_86_5
			end

			local var_86_6 = arg_83_1.actors_["10079ui_story"]
			local var_86_7 = 0

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 and arg_83_1.var_.characterEffect10079ui_story == nil then
				arg_83_1.var_.characterEffect10079ui_story = var_86_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_8 = 0.200000002980232

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_8 then
				local var_86_9 = (arg_83_1.time_ - var_86_7) / var_86_8

				if arg_83_1.var_.characterEffect10079ui_story then
					arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_7 + var_86_8 and arg_83_1.time_ < var_86_7 + var_86_8 + arg_86_0 and arg_83_1.var_.characterEffect10079ui_story then
				arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_86_10 = 0
			local var_86_11 = 0.3

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_12 = arg_83_1:FormatText(StoryNameCfg[6].name)

				arg_83_1.leftNameTxt_.text = var_86_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_13 = arg_83_1:GetWordFromCfg(319581021)
				local var_86_14 = arg_83_1:FormatText(var_86_13.content)

				arg_83_1.text_.text = var_86_14

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_15 = 12
				local var_86_16 = utf8.len(var_86_14)
				local var_86_17 = var_86_15 <= 0 and var_86_11 or var_86_11 * (var_86_16 / var_86_15)

				if var_86_17 > 0 and var_86_11 < var_86_17 then
					arg_83_1.talkMaxDuration = var_86_17

					if var_86_17 + var_86_10 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_17 + var_86_10
					end
				end

				arg_83_1.text_.text = var_86_14
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581021", "story_v_out_319581.awb") ~= 0 then
					local var_86_18 = manager.audio:GetVoiceLength("story_v_out_319581", "319581021", "story_v_out_319581.awb") / 1000

					if var_86_18 + var_86_10 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_10
					end

					if var_86_13.prefab_name ~= "" and arg_83_1.actors_[var_86_13.prefab_name] ~= nil then
						local var_86_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_13.prefab_name].transform, "story_v_out_319581", "319581021", "story_v_out_319581.awb")

						arg_83_1:RecordAudio("319581021", var_86_19)
						arg_83_1:RecordAudio("319581021", var_86_19)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319581", "319581021", "story_v_out_319581.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319581", "319581021", "story_v_out_319581.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_20 = math.max(var_86_11, arg_83_1.talkMaxDuration)

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_20 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_10) / var_86_20

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_10 + var_86_20 and arg_83_1.time_ < var_86_10 + var_86_20 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end
	end,
	Play319581022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319581022
		arg_87_1.duration_ = 2.833

		local var_87_0 = {
			zh = 2.1,
			ja = 2.833
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
				arg_87_0:Play319581023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.275

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[6].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(319581022)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 11
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581022", "story_v_out_319581.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_319581", "319581022", "story_v_out_319581.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_319581", "319581022", "story_v_out_319581.awb")

						arg_87_1:RecordAudio("319581022", var_90_9)
						arg_87_1:RecordAudio("319581022", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319581", "319581022", "story_v_out_319581.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319581", "319581022", "story_v_out_319581.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end
	end,
	Play319581023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319581023
		arg_91_1.duration_ = 10.933

		local var_91_0 = {
			zh = 7.533,
			ja = 10.933
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319581024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10079ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10079ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10079ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["4040ui_story"].transform
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.var_.moveOldPos4040ui_story = var_94_9.localPosition
			end

			local var_94_11 = 0.001

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11
				local var_94_13 = Vector3.New(0, 100, 0)

				var_94_9.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos4040ui_story, var_94_13, var_94_12)

				local var_94_14 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_14.x, var_94_14.y, var_94_14.z)

				local var_94_15 = var_94_9.localEulerAngles

				var_94_15.z = 0
				var_94_15.x = 0
				var_94_9.localEulerAngles = var_94_15
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 then
				var_94_9.localPosition = Vector3.New(0, 100, 0)

				local var_94_16 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_16.x, var_94_16.y, var_94_16.z)

				local var_94_17 = var_94_9.localEulerAngles

				var_94_17.z = 0
				var_94_17.x = 0
				var_94_9.localEulerAngles = var_94_17
			end

			local var_94_18 = arg_91_1.actors_["10079ui_story"]
			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 and arg_91_1.var_.characterEffect10079ui_story == nil then
				arg_91_1.var_.characterEffect10079ui_story = var_94_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_20 = 0.200000002980232

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 then
				local var_94_21 = (arg_91_1.time_ - var_94_19) / var_94_20

				if arg_91_1.var_.characterEffect10079ui_story then
					arg_91_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 and arg_91_1.var_.characterEffect10079ui_story then
				arg_91_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_94_22 = 0

			if var_94_22 < arg_91_1.time_ and arg_91_1.time_ <= var_94_22 + arg_94_0 then
				arg_91_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_94_23 = 0

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_24 = arg_91_1.actors_["1095ui_story"].transform
			local var_94_25 = 0

			if var_94_25 < arg_91_1.time_ and arg_91_1.time_ <= var_94_25 + arg_94_0 then
				arg_91_1.var_.moveOldPos1095ui_story = var_94_24.localPosition
			end

			local var_94_26 = 0.001

			if var_94_25 <= arg_91_1.time_ and arg_91_1.time_ < var_94_25 + var_94_26 then
				local var_94_27 = (arg_91_1.time_ - var_94_25) / var_94_26
				local var_94_28 = Vector3.New(0, -0.98, -6.1)

				var_94_24.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1095ui_story, var_94_28, var_94_27)

				local var_94_29 = manager.ui.mainCamera.transform.position - var_94_24.position

				var_94_24.forward = Vector3.New(var_94_29.x, var_94_29.y, var_94_29.z)

				local var_94_30 = var_94_24.localEulerAngles

				var_94_30.z = 0
				var_94_30.x = 0
				var_94_24.localEulerAngles = var_94_30
			end

			if arg_91_1.time_ >= var_94_25 + var_94_26 and arg_91_1.time_ < var_94_25 + var_94_26 + arg_94_0 then
				var_94_24.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_94_31 = manager.ui.mainCamera.transform.position - var_94_24.position

				var_94_24.forward = Vector3.New(var_94_31.x, var_94_31.y, var_94_31.z)

				local var_94_32 = var_94_24.localEulerAngles

				var_94_32.z = 0
				var_94_32.x = 0
				var_94_24.localEulerAngles = var_94_32
			end

			local var_94_33 = arg_91_1.actors_["1095ui_story"]
			local var_94_34 = 0

			if var_94_34 < arg_91_1.time_ and arg_91_1.time_ <= var_94_34 + arg_94_0 and arg_91_1.var_.characterEffect1095ui_story == nil then
				arg_91_1.var_.characterEffect1095ui_story = var_94_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_35 = 0.200000002980232

			if var_94_34 <= arg_91_1.time_ and arg_91_1.time_ < var_94_34 + var_94_35 then
				local var_94_36 = (arg_91_1.time_ - var_94_34) / var_94_35

				if arg_91_1.var_.characterEffect1095ui_story then
					arg_91_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_34 + var_94_35 and arg_91_1.time_ < var_94_34 + var_94_35 + arg_94_0 and arg_91_1.var_.characterEffect1095ui_story then
				arg_91_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_94_37 = arg_91_1.actors_["4040ui_story"]
			local var_94_38 = 0

			if var_94_38 < arg_91_1.time_ and arg_91_1.time_ <= var_94_38 + arg_94_0 and arg_91_1.var_.characterEffect4040ui_story == nil then
				arg_91_1.var_.characterEffect4040ui_story = var_94_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_39 = 0.200000002980232

			if var_94_38 <= arg_91_1.time_ and arg_91_1.time_ < var_94_38 + var_94_39 then
				local var_94_40 = (arg_91_1.time_ - var_94_38) / var_94_39

				if arg_91_1.var_.characterEffect4040ui_story then
					local var_94_41 = Mathf.Lerp(0, 0.5, var_94_40)

					arg_91_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_91_1.var_.characterEffect4040ui_story.fillRatio = var_94_41
				end
			end

			if arg_91_1.time_ >= var_94_38 + var_94_39 and arg_91_1.time_ < var_94_38 + var_94_39 + arg_94_0 and arg_91_1.var_.characterEffect4040ui_story then
				local var_94_42 = 0.5

				arg_91_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_91_1.var_.characterEffect4040ui_story.fillRatio = var_94_42
			end

			local var_94_43 = 0
			local var_94_44 = 0.9

			if var_94_43 < arg_91_1.time_ and arg_91_1.time_ <= var_94_43 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_45 = arg_91_1:FormatText(StoryNameCfg[471].name)

				arg_91_1.leftNameTxt_.text = var_94_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_46 = arg_91_1:GetWordFromCfg(319581023)
				local var_94_47 = arg_91_1:FormatText(var_94_46.content)

				arg_91_1.text_.text = var_94_47

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_48 = 36
				local var_94_49 = utf8.len(var_94_47)
				local var_94_50 = var_94_48 <= 0 and var_94_44 or var_94_44 * (var_94_49 / var_94_48)

				if var_94_50 > 0 and var_94_44 < var_94_50 then
					arg_91_1.talkMaxDuration = var_94_50

					if var_94_50 + var_94_43 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_50 + var_94_43
					end
				end

				arg_91_1.text_.text = var_94_47
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581023", "story_v_out_319581.awb") ~= 0 then
					local var_94_51 = manager.audio:GetVoiceLength("story_v_out_319581", "319581023", "story_v_out_319581.awb") / 1000

					if var_94_51 + var_94_43 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_51 + var_94_43
					end

					if var_94_46.prefab_name ~= "" and arg_91_1.actors_[var_94_46.prefab_name] ~= nil then
						local var_94_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_46.prefab_name].transform, "story_v_out_319581", "319581023", "story_v_out_319581.awb")

						arg_91_1:RecordAudio("319581023", var_94_52)
						arg_91_1:RecordAudio("319581023", var_94_52)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_319581", "319581023", "story_v_out_319581.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_319581", "319581023", "story_v_out_319581.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_53 = math.max(var_94_44, arg_91_1.talkMaxDuration)

			if var_94_43 <= arg_91_1.time_ and arg_91_1.time_ < var_94_43 + var_94_53 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_43) / var_94_53

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_43 + var_94_53 and arg_91_1.time_ < var_94_43 + var_94_53 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end
	end,
	Play319581024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319581024
		arg_95_1.duration_ = 11.733

		local var_95_0 = {
			zh = 7.2,
			ja = 11.733
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319581025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.125

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[471].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(319581024)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 45
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581024", "story_v_out_319581.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_319581", "319581024", "story_v_out_319581.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_319581", "319581024", "story_v_out_319581.awb")

						arg_95_1:RecordAudio("319581024", var_98_9)
						arg_95_1:RecordAudio("319581024", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_319581", "319581024", "story_v_out_319581.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_319581", "319581024", "story_v_out_319581.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end
	end,
	Play319581025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319581025
		arg_99_1.duration_ = 5.1

		local var_99_0 = {
			zh = 1.999999999999,
			ja = 5.1
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319581026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10079ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10079ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10079ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["4040ui_story"].transform
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.var_.moveOldPos4040ui_story = var_102_9.localPosition
			end

			local var_102_11 = 0.001

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11
				local var_102_13 = Vector3.New(0.7, -1.55, -5.5)

				var_102_9.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos4040ui_story, var_102_13, var_102_12)

				local var_102_14 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_14.x, var_102_14.y, var_102_14.z)

				local var_102_15 = var_102_9.localEulerAngles

				var_102_15.z = 0
				var_102_15.x = 0
				var_102_9.localEulerAngles = var_102_15
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 then
				var_102_9.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_102_16 = manager.ui.mainCamera.transform.position - var_102_9.position

				var_102_9.forward = Vector3.New(var_102_16.x, var_102_16.y, var_102_16.z)

				local var_102_17 = var_102_9.localEulerAngles

				var_102_17.z = 0
				var_102_17.x = 0
				var_102_9.localEulerAngles = var_102_17
			end

			local var_102_18 = arg_99_1.actors_["10079ui_story"]
			local var_102_19 = 0

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 and arg_99_1.var_.characterEffect10079ui_story == nil then
				arg_99_1.var_.characterEffect10079ui_story = var_102_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_20 = 0.200000002980232

			if var_102_19 <= arg_99_1.time_ and arg_99_1.time_ < var_102_19 + var_102_20 then
				local var_102_21 = (arg_99_1.time_ - var_102_19) / var_102_20

				if arg_99_1.var_.characterEffect10079ui_story then
					local var_102_22 = Mathf.Lerp(0, 0.5, var_102_21)

					arg_99_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10079ui_story.fillRatio = var_102_22
				end
			end

			if arg_99_1.time_ >= var_102_19 + var_102_20 and arg_99_1.time_ < var_102_19 + var_102_20 + arg_102_0 and arg_99_1.var_.characterEffect10079ui_story then
				local var_102_23 = 0.5

				arg_99_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10079ui_story.fillRatio = var_102_23
			end

			local var_102_24 = 0

			if var_102_24 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 then
				arg_99_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_102_25 = 0

			if var_102_25 < arg_99_1.time_ and arg_99_1.time_ <= var_102_25 + arg_102_0 then
				arg_99_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_26 = arg_99_1.actors_["1095ui_story"].transform
			local var_102_27 = 0

			if var_102_27 < arg_99_1.time_ and arg_99_1.time_ <= var_102_27 + arg_102_0 then
				arg_99_1.var_.moveOldPos1095ui_story = var_102_26.localPosition
			end

			local var_102_28 = 0.001

			if var_102_27 <= arg_99_1.time_ and arg_99_1.time_ < var_102_27 + var_102_28 then
				local var_102_29 = (arg_99_1.time_ - var_102_27) / var_102_28
				local var_102_30 = Vector3.New(0, 100, 0)

				var_102_26.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1095ui_story, var_102_30, var_102_29)

				local var_102_31 = manager.ui.mainCamera.transform.position - var_102_26.position

				var_102_26.forward = Vector3.New(var_102_31.x, var_102_31.y, var_102_31.z)

				local var_102_32 = var_102_26.localEulerAngles

				var_102_32.z = 0
				var_102_32.x = 0
				var_102_26.localEulerAngles = var_102_32
			end

			if arg_99_1.time_ >= var_102_27 + var_102_28 and arg_99_1.time_ < var_102_27 + var_102_28 + arg_102_0 then
				var_102_26.localPosition = Vector3.New(0, 100, 0)

				local var_102_33 = manager.ui.mainCamera.transform.position - var_102_26.position

				var_102_26.forward = Vector3.New(var_102_33.x, var_102_33.y, var_102_33.z)

				local var_102_34 = var_102_26.localEulerAngles

				var_102_34.z = 0
				var_102_34.x = 0
				var_102_26.localEulerAngles = var_102_34
			end

			local var_102_35 = arg_99_1.actors_["1095ui_story"]
			local var_102_36 = 0

			if var_102_36 < arg_99_1.time_ and arg_99_1.time_ <= var_102_36 + arg_102_0 and arg_99_1.var_.characterEffect1095ui_story == nil then
				arg_99_1.var_.characterEffect1095ui_story = var_102_35:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_37 = 0.200000002980232

			if var_102_36 <= arg_99_1.time_ and arg_99_1.time_ < var_102_36 + var_102_37 then
				local var_102_38 = (arg_99_1.time_ - var_102_36) / var_102_37

				if arg_99_1.var_.characterEffect1095ui_story then
					local var_102_39 = Mathf.Lerp(0, 0.5, var_102_38)

					arg_99_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1095ui_story.fillRatio = var_102_39
				end
			end

			if arg_99_1.time_ >= var_102_36 + var_102_37 and arg_99_1.time_ < var_102_36 + var_102_37 + arg_102_0 and arg_99_1.var_.characterEffect1095ui_story then
				local var_102_40 = 0.5

				arg_99_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1095ui_story.fillRatio = var_102_40
			end

			local var_102_41 = arg_99_1.actors_["4040ui_story"]
			local var_102_42 = 0

			if var_102_42 < arg_99_1.time_ and arg_99_1.time_ <= var_102_42 + arg_102_0 and arg_99_1.var_.characterEffect4040ui_story == nil then
				arg_99_1.var_.characterEffect4040ui_story = var_102_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_43 = 0.200000002980232

			if var_102_42 <= arg_99_1.time_ and arg_99_1.time_ < var_102_42 + var_102_43 then
				local var_102_44 = (arg_99_1.time_ - var_102_42) / var_102_43

				if arg_99_1.var_.characterEffect4040ui_story then
					arg_99_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_42 + var_102_43 and arg_99_1.time_ < var_102_42 + var_102_43 + arg_102_0 and arg_99_1.var_.characterEffect4040ui_story then
				arg_99_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_102_45 = 0

			if var_102_45 < arg_99_1.time_ and arg_99_1.time_ <= var_102_45 + arg_102_0 then
				arg_99_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_102_46 = 0

			if var_102_46 < arg_99_1.time_ and arg_99_1.time_ <= var_102_46 + arg_102_0 then
				arg_99_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_47 = 0
			local var_102_48 = 0.175

			if var_102_47 < arg_99_1.time_ and arg_99_1.time_ <= var_102_47 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_49 = arg_99_1:FormatText(StoryNameCfg[668].name)

				arg_99_1.leftNameTxt_.text = var_102_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_50 = arg_99_1:GetWordFromCfg(319581025)
				local var_102_51 = arg_99_1:FormatText(var_102_50.content)

				arg_99_1.text_.text = var_102_51

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_52 = 7
				local var_102_53 = utf8.len(var_102_51)
				local var_102_54 = var_102_52 <= 0 and var_102_48 or var_102_48 * (var_102_53 / var_102_52)

				if var_102_54 > 0 and var_102_48 < var_102_54 then
					arg_99_1.talkMaxDuration = var_102_54

					if var_102_54 + var_102_47 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_54 + var_102_47
					end
				end

				arg_99_1.text_.text = var_102_51
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581025", "story_v_out_319581.awb") ~= 0 then
					local var_102_55 = manager.audio:GetVoiceLength("story_v_out_319581", "319581025", "story_v_out_319581.awb") / 1000

					if var_102_55 + var_102_47 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_55 + var_102_47
					end

					if var_102_50.prefab_name ~= "" and arg_99_1.actors_[var_102_50.prefab_name] ~= nil then
						local var_102_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_50.prefab_name].transform, "story_v_out_319581", "319581025", "story_v_out_319581.awb")

						arg_99_1:RecordAudio("319581025", var_102_56)
						arg_99_1:RecordAudio("319581025", var_102_56)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319581", "319581025", "story_v_out_319581.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319581", "319581025", "story_v_out_319581.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_57 = math.max(var_102_48, arg_99_1.talkMaxDuration)

			if var_102_47 <= arg_99_1.time_ and arg_99_1.time_ < var_102_47 + var_102_57 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_47) / var_102_57

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_47 + var_102_57 and arg_99_1.time_ < var_102_47 + var_102_57 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end
	end,
	Play319581026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319581026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319581027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["4040ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and arg_103_1.var_.characterEffect4040ui_story == nil then
				arg_103_1.var_.characterEffect4040ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect4040ui_story then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_103_1.var_.characterEffect4040ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and arg_103_1.var_.characterEffect4040ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_103_1.var_.characterEffect4040ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.85

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(319581026)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 34
				local var_106_11 = utf8.len(var_106_9)
				local var_106_12 = var_106_10 <= 0 and var_106_7 or var_106_7 * (var_106_11 / var_106_10)

				if var_106_12 > 0 and var_106_7 < var_106_12 then
					arg_103_1.talkMaxDuration = var_106_12

					if var_106_12 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_13 and arg_103_1.time_ < var_106_6 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end
	end,
	Play319581027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319581027
		arg_107_1.duration_ = 3.4

		local var_107_0 = {
			zh = 2.066,
			ja = 3.4
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319581028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10079ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10079ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10079ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["10079ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect10079ui_story then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_15 = 0
			local var_110_16 = 0.225

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(319581027)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 9
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581027", "story_v_out_319581.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_319581", "319581027", "story_v_out_319581.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_319581", "319581027", "story_v_out_319581.awb")

						arg_107_1:RecordAudio("319581027", var_110_24)
						arg_107_1:RecordAudio("319581027", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319581", "319581027", "story_v_out_319581.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319581", "319581027", "story_v_out_319581.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end
	end,
	Play319581028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319581028
		arg_111_1.duration_ = 7.1

		local var_111_0 = {
			zh = 7.1,
			ja = 4.7
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
				arg_111_0:Play319581029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10079ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and arg_111_1.var_.characterEffect10079ui_story == nil then
				arg_111_1.var_.characterEffect10079ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10079ui_story then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10079ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and arg_111_1.var_.characterEffect10079ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10079ui_story.fillRatio = var_114_5
			end

			local var_114_6 = arg_111_1.actors_["4040ui_story"]
			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 and arg_111_1.var_.characterEffect4040ui_story == nil then
				arg_111_1.var_.characterEffect4040ui_story = var_114_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_8 = 0.200000002980232

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / var_114_8

				if arg_111_1.var_.characterEffect4040ui_story then
					arg_111_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 and arg_111_1.var_.characterEffect4040ui_story then
				arg_111_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_114_10 = 0
			local var_114_11 = 0.7

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_12 = arg_111_1:FormatText(StoryNameCfg[668].name)

				arg_111_1.leftNameTxt_.text = var_114_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_13 = arg_111_1:GetWordFromCfg(319581028)
				local var_114_14 = arg_111_1:FormatText(var_114_13.content)

				arg_111_1.text_.text = var_114_14

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 28
				local var_114_16 = utf8.len(var_114_14)
				local var_114_17 = var_114_15 <= 0 and var_114_11 or var_114_11 * (var_114_16 / var_114_15)

				if var_114_17 > 0 and var_114_11 < var_114_17 then
					arg_111_1.talkMaxDuration = var_114_17

					if var_114_17 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_14
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581028", "story_v_out_319581.awb") ~= 0 then
					local var_114_18 = manager.audio:GetVoiceLength("story_v_out_319581", "319581028", "story_v_out_319581.awb") / 1000

					if var_114_18 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_10
					end

					if var_114_13.prefab_name ~= "" and arg_111_1.actors_[var_114_13.prefab_name] ~= nil then
						local var_114_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_13.prefab_name].transform, "story_v_out_319581", "319581028", "story_v_out_319581.awb")

						arg_111_1:RecordAudio("319581028", var_114_19)
						arg_111_1:RecordAudio("319581028", var_114_19)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319581", "319581028", "story_v_out_319581.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319581", "319581028", "story_v_out_319581.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_20 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_20 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_20

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_20 and arg_111_1.time_ < var_114_10 + var_114_20 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end
	end,
	Play319581029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319581029
		arg_115_1.duration_ = 4.466

		local var_115_0 = {
			zh = 4.466,
			ja = 4.1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319581030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["4040ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos4040ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0.7, -1.55, -5.5)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4040ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["4040ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and arg_115_1.var_.characterEffect4040ui_story == nil then
				arg_115_1.var_.characterEffect4040ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect4040ui_story then
					arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and arg_115_1.var_.characterEffect4040ui_story then
				arg_115_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_15 = 0
			local var_118_16 = 0.375

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[668].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(319581029)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 15
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319581", "319581029", "story_v_out_319581.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_319581", "319581029", "story_v_out_319581.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_319581", "319581029", "story_v_out_319581.awb")

						arg_115_1:RecordAudio("319581029", var_118_24)
						arg_115_1:RecordAudio("319581029", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319581", "319581029", "story_v_out_319581.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319581", "319581029", "story_v_out_319581.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end
	end,
	Play319581030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319581030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play319581031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["4040ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect4040ui_story then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and arg_119_1.var_.characterEffect4040ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 1

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				local var_122_8 = "play"
				local var_122_9 = "effect"

				arg_119_1:AudioAction(var_122_8, var_122_9, "se_story_130", "se_story_130__launch", "")
			end

			local var_122_10 = arg_119_1.actors_["10079ui_story"].transform
			local var_122_11 = 0

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.var_.moveOldPos10079ui_story = var_122_10.localPosition
			end

			local var_122_12 = 0.001

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_12 then
				local var_122_13 = (arg_119_1.time_ - var_122_11) / var_122_12
				local var_122_14 = Vector3.New(0, -0.95, -6.05)

				var_122_10.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10079ui_story, var_122_14, var_122_13)

				local var_122_15 = manager.ui.mainCamera.transform.position - var_122_10.position

				var_122_10.forward = Vector3.New(var_122_15.x, var_122_15.y, var_122_15.z)

				local var_122_16 = var_122_10.localEulerAngles

				var_122_16.z = 0
				var_122_16.x = 0
				var_122_10.localEulerAngles = var_122_16
			end

			if arg_119_1.time_ >= var_122_11 + var_122_12 and arg_119_1.time_ < var_122_11 + var_122_12 + arg_122_0 then
				var_122_10.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_122_17 = manager.ui.mainCamera.transform.position - var_122_10.position

				var_122_10.forward = Vector3.New(var_122_17.x, var_122_17.y, var_122_17.z)

				local var_122_18 = var_122_10.localEulerAngles

				var_122_18.z = 0
				var_122_18.x = 0
				var_122_10.localEulerAngles = var_122_18
			end

			local var_122_19 = arg_119_1.actors_["4040ui_story"].transform
			local var_122_20 = 0

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.var_.moveOldPos4040ui_story = var_122_19.localPosition
			end

			local var_122_21 = 0.001

			if var_122_20 <= arg_119_1.time_ and arg_119_1.time_ < var_122_20 + var_122_21 then
				local var_122_22 = (arg_119_1.time_ - var_122_20) / var_122_21
				local var_122_23 = Vector3.New(0, 100, 0)

				var_122_19.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos4040ui_story, var_122_23, var_122_22)

				local var_122_24 = manager.ui.mainCamera.transform.position - var_122_19.position

				var_122_19.forward = Vector3.New(var_122_24.x, var_122_24.y, var_122_24.z)

				local var_122_25 = var_122_19.localEulerAngles

				var_122_25.z = 0
				var_122_25.x = 0
				var_122_19.localEulerAngles = var_122_25
			end

			if arg_119_1.time_ >= var_122_20 + var_122_21 and arg_119_1.time_ < var_122_20 + var_122_21 + arg_122_0 then
				var_122_19.localPosition = Vector3.New(0, 100, 0)

				local var_122_26 = manager.ui.mainCamera.transform.position - var_122_19.position

				var_122_19.forward = Vector3.New(var_122_26.x, var_122_26.y, var_122_26.z)

				local var_122_27 = var_122_19.localEulerAngles

				var_122_27.z = 0
				var_122_27.x = 0
				var_122_19.localEulerAngles = var_122_27
			end

			local var_122_28 = arg_119_1.actors_["4040ui_story"]
			local var_122_29 = 0

			if var_122_29 < arg_119_1.time_ and arg_119_1.time_ <= var_122_29 + arg_122_0 and arg_119_1.var_.characterEffect4040ui_story == nil then
				arg_119_1.var_.characterEffect4040ui_story = var_122_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_30 = 0.200000002980232

			if var_122_29 <= arg_119_1.time_ and arg_119_1.time_ < var_122_29 + var_122_30 then
				local var_122_31 = (arg_119_1.time_ - var_122_29) / var_122_30

				if arg_119_1.var_.characterEffect4040ui_story then
					local var_122_32 = Mathf.Lerp(0, 0.5, var_122_31)

					arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_32
				end
			end

			if arg_119_1.time_ >= var_122_29 + var_122_30 and arg_119_1.time_ < var_122_29 + var_122_30 + arg_122_0 and arg_119_1.var_.characterEffect4040ui_story then
				local var_122_33 = 0.5

				arg_119_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_119_1.var_.characterEffect4040ui_story.fillRatio = var_122_33
			end

			local var_122_34 = 0
			local var_122_35 = 1.3

			if var_122_34 < arg_119_1.time_ and arg_119_1.time_ <= var_122_34 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_36 = arg_119_1:GetWordFromCfg(319581030)
				local var_122_37 = arg_119_1:FormatText(var_122_36.content)

				arg_119_1.text_.text = var_122_37

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_38 = 52
				local var_122_39 = utf8.len(var_122_37)
				local var_122_40 = var_122_38 <= 0 and var_122_35 or var_122_35 * (var_122_39 / var_122_38)

				if var_122_40 > 0 and var_122_35 < var_122_40 then
					arg_119_1.talkMaxDuration = var_122_40

					if var_122_40 + var_122_34 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_40 + var_122_34
					end
				end

				arg_119_1.text_.text = var_122_37
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_41 = math.max(var_122_35, arg_119_1.talkMaxDuration)

			if var_122_34 <= arg_119_1.time_ and arg_119_1.time_ < var_122_34 + var_122_41 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_34) / var_122_41

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_34 + var_122_41 and arg_119_1.time_ < var_122_34 + var_122_41 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end
	end,
	Play319581031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319581031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.175

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

				local var_126_2 = arg_123_1:GetWordFromCfg(319581031)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 47
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/D11"
	},
	voices = {
		"story_v_out_319581.awb"
	}
}
