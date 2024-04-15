return {
	Play102092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102092001
		arg_1_1.duration_ = 3.799999952315

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = 0
			local var_4_5 = 1

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_6 = "play"
				local var_4_7 = "effect"

				arg_1_1:AudioAction(var_4_6, var_4_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_8 = 0
			local var_4_9 = 1

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_10 = "play"
				local var_4_11 = "effect"

				arg_1_1:AudioAction(var_4_10, var_4_11, "se_story", "se_story_fight_metal", "")
			end

			local var_4_12 = "1084ui_story"

			if arg_1_1.actors_[var_4_12] == nil then
				local var_4_13 = Object.Instantiate(Asset.Load("Char/" .. var_4_12), arg_1_1.stage_.transform)

				var_4_13.name = var_4_12
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_12] = var_4_13

				local var_4_14 = var_4_13:GetComponentInChildren(typeof(CharacterEffect))

				var_4_14.enabled = true

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_13, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_14.transform, false)

				arg_1_1.var_[var_4_12 .. "Animator"] = var_4_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_16 = arg_1_1.actors_["1084ui_story"]
			local var_4_17 = 2

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.1

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / var_4_18

				if arg_1_1.var_.characterEffect1084ui_story then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_20 = "B02c"

			if arg_1_1.bgs_[var_4_20] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = arg_1_1.bgs_.B02c
			local var_4_23 = 0

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				local var_4_24 = var_4_22:GetComponent("SpriteRenderer")

				if var_4_24 then
					var_4_24.material = arg_1_1.transpaintGo_:GetComponent("SpriteRenderer").material

					local var_4_25 = var_4_24.material
					local var_4_26 = var_4_25:GetColor("_Color")

					arg_1_1.var_.alphaOldValueB02c = var_4_26.a
					arg_1_1.var_.alphaMatValueB02c = var_4_25
				end

				arg_1_1.var_.alphaOldValueB02c = 0
			end

			local var_4_27 = 1.5

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_23) / var_4_27
				local var_4_29 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02c, 1, var_4_28)

				if arg_1_1.var_.alphaMatValueB02c then
					local var_4_30 = arg_1_1.var_.alphaMatValueB02c
					local var_4_31 = var_4_30:GetColor("_Color")

					var_4_31.a = var_4_29

					var_4_30:SetColor("_Color", var_4_31)
				end
			end

			if arg_1_1.time_ >= var_4_23 + var_4_27 and arg_1_1.time_ < var_4_23 + var_4_27 + arg_4_0 and arg_1_1.var_.alphaMatValueB02c then
				local var_4_32 = arg_1_1.var_.alphaMatValueB02c
				local var_4_33 = var_4_32:GetColor("_Color")

				var_4_33.a = 1

				var_4_32:SetColor("_Color", var_4_33)
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_35 = manager.ui.mainCamera.transform.localPosition
				local var_4_36 = Vector3.New(0, 0, 10) + Vector3.New(var_4_35.x, var_4_35.y, 0)
				local var_4_37 = arg_1_1.bgs_.B02c

				var_4_37.transform.localPosition = var_4_36
				var_4_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_38 = var_4_37:GetComponent("SpriteRenderer")

				if var_4_38 and var_4_38.sprite then
					local var_4_39 = (var_4_37.transform.localPosition - var_4_35).z
					local var_4_40 = manager.ui.mainCameraCom_
					local var_4_41 = 2 * var_4_39 * Mathf.Tan(var_4_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_42 = var_4_41 * var_4_40.aspect
					local var_4_43 = var_4_38.sprite.bounds.size.x
					local var_4_44 = var_4_38.sprite.bounds.size.y
					local var_4_45 = var_4_42 / var_4_43
					local var_4_46 = var_4_41 / var_4_44
					local var_4_47 = var_4_46 < var_4_45 and var_4_45 or var_4_46

					var_4_37.transform.localScale = Vector3.New(var_4_47, var_4_47, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_48 = 1.79999995231628

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action11_1")
			end

			local var_4_49 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_50 = 1.8

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_49.localPosition

				local var_4_51 = "1084ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_51 .. "Animator"].transform, true)
			end

			local var_4_52 = 0.001

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_52 then
				local var_4_53 = (arg_1_1.time_ - var_4_50) / var_4_52
				local var_4_54 = Vector3.New(0, -0.97, -6)

				var_4_49.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_54, var_4_53)

				local var_4_55 = manager.ui.mainCamera.transform.position - var_4_49.position

				var_4_49.forward = Vector3.New(var_4_55.x, var_4_55.y, var_4_55.z)

				local var_4_56 = var_4_49.localEulerAngles

				var_4_56.z = 0
				var_4_56.x = 0
				var_4_49.localEulerAngles = var_4_56
			end

			if arg_1_1.time_ >= var_4_50 + var_4_52 and arg_1_1.time_ < var_4_50 + var_4_52 + arg_4_0 then
				var_4_49.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_57 = manager.ui.mainCamera.transform.position - var_4_49.position

				var_4_49.forward = Vector3.New(var_4_57.x, var_4_57.y, var_4_57.z)

				local var_4_58 = var_4_49.localEulerAngles

				var_4_58.z = 0
				var_4_58.x = 0
				var_4_49.localEulerAngles = var_4_58
			end

			local var_4_59 = 0

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_60 = 2

			if arg_1_1.time_ >= var_4_59 + var_4_60 and arg_1_1.time_ < var_4_59 + var_4_60 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_61 = 0

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_62 = 2
			local var_4_63 = 0.125

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_64 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_64:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_65 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_66 = arg_1_1:GetWordFromCfg(102092001)
				local var_4_67 = arg_1_1:FormatText(var_4_66.content)

				arg_1_1.text_.text = var_4_67

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_68 = 5
				local var_4_69 = utf8.len(var_4_67)
				local var_4_70 = var_4_68 <= 0 and var_4_63 or var_4_63 * (var_4_69 / var_4_68)

				if var_4_70 > 0 and var_4_63 < var_4_70 then
					arg_1_1.talkMaxDuration = var_4_70
					var_4_62 = var_4_62 + 0.3

					if var_4_70 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_62
					end
				end

				arg_1_1.text_.text = var_4_67
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092001", "story_v_out_102092.awb") ~= 0 then
					local var_4_71 = manager.audio:GetVoiceLength("story_v_out_102092", "102092001", "story_v_out_102092.awb") / 1000

					if var_4_71 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_71 + var_4_62
					end

					if var_4_66.prefab_name ~= "" and arg_1_1.actors_[var_4_66.prefab_name] ~= nil then
						local var_4_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_66.prefab_name].transform, "story_v_out_102092", "102092001", "story_v_out_102092.awb")

						arg_1_1:RecordAudio("102092001", var_4_72)
						arg_1_1:RecordAudio("102092001", var_4_72)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102092", "102092001", "story_v_out_102092.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102092", "102092001", "story_v_out_102092.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_73 = var_4_62 + 0.3
			local var_4_74 = math.max(var_4_63, arg_1_1.talkMaxDuration)

			if var_4_73 <= arg_1_1.time_ and arg_1_1.time_ < var_4_73 + var_4_74 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_73) / var_4_74

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_73 + var_4_74 and arg_1_1.time_ < var_4_73 + var_4_74 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play102092002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 102092002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play102092003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1084ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.1

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect1084ui_story then
					local var_10_4 = Mathf.Lerp(0, 0.5, var_10_3)

					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = var_10_4
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and arg_7_1.var_.characterEffect1084ui_story then
				local var_10_5 = 0.5

				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = var_10_5
			end

			local var_10_6 = 0
			local var_10_7 = 1.15

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

				local var_10_8 = arg_7_1:GetWordFromCfg(102092002)
				local var_10_9 = arg_7_1:FormatText(var_10_8.content)

				arg_7_1.text_.text = var_10_9

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 45
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
	Play102092003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 102092003
		arg_11_1.duration_ = 6.733

		local var_11_0 = {
			ja = 6.733,
			ko = 5.4,
			zh = 3.9,
			en = 4.933
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
				arg_11_0:Play102092004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "play"
				local var_14_3 = "music"

				arg_11_1:AudioAction(var_14_2, var_14_3, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")
			end

			local var_14_4 = "10002_tpose"

			if arg_11_1.actors_[var_14_4] == nil then
				local var_14_5 = Object.Instantiate(Asset.Load("Char/" .. var_14_4), arg_11_1.stage_.transform)

				var_14_5.name = var_14_4
				var_14_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_4] = var_14_5

				local var_14_6 = var_14_5:GetComponentInChildren(typeof(CharacterEffect))

				var_14_6.enabled = true

				local var_14_7 = GameObjectTools.GetOrAddComponent(var_14_5, typeof(DynamicBoneHelper))

				if var_14_7 then
					var_14_7:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_6.transform, false)

				arg_11_1.var_[var_14_4 .. "Animator"] = var_14_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_4 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_4 .. "LipSync"] = var_14_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_8 = arg_11_1.actors_["10002_tpose"]
			local var_14_9 = 0

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 and arg_11_1.var_.characterEffect10002_tpose == nil then
				arg_11_1.var_.characterEffect10002_tpose = var_14_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_10 = 0.1

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_10 then
				local var_14_11 = (arg_11_1.time_ - var_14_9) / var_14_10

				if arg_11_1.var_.characterEffect10002_tpose then
					arg_11_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_9 + var_14_10 and arg_11_1.time_ < var_14_9 + var_14_10 + arg_14_0 and arg_11_1.var_.characterEffect10002_tpose then
				arg_11_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_14_12 = arg_11_1.actors_["1084ui_story"].transform
			local var_14_13 = 0

			if var_14_13 < arg_11_1.time_ and arg_11_1.time_ <= var_14_13 + arg_14_0 then
				arg_11_1.var_.moveOldPos1084ui_story = var_14_12.localPosition
			end

			local var_14_14 = 0.001

			if var_14_13 <= arg_11_1.time_ and arg_11_1.time_ < var_14_13 + var_14_14 then
				local var_14_15 = (arg_11_1.time_ - var_14_13) / var_14_14
				local var_14_16 = Vector3.New(0, 100, 0)

				var_14_12.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1084ui_story, var_14_16, var_14_15)

				local var_14_17 = manager.ui.mainCamera.transform.position - var_14_12.position

				var_14_12.forward = Vector3.New(var_14_17.x, var_14_17.y, var_14_17.z)

				local var_14_18 = var_14_12.localEulerAngles

				var_14_18.z = 0
				var_14_18.x = 0
				var_14_12.localEulerAngles = var_14_18
			end

			if arg_11_1.time_ >= var_14_13 + var_14_14 and arg_11_1.time_ < var_14_13 + var_14_14 + arg_14_0 then
				var_14_12.localPosition = Vector3.New(0, 100, 0)

				local var_14_19 = manager.ui.mainCamera.transform.position - var_14_12.position

				var_14_12.forward = Vector3.New(var_14_19.x, var_14_19.y, var_14_19.z)

				local var_14_20 = var_14_12.localEulerAngles

				var_14_20.z = 0
				var_14_20.x = 0
				var_14_12.localEulerAngles = var_14_20
			end

			local var_14_21 = 0

			if var_14_21 < arg_11_1.time_ and arg_11_1.time_ <= var_14_21 + arg_14_0 then
				arg_11_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action11_2")
			end

			local var_14_22 = arg_11_1.actors_["10002_tpose"].transform
			local var_14_23 = 0

			if var_14_23 < arg_11_1.time_ and arg_11_1.time_ <= var_14_23 + arg_14_0 then
				arg_11_1.var_.moveOldPos10002_tpose = var_14_22.localPosition
			end

			local var_14_24 = 0.001

			if var_14_23 <= arg_11_1.time_ and arg_11_1.time_ < var_14_23 + var_14_24 then
				local var_14_25 = (arg_11_1.time_ - var_14_23) / var_14_24
				local var_14_26 = Vector3.New(0, -1.2, -5.8)

				var_14_22.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos10002_tpose, var_14_26, var_14_25)

				local var_14_27 = manager.ui.mainCamera.transform.position - var_14_22.position

				var_14_22.forward = Vector3.New(var_14_27.x, var_14_27.y, var_14_27.z)

				local var_14_28 = var_14_22.localEulerAngles

				var_14_28.z = 0
				var_14_28.x = 0
				var_14_22.localEulerAngles = var_14_28
			end

			if arg_11_1.time_ >= var_14_23 + var_14_24 and arg_11_1.time_ < var_14_23 + var_14_24 + arg_14_0 then
				var_14_22.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_14_29 = manager.ui.mainCamera.transform.position - var_14_22.position

				var_14_22.forward = Vector3.New(var_14_29.x, var_14_29.y, var_14_29.z)

				local var_14_30 = var_14_22.localEulerAngles

				var_14_30.z = 0
				var_14_30.x = 0
				var_14_22.localEulerAngles = var_14_30
			end

			local var_14_31 = 0

			if var_14_31 < arg_11_1.time_ and arg_11_1.time_ <= var_14_31 + arg_14_0 then
				arg_11_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_14_32 = 0

			if var_14_32 < arg_11_1.time_ and arg_11_1.time_ <= var_14_32 + arg_14_0 then
				arg_11_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_14_33 = 0
			local var_14_34 = 0.425

			if var_14_33 < arg_11_1.time_ and arg_11_1.time_ <= var_14_33 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_35 = arg_11_1:FormatText(StoryNameCfg[39].name)

				arg_11_1.leftNameTxt_.text = var_14_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_36 = arg_11_1:GetWordFromCfg(102092003)
				local var_14_37 = arg_11_1:FormatText(var_14_36.content)

				arg_11_1.text_.text = var_14_37

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_38 = 17
				local var_14_39 = utf8.len(var_14_37)
				local var_14_40 = var_14_38 <= 0 and var_14_34 or var_14_34 * (var_14_39 / var_14_38)

				if var_14_40 > 0 and var_14_34 < var_14_40 then
					arg_11_1.talkMaxDuration = var_14_40

					if var_14_40 + var_14_33 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_40 + var_14_33
					end
				end

				arg_11_1.text_.text = var_14_37
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092003", "story_v_out_102092.awb") ~= 0 then
					local var_14_41 = manager.audio:GetVoiceLength("story_v_out_102092", "102092003", "story_v_out_102092.awb") / 1000

					if var_14_41 + var_14_33 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_41 + var_14_33
					end

					if var_14_36.prefab_name ~= "" and arg_11_1.actors_[var_14_36.prefab_name] ~= nil then
						local var_14_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_36.prefab_name].transform, "story_v_out_102092", "102092003", "story_v_out_102092.awb")

						arg_11_1:RecordAudio("102092003", var_14_42)
						arg_11_1:RecordAudio("102092003", var_14_42)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_102092", "102092003", "story_v_out_102092.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_102092", "102092003", "story_v_out_102092.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_43 = math.max(var_14_34, arg_11_1.talkMaxDuration)

			if var_14_33 <= arg_11_1.time_ and arg_11_1.time_ < var_14_33 + var_14_43 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_33) / var_14_43

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_33 + var_14_43 and arg_11_1.time_ < var_14_33 + var_14_43 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play102092004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 102092004
		arg_15_1.duration_ = 7.533

		local var_15_0 = {
			ja = 7.166,
			ko = 7.533,
			zh = 5.866,
			en = 5.833
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
				arg_15_0:Play102092005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1084ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.1

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect1084ui_story then
					arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and arg_15_1.var_.characterEffect1084ui_story then
				arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_18_4 = arg_15_1.actors_["10002_tpose"]
			local var_18_5 = 0

			if var_18_5 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 and arg_15_1.var_.characterEffect10002_tpose == nil then
				arg_15_1.var_.characterEffect10002_tpose = var_18_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.1

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_6 then
				local var_18_7 = (arg_15_1.time_ - var_18_5) / var_18_6

				if arg_15_1.var_.characterEffect10002_tpose then
					local var_18_8 = Mathf.Lerp(0, 0.5, var_18_7)

					arg_15_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_15_1.var_.characterEffect10002_tpose.fillRatio = var_18_8
				end
			end

			if arg_15_1.time_ >= var_18_5 + var_18_6 and arg_15_1.time_ < var_18_5 + var_18_6 + arg_18_0 and arg_15_1.var_.characterEffect10002_tpose then
				local var_18_9 = 0.5

				arg_15_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_15_1.var_.characterEffect10002_tpose.fillRatio = var_18_9
			end

			local var_18_10 = arg_15_1.actors_["1084ui_story"].transform
			local var_18_11 = 0

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = var_18_10.localPosition

				local var_18_12 = "1084ui_story"

				arg_15_1:ShowWeapon(arg_15_1.var_[var_18_12 .. "Animator"].transform, false)
			end

			local var_18_13 = 0.001

			if var_18_11 <= arg_15_1.time_ and arg_15_1.time_ < var_18_11 + var_18_13 then
				local var_18_14 = (arg_15_1.time_ - var_18_11) / var_18_13
				local var_18_15 = Vector3.New(-0.7, -0.97, -6)

				var_18_10.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, var_18_15, var_18_14)

				local var_18_16 = manager.ui.mainCamera.transform.position - var_18_10.position

				var_18_10.forward = Vector3.New(var_18_16.x, var_18_16.y, var_18_16.z)

				local var_18_17 = var_18_10.localEulerAngles

				var_18_17.z = 0
				var_18_17.x = 0
				var_18_10.localEulerAngles = var_18_17
			end

			if arg_15_1.time_ >= var_18_11 + var_18_13 and arg_15_1.time_ < var_18_11 + var_18_13 + arg_18_0 then
				var_18_10.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_18_18 = manager.ui.mainCamera.transform.position - var_18_10.position

				var_18_10.forward = Vector3.New(var_18_18.x, var_18_18.y, var_18_18.z)

				local var_18_19 = var_18_10.localEulerAngles

				var_18_19.z = 0
				var_18_19.x = 0
				var_18_10.localEulerAngles = var_18_19
			end

			local var_18_20 = 0

			if var_18_20 < arg_15_1.time_ and arg_15_1.time_ <= var_18_20 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action12_1")
			end

			local var_18_21 = arg_15_1.actors_["10002_tpose"].transform
			local var_18_22 = 0.033

			if var_18_22 < arg_15_1.time_ and arg_15_1.time_ <= var_18_22 + arg_18_0 then
				arg_15_1.var_.moveOldPos10002_tpose = var_18_21.localPosition
			end

			local var_18_23 = 0.5

			if var_18_22 <= arg_15_1.time_ and arg_15_1.time_ < var_18_22 + var_18_23 then
				local var_18_24 = (arg_15_1.time_ - var_18_22) / var_18_23
				local var_18_25 = Vector3.New(0.7, -1.2, -5.8)

				var_18_21.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10002_tpose, var_18_25, var_18_24)

				local var_18_26 = manager.ui.mainCamera.transform.position - var_18_21.position

				var_18_21.forward = Vector3.New(var_18_26.x, var_18_26.y, var_18_26.z)

				local var_18_27 = var_18_21.localEulerAngles

				var_18_27.z = 0
				var_18_27.x = 0
				var_18_21.localEulerAngles = var_18_27
			end

			if arg_15_1.time_ >= var_18_22 + var_18_23 and arg_15_1.time_ < var_18_22 + var_18_23 + arg_18_0 then
				var_18_21.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_18_28 = manager.ui.mainCamera.transform.position - var_18_21.position

				var_18_21.forward = Vector3.New(var_18_28.x, var_18_28.y, var_18_28.z)

				local var_18_29 = var_18_21.localEulerAngles

				var_18_29.z = 0
				var_18_29.x = 0
				var_18_21.localEulerAngles = var_18_29
			end

			local var_18_30 = arg_15_1.actors_["10002_tpose"].transform
			local var_18_31 = 0

			if var_18_31 < arg_15_1.time_ and arg_15_1.time_ <= var_18_31 + arg_18_0 then
				arg_15_1.var_.moveOldPos10002_tpose = var_18_30.localPosition
			end

			local var_18_32 = 0.001

			if var_18_31 <= arg_15_1.time_ and arg_15_1.time_ < var_18_31 + var_18_32 then
				local var_18_33 = (arg_15_1.time_ - var_18_31) / var_18_32
				local var_18_34 = Vector3.New(0, -1.2, -5.8)

				var_18_30.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10002_tpose, var_18_34, var_18_33)

				local var_18_35 = manager.ui.mainCamera.transform.position - var_18_30.position

				var_18_30.forward = Vector3.New(var_18_35.x, var_18_35.y, var_18_35.z)

				local var_18_36 = var_18_30.localEulerAngles

				var_18_36.z = 0
				var_18_36.x = 0
				var_18_30.localEulerAngles = var_18_36
			end

			if arg_15_1.time_ >= var_18_31 + var_18_32 and arg_15_1.time_ < var_18_31 + var_18_32 + arg_18_0 then
				var_18_30.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_18_37 = manager.ui.mainCamera.transform.position - var_18_30.position

				var_18_30.forward = Vector3.New(var_18_37.x, var_18_37.y, var_18_37.z)

				local var_18_38 = var_18_30.localEulerAngles

				var_18_38.z = 0
				var_18_38.x = 0
				var_18_30.localEulerAngles = var_18_38
			end

			local var_18_39 = 0

			if var_18_39 < arg_15_1.time_ and arg_15_1.time_ <= var_18_39 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_18_40 = 0
			local var_18_41 = 0.675

			if var_18_40 < arg_15_1.time_ and arg_15_1.time_ <= var_18_40 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_42 = arg_15_1:FormatText(StoryNameCfg[6].name)

				arg_15_1.leftNameTxt_.text = var_18_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_43 = arg_15_1:GetWordFromCfg(102092004)
				local var_18_44 = arg_15_1:FormatText(var_18_43.content)

				arg_15_1.text_.text = var_18_44

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_45 = 27
				local var_18_46 = utf8.len(var_18_44)
				local var_18_47 = var_18_45 <= 0 and var_18_41 or var_18_41 * (var_18_46 / var_18_45)

				if var_18_47 > 0 and var_18_41 < var_18_47 then
					arg_15_1.talkMaxDuration = var_18_47

					if var_18_47 + var_18_40 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_47 + var_18_40
					end
				end

				arg_15_1.text_.text = var_18_44
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092004", "story_v_out_102092.awb") ~= 0 then
					local var_18_48 = manager.audio:GetVoiceLength("story_v_out_102092", "102092004", "story_v_out_102092.awb") / 1000

					if var_18_48 + var_18_40 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_48 + var_18_40
					end

					if var_18_43.prefab_name ~= "" and arg_15_1.actors_[var_18_43.prefab_name] ~= nil then
						local var_18_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_43.prefab_name].transform, "story_v_out_102092", "102092004", "story_v_out_102092.awb")

						arg_15_1:RecordAudio("102092004", var_18_49)
						arg_15_1:RecordAudio("102092004", var_18_49)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_102092", "102092004", "story_v_out_102092.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_102092", "102092004", "story_v_out_102092.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_50 = math.max(var_18_41, arg_15_1.talkMaxDuration)

			if var_18_40 <= arg_15_1.time_ and arg_15_1.time_ < var_18_40 + var_18_50 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_40) / var_18_50

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_40 + var_18_50 and arg_15_1.time_ < var_18_40 + var_18_50 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play102092005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 102092005
		arg_19_1.duration_ = 6.5

		local var_19_0 = {
			ja = 4.166,
			ko = 6.5,
			zh = 4.9,
			en = 4.7
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
				arg_19_0:Play102092006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["10002_tpose"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and arg_19_1.var_.characterEffect10002_tpose == nil then
				arg_19_1.var_.characterEffect10002_tpose = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.1

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect10002_tpose then
					arg_19_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and arg_19_1.var_.characterEffect10002_tpose then
				arg_19_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_22_4 = arg_19_1.actors_["1084ui_story"]
			local var_22_5 = 0

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.1

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_6 then
				local var_22_7 = (arg_19_1.time_ - var_22_5) / var_22_6

				if arg_19_1.var_.characterEffect1084ui_story then
					local var_22_8 = Mathf.Lerp(0, 0.5, var_22_7)

					arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1084ui_story.fillRatio = var_22_8
				end
			end

			if arg_19_1.time_ >= var_22_5 + var_22_6 and arg_19_1.time_ < var_22_5 + var_22_6 + arg_22_0 and arg_19_1.var_.characterEffect1084ui_story then
				local var_22_9 = 0.5

				arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1084ui_story.fillRatio = var_22_9
			end

			local var_22_10 = 0

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_22_11 = 0

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_22_12 = 0
			local var_22_13 = 0.5

			if var_22_12 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_14 = arg_19_1:FormatText(StoryNameCfg[39].name)

				arg_19_1.leftNameTxt_.text = var_22_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_15 = arg_19_1:GetWordFromCfg(102092005)
				local var_22_16 = arg_19_1:FormatText(var_22_15.content)

				arg_19_1.text_.text = var_22_16

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 20
				local var_22_18 = utf8.len(var_22_16)
				local var_22_19 = var_22_17 <= 0 and var_22_13 or var_22_13 * (var_22_18 / var_22_17)

				if var_22_19 > 0 and var_22_13 < var_22_19 then
					arg_19_1.talkMaxDuration = var_22_19

					if var_22_19 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_16
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092005", "story_v_out_102092.awb") ~= 0 then
					local var_22_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092005", "story_v_out_102092.awb") / 1000

					if var_22_20 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_12
					end

					if var_22_15.prefab_name ~= "" and arg_19_1.actors_[var_22_15.prefab_name] ~= nil then
						local var_22_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_15.prefab_name].transform, "story_v_out_102092", "102092005", "story_v_out_102092.awb")

						arg_19_1:RecordAudio("102092005", var_22_21)
						arg_19_1:RecordAudio("102092005", var_22_21)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_102092", "102092005", "story_v_out_102092.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_102092", "102092005", "story_v_out_102092.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_22 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_22 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_12) / var_22_22

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_12 + var_22_22 and arg_19_1.time_ < var_22_12 + var_22_22 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end
	end,
	Play102092006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 102092006
		arg_23_1.duration_ = 15.9

		local var_23_0 = {
			ja = 13.533,
			ko = 15.9,
			zh = 11.433,
			en = 11.5
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
				arg_23_0:Play102092007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1084ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and arg_23_1.var_.characterEffect1084ui_story == nil then
				arg_23_1.var_.characterEffect1084ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.1

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1084ui_story then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and arg_23_1.var_.characterEffect1084ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action424")
			end

			local var_26_7 = 0

			if var_26_7 < arg_23_1.time_ and arg_23_1.time_ <= var_26_7 + arg_26_0 then
				arg_23_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_26_8 = 0
			local var_26_9 = 1.2

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_10 = arg_23_1:FormatText(StoryNameCfg[39].name)

				arg_23_1.leftNameTxt_.text = var_26_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_11 = arg_23_1:GetWordFromCfg(102092006)
				local var_26_12 = arg_23_1:FormatText(var_26_11.content)

				arg_23_1.text_.text = var_26_12

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 49
				local var_26_14 = utf8.len(var_26_12)
				local var_26_15 = var_26_13 <= 0 and var_26_9 or var_26_9 * (var_26_14 / var_26_13)

				if var_26_15 > 0 and var_26_9 < var_26_15 then
					arg_23_1.talkMaxDuration = var_26_15

					if var_26_15 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_15 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_12
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092006", "story_v_out_102092.awb") ~= 0 then
					local var_26_16 = manager.audio:GetVoiceLength("story_v_out_102092", "102092006", "story_v_out_102092.awb") / 1000

					if var_26_16 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_8
					end

					if var_26_11.prefab_name ~= "" and arg_23_1.actors_[var_26_11.prefab_name] ~= nil then
						local var_26_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_11.prefab_name].transform, "story_v_out_102092", "102092006", "story_v_out_102092.awb")

						arg_23_1:RecordAudio("102092006", var_26_17)
						arg_23_1:RecordAudio("102092006", var_26_17)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_102092", "102092006", "story_v_out_102092.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_102092", "102092006", "story_v_out_102092.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_18 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_18 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_18

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_18 and arg_23_1.time_ < var_26_8 + var_26_18 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end
	end,
	Play102092007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 102092007
		arg_27_1.duration_ = 5.8

		local var_27_0 = {
			ja = 5.8,
			ko = 4.633,
			zh = 4,
			en = 4.766
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
				arg_27_0:Play102092008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1011ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Object.Instantiate(Asset.Load("Char/" .. var_30_0), arg_27_1.stage_.transform)

				var_30_1.name = var_30_0
				var_30_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_[var_30_0] = var_30_1

				local var_30_2 = var_30_1:GetComponentInChildren(typeof(CharacterEffect))

				var_30_2.enabled = true

				local var_30_3 = GameObjectTools.GetOrAddComponent(var_30_1, typeof(DynamicBoneHelper))

				if var_30_3 then
					var_30_3:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_2.transform, false)

				arg_27_1.var_[var_30_0 .. "Animator"] = var_30_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
				arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_4 = arg_27_1.actors_["1011ui_story"]
			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 and arg_27_1.var_.characterEffect1011ui_story == nil then
				arg_27_1.var_.characterEffect1011ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.1

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_6 then
				local var_30_7 = (arg_27_1.time_ - var_30_5) / var_30_6

				if arg_27_1.var_.characterEffect1011ui_story then
					arg_27_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_5 + var_30_6 and arg_27_1.time_ < var_30_5 + var_30_6 + arg_30_0 and arg_27_1.var_.characterEffect1011ui_story then
				arg_27_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_30_8 = arg_27_1.actors_["10002_tpose"]
			local var_30_9 = 0

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 and arg_27_1.var_.characterEffect10002_tpose == nil then
				arg_27_1.var_.characterEffect10002_tpose = var_30_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_10 = 0.1

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_10 then
				local var_30_11 = (arg_27_1.time_ - var_30_9) / var_30_10

				if arg_27_1.var_.characterEffect10002_tpose then
					local var_30_12 = Mathf.Lerp(0, 0.5, var_30_11)

					arg_27_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_27_1.var_.characterEffect10002_tpose.fillRatio = var_30_12
				end
			end

			if arg_27_1.time_ >= var_30_9 + var_30_10 and arg_27_1.time_ < var_30_9 + var_30_10 + arg_30_0 and arg_27_1.var_.characterEffect10002_tpose then
				local var_30_13 = 0.5

				arg_27_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_27_1.var_.characterEffect10002_tpose.fillRatio = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["1084ui_story"].transform
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_14.localPosition
			end

			local var_30_16 = 0.001

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16
				local var_30_18 = Vector3.New(0, 100, 0)

				var_30_14.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, var_30_18, var_30_17)

				local var_30_19 = manager.ui.mainCamera.transform.position - var_30_14.position

				var_30_14.forward = Vector3.New(var_30_19.x, var_30_19.y, var_30_19.z)

				local var_30_20 = var_30_14.localEulerAngles

				var_30_20.z = 0
				var_30_20.x = 0
				var_30_14.localEulerAngles = var_30_20
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 then
				var_30_14.localPosition = Vector3.New(0, 100, 0)

				local var_30_21 = manager.ui.mainCamera.transform.position - var_30_14.position

				var_30_14.forward = Vector3.New(var_30_21.x, var_30_21.y, var_30_21.z)

				local var_30_22 = var_30_14.localEulerAngles

				var_30_22.z = 0
				var_30_22.x = 0
				var_30_14.localEulerAngles = var_30_22
			end

			local var_30_23 = arg_27_1.actors_["1011ui_story"].transform
			local var_30_24 = 0

			if var_30_24 < arg_27_1.time_ and arg_27_1.time_ <= var_30_24 + arg_30_0 then
				arg_27_1.var_.moveOldPos1011ui_story = var_30_23.localPosition
			end

			local var_30_25 = 0.001

			if var_30_24 <= arg_27_1.time_ and arg_27_1.time_ < var_30_24 + var_30_25 then
				local var_30_26 = (arg_27_1.time_ - var_30_24) / var_30_25
				local var_30_27 = Vector3.New(-0.7, -0.71, -6)

				var_30_23.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1011ui_story, var_30_27, var_30_26)

				local var_30_28 = manager.ui.mainCamera.transform.position - var_30_23.position

				var_30_23.forward = Vector3.New(var_30_28.x, var_30_28.y, var_30_28.z)

				local var_30_29 = var_30_23.localEulerAngles

				var_30_29.z = 0
				var_30_29.x = 0
				var_30_23.localEulerAngles = var_30_29
			end

			if arg_27_1.time_ >= var_30_24 + var_30_25 and arg_27_1.time_ < var_30_24 + var_30_25 + arg_30_0 then
				var_30_23.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_30_30 = manager.ui.mainCamera.transform.position - var_30_23.position

				var_30_23.forward = Vector3.New(var_30_30.x, var_30_30.y, var_30_30.z)

				local var_30_31 = var_30_23.localEulerAngles

				var_30_31.z = 0
				var_30_31.x = 0
				var_30_23.localEulerAngles = var_30_31
			end

			local var_30_32 = 0

			if var_30_32 < arg_27_1.time_ and arg_27_1.time_ <= var_30_32 + arg_30_0 then
				arg_27_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/1011/1011action/1011action2_1")
			end

			local var_30_33 = 0

			if var_30_33 < arg_27_1.time_ and arg_27_1.time_ <= var_30_33 + arg_30_0 then
				arg_27_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_30_34 = 0
			local var_30_35 = 0.425

			if var_30_34 < arg_27_1.time_ and arg_27_1.time_ <= var_30_34 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_36 = arg_27_1:FormatText(StoryNameCfg[37].name)

				arg_27_1.leftNameTxt_.text = var_30_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_37 = arg_27_1:GetWordFromCfg(102092007)
				local var_30_38 = arg_27_1:FormatText(var_30_37.content)

				arg_27_1.text_.text = var_30_38

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_39 = 17
				local var_30_40 = utf8.len(var_30_38)
				local var_30_41 = var_30_39 <= 0 and var_30_35 or var_30_35 * (var_30_40 / var_30_39)

				if var_30_41 > 0 and var_30_35 < var_30_41 then
					arg_27_1.talkMaxDuration = var_30_41

					if var_30_41 + var_30_34 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_41 + var_30_34
					end
				end

				arg_27_1.text_.text = var_30_38
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092007", "story_v_out_102092.awb") ~= 0 then
					local var_30_42 = manager.audio:GetVoiceLength("story_v_out_102092", "102092007", "story_v_out_102092.awb") / 1000

					if var_30_42 + var_30_34 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_42 + var_30_34
					end

					if var_30_37.prefab_name ~= "" and arg_27_1.actors_[var_30_37.prefab_name] ~= nil then
						local var_30_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_37.prefab_name].transform, "story_v_out_102092", "102092007", "story_v_out_102092.awb")

						arg_27_1:RecordAudio("102092007", var_30_43)
						arg_27_1:RecordAudio("102092007", var_30_43)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_102092", "102092007", "story_v_out_102092.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_102092", "102092007", "story_v_out_102092.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_44 = math.max(var_30_35, arg_27_1.talkMaxDuration)

			if var_30_34 <= arg_27_1.time_ and arg_27_1.time_ < var_30_34 + var_30_44 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_34) / var_30_44

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_34 + var_30_44 and arg_27_1.time_ < var_30_34 + var_30_44 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end
	end,
	Play102092008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 102092008
		arg_31_1.duration_ = 2.6

		local var_31_0 = {
			ja = 2.466,
			ko = 1.533,
			zh = 2.6,
			en = 1.6
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play102092009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10002_tpose"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and arg_31_1.var_.characterEffect10002_tpose == nil then
				arg_31_1.var_.characterEffect10002_tpose = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.1

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect10002_tpose then
					arg_31_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and arg_31_1.var_.characterEffect10002_tpose then
				arg_31_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["1011ui_story"]
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 and arg_31_1.var_.characterEffect1011ui_story == nil then
				arg_31_1.var_.characterEffect1011ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.1

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6

				if arg_31_1.var_.characterEffect1011ui_story then
					local var_34_8 = Mathf.Lerp(0, 0.5, var_34_7)

					arg_31_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1011ui_story.fillRatio = var_34_8
				end
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 and arg_31_1.var_.characterEffect1011ui_story then
				local var_34_9 = 0.5

				arg_31_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1011ui_story.fillRatio = var_34_9
			end

			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_34_11 = 0
			local var_34_12 = 0.05

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_13 = arg_31_1:FormatText(StoryNameCfg[39].name)

				arg_31_1.leftNameTxt_.text = var_34_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_14 = arg_31_1:GetWordFromCfg(102092008)
				local var_34_15 = arg_31_1:FormatText(var_34_14.content)

				arg_31_1.text_.text = var_34_15

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 2
				local var_34_17 = utf8.len(var_34_15)
				local var_34_18 = var_34_16 <= 0 and var_34_12 or var_34_12 * (var_34_17 / var_34_16)

				if var_34_18 > 0 and var_34_12 < var_34_18 then
					arg_31_1.talkMaxDuration = var_34_18

					if var_34_18 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_18 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_15
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092008", "story_v_out_102092.awb") ~= 0 then
					local var_34_19 = manager.audio:GetVoiceLength("story_v_out_102092", "102092008", "story_v_out_102092.awb") / 1000

					if var_34_19 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_19 + var_34_11
					end

					if var_34_14.prefab_name ~= "" and arg_31_1.actors_[var_34_14.prefab_name] ~= nil then
						local var_34_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_14.prefab_name].transform, "story_v_out_102092", "102092008", "story_v_out_102092.awb")

						arg_31_1:RecordAudio("102092008", var_34_20)
						arg_31_1:RecordAudio("102092008", var_34_20)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_102092", "102092008", "story_v_out_102092.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_102092", "102092008", "story_v_out_102092.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_21 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_21 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_11) / var_34_21

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_11 + var_34_21 and arg_31_1.time_ < var_34_11 + var_34_21 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end
	end,
	Play102092009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102092009
		arg_35_1.duration_ = 5.7

		local var_35_0 = {
			ja = 4.466,
			ko = 5.7,
			zh = 4.066,
			en = 4.1
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
				arg_35_0:Play102092010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_38_2 = 0
			local var_38_3 = 0.475

			if var_38_2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_4 = arg_35_1:FormatText(StoryNameCfg[39].name)

				arg_35_1.leftNameTxt_.text = var_38_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:GetWordFromCfg(102092009)
				local var_38_6 = arg_35_1:FormatText(var_38_5.content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 19
				local var_38_8 = utf8.len(var_38_6)
				local var_38_9 = var_38_7 <= 0 and var_38_3 or var_38_3 * (var_38_8 / var_38_7)

				if var_38_9 > 0 and var_38_3 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_6
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092009", "story_v_out_102092.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092009", "story_v_out_102092.awb") / 1000

					if var_38_10 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_2
					end

					if var_38_5.prefab_name ~= "" and arg_35_1.actors_[var_38_5.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_5.prefab_name].transform, "story_v_out_102092", "102092009", "story_v_out_102092.awb")

						arg_35_1:RecordAudio("102092009", var_38_11)
						arg_35_1:RecordAudio("102092009", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_102092", "102092009", "story_v_out_102092.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_102092", "102092009", "story_v_out_102092.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_12 and arg_35_1.time_ < var_38_2 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end
	end,
	Play102092010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 102092010
		arg_39_1.duration_ = 16.533

		local var_39_0 = {
			ja = 9.1,
			ko = 16.533,
			zh = 11.9,
			en = 9.2
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
				arg_39_0:Play102092011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_1 = 0
			local var_42_2 = 1.3

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_3 = arg_39_1:FormatText(StoryNameCfg[39].name)

				arg_39_1.leftNameTxt_.text = var_42_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_4 = arg_39_1:GetWordFromCfg(102092010)
				local var_42_5 = arg_39_1:FormatText(var_42_4.content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 52
				local var_42_7 = utf8.len(var_42_5)
				local var_42_8 = var_42_6 <= 0 and var_42_2 or var_42_2 * (var_42_7 / var_42_6)

				if var_42_8 > 0 and var_42_2 < var_42_8 then
					arg_39_1.talkMaxDuration = var_42_8

					if var_42_8 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_8 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092010", "story_v_out_102092.awb") ~= 0 then
					local var_42_9 = manager.audio:GetVoiceLength("story_v_out_102092", "102092010", "story_v_out_102092.awb") / 1000

					if var_42_9 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_1
					end

					if var_42_4.prefab_name ~= "" and arg_39_1.actors_[var_42_4.prefab_name] ~= nil then
						local var_42_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_4.prefab_name].transform, "story_v_out_102092", "102092010", "story_v_out_102092.awb")

						arg_39_1:RecordAudio("102092010", var_42_10)
						arg_39_1:RecordAudio("102092010", var_42_10)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_102092", "102092010", "story_v_out_102092.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_102092", "102092010", "story_v_out_102092.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_11 and arg_39_1.time_ < var_42_1 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end
	end,
	Play102092011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 102092011
		arg_43_1.duration_ = 2.3

		local var_43_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.3
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
				arg_43_0:Play102092012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1084ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.1

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1084ui_story then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_46_4 = arg_43_1.actors_["10002_tpose"]
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 and arg_43_1.var_.characterEffect10002_tpose == nil then
				arg_43_1.var_.characterEffect10002_tpose = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.1

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 then
				local var_46_7 = (arg_43_1.time_ - var_46_5) / var_46_6

				if arg_43_1.var_.characterEffect10002_tpose then
					local var_46_8 = Mathf.Lerp(0, 0.5, var_46_7)

					arg_43_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_43_1.var_.characterEffect10002_tpose.fillRatio = var_46_8
				end
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 and arg_43_1.var_.characterEffect10002_tpose then
				local var_46_9 = 0.5

				arg_43_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_43_1.var_.characterEffect10002_tpose.fillRatio = var_46_9
			end

			local var_46_10 = arg_43_1.actors_["1011ui_story"].transform
			local var_46_11 = 0

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.var_.moveOldPos1011ui_story = var_46_10.localPosition
			end

			local var_46_12 = 0.001

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_11) / var_46_12
				local var_46_14 = Vector3.New(0, 100, 0)

				var_46_10.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1011ui_story, var_46_14, var_46_13)

				local var_46_15 = manager.ui.mainCamera.transform.position - var_46_10.position

				var_46_10.forward = Vector3.New(var_46_15.x, var_46_15.y, var_46_15.z)

				local var_46_16 = var_46_10.localEulerAngles

				var_46_16.z = 0
				var_46_16.x = 0
				var_46_10.localEulerAngles = var_46_16
			end

			if arg_43_1.time_ >= var_46_11 + var_46_12 and arg_43_1.time_ < var_46_11 + var_46_12 + arg_46_0 then
				var_46_10.localPosition = Vector3.New(0, 100, 0)

				local var_46_17 = manager.ui.mainCamera.transform.position - var_46_10.position

				var_46_10.forward = Vector3.New(var_46_17.x, var_46_17.y, var_46_17.z)

				local var_46_18 = var_46_10.localEulerAngles

				var_46_18.z = 0
				var_46_18.x = 0
				var_46_10.localEulerAngles = var_46_18
			end

			local var_46_19 = 0

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action12_1")
			end

			local var_46_20 = arg_43_1.actors_["1084ui_story"].transform
			local var_46_21 = 0

			if var_46_21 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1.var_.moveOldPos1084ui_story = var_46_20.localPosition
			end

			local var_46_22 = 0.001

			if var_46_21 <= arg_43_1.time_ and arg_43_1.time_ < var_46_21 + var_46_22 then
				local var_46_23 = (arg_43_1.time_ - var_46_21) / var_46_22
				local var_46_24 = Vector3.New(-0.7, -0.97, -6)

				var_46_20.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1084ui_story, var_46_24, var_46_23)

				local var_46_25 = manager.ui.mainCamera.transform.position - var_46_20.position

				var_46_20.forward = Vector3.New(var_46_25.x, var_46_25.y, var_46_25.z)

				local var_46_26 = var_46_20.localEulerAngles

				var_46_26.z = 0
				var_46_26.x = 0
				var_46_20.localEulerAngles = var_46_26
			end

			if arg_43_1.time_ >= var_46_21 + var_46_22 and arg_43_1.time_ < var_46_21 + var_46_22 + arg_46_0 then
				var_46_20.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_46_27 = manager.ui.mainCamera.transform.position - var_46_20.position

				var_46_20.forward = Vector3.New(var_46_27.x, var_46_27.y, var_46_27.z)

				local var_46_28 = var_46_20.localEulerAngles

				var_46_28.z = 0
				var_46_28.x = 0
				var_46_20.localEulerAngles = var_46_28
			end

			local var_46_29 = 0

			if var_46_29 < arg_43_1.time_ and arg_43_1.time_ <= var_46_29 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_30 = 0
			local var_46_31 = 0.125

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_32 = arg_43_1:FormatText(StoryNameCfg[6].name)

				arg_43_1.leftNameTxt_.text = var_46_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_33 = arg_43_1:GetWordFromCfg(102092011)
				local var_46_34 = arg_43_1:FormatText(var_46_33.content)

				arg_43_1.text_.text = var_46_34

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_35 = 5
				local var_46_36 = utf8.len(var_46_34)
				local var_46_37 = var_46_35 <= 0 and var_46_31 or var_46_31 * (var_46_36 / var_46_35)

				if var_46_37 > 0 and var_46_31 < var_46_37 then
					arg_43_1.talkMaxDuration = var_46_37

					if var_46_37 + var_46_30 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_37 + var_46_30
					end
				end

				arg_43_1.text_.text = var_46_34
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092011", "story_v_out_102092.awb") ~= 0 then
					local var_46_38 = manager.audio:GetVoiceLength("story_v_out_102092", "102092011", "story_v_out_102092.awb") / 1000

					if var_46_38 + var_46_30 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_38 + var_46_30
					end

					if var_46_33.prefab_name ~= "" and arg_43_1.actors_[var_46_33.prefab_name] ~= nil then
						local var_46_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_33.prefab_name].transform, "story_v_out_102092", "102092011", "story_v_out_102092.awb")

						arg_43_1:RecordAudio("102092011", var_46_39)
						arg_43_1:RecordAudio("102092011", var_46_39)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_102092", "102092011", "story_v_out_102092.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_102092", "102092011", "story_v_out_102092.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_40 = math.max(var_46_31, arg_43_1.talkMaxDuration)

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_40 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_30) / var_46_40

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_30 + var_46_40 and arg_43_1.time_ < var_46_30 + var_46_40 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end
	end,
	Play102092012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 102092012
		arg_47_1.duration_ = 20.133

		local var_47_0 = {
			ja = 15.833,
			ko = 20.133,
			zh = 14.9,
			en = 16.133
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
				arg_47_0:Play102092013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10002_tpose"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and arg_47_1.var_.characterEffect10002_tpose == nil then
				arg_47_1.var_.characterEffect10002_tpose = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.1

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10002_tpose then
					arg_47_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and arg_47_1.var_.characterEffect10002_tpose then
				arg_47_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1084ui_story"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.1

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.characterEffect1084ui_story then
					local var_50_8 = Mathf.Lerp(0, 0.5, var_50_7)

					arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_8
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and arg_47_1.var_.characterEffect1084ui_story then
				local var_50_9 = 0.5

				arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_9
			end

			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_50_11 = 0

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				arg_47_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_50_12 = 0
			local var_50_13 = 1.6

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_14 = arg_47_1:FormatText(StoryNameCfg[39].name)

				arg_47_1.leftNameTxt_.text = var_50_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_15 = arg_47_1:GetWordFromCfg(102092012)
				local var_50_16 = arg_47_1:FormatText(var_50_15.content)

				arg_47_1.text_.text = var_50_16

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 64
				local var_50_18 = utf8.len(var_50_16)
				local var_50_19 = var_50_17 <= 0 and var_50_13 or var_50_13 * (var_50_18 / var_50_17)

				if var_50_19 > 0 and var_50_13 < var_50_19 then
					arg_47_1.talkMaxDuration = var_50_19

					if var_50_19 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_19 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_16
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092012", "story_v_out_102092.awb") ~= 0 then
					local var_50_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092012", "story_v_out_102092.awb") / 1000

					if var_50_20 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_12
					end

					if var_50_15.prefab_name ~= "" and arg_47_1.actors_[var_50_15.prefab_name] ~= nil then
						local var_50_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_15.prefab_name].transform, "story_v_out_102092", "102092012", "story_v_out_102092.awb")

						arg_47_1:RecordAudio("102092012", var_50_21)
						arg_47_1:RecordAudio("102092012", var_50_21)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_102092", "102092012", "story_v_out_102092.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_102092", "102092012", "story_v_out_102092.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_22 and arg_47_1.time_ < var_50_12 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end
	end,
	Play102092013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 102092013
		arg_51_1.duration_ = 3.833

		local var_51_0 = {
			ja = 3.833,
			ko = 2.4,
			zh = 2.5,
			en = 2.2
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
				arg_51_0:Play102092014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1084ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.1

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1084ui_story then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_54_4 = arg_51_1.actors_["10002_tpose"]
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 and arg_51_1.var_.characterEffect10002_tpose == nil then
				arg_51_1.var_.characterEffect10002_tpose = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.1

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6

				if arg_51_1.var_.characterEffect10002_tpose then
					local var_54_8 = Mathf.Lerp(0, 0.5, var_54_7)

					arg_51_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_51_1.var_.characterEffect10002_tpose.fillRatio = var_54_8
				end
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 and arg_51_1.var_.characterEffect10002_tpose then
				local var_54_9 = 0.5

				arg_51_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_51_1.var_.characterEffect10002_tpose.fillRatio = var_54_9
			end

			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_54_11 = 0
			local var_54_12 = 0.125

			if var_54_11 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_13 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_14 = arg_51_1:GetWordFromCfg(102092013)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 5
				local var_54_17 = utf8.len(var_54_15)
				local var_54_18 = var_54_16 <= 0 and var_54_12 or var_54_12 * (var_54_17 / var_54_16)

				if var_54_18 > 0 and var_54_12 < var_54_18 then
					arg_51_1.talkMaxDuration = var_54_18

					if var_54_18 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092013", "story_v_out_102092.awb") ~= 0 then
					local var_54_19 = manager.audio:GetVoiceLength("story_v_out_102092", "102092013", "story_v_out_102092.awb") / 1000

					if var_54_19 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_19 + var_54_11
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_out_102092", "102092013", "story_v_out_102092.awb")

						arg_51_1:RecordAudio("102092013", var_54_20)
						arg_51_1:RecordAudio("102092013", var_54_20)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_102092", "102092013", "story_v_out_102092.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_102092", "102092013", "story_v_out_102092.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_21 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_21 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_21

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_21 and arg_51_1.time_ < var_54_11 + var_54_21 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play102092014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 102092014
		arg_55_1.duration_ = 12.466

		local var_55_0 = {
			ja = 12.466,
			ko = 12,
			zh = 11.7,
			en = 11.3
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
				arg_55_0:Play102092015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10002_tpose"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and arg_55_1.var_.characterEffect10002_tpose == nil then
				arg_55_1.var_.characterEffect10002_tpose = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.1

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect10002_tpose then
					arg_55_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and arg_55_1.var_.characterEffect10002_tpose then
				arg_55_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1084ui_story"]
			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 and arg_55_1.var_.characterEffect1084ui_story == nil then
				arg_55_1.var_.characterEffect1084ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.1

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / var_58_6

				if arg_55_1.var_.characterEffect1084ui_story then
					local var_58_8 = Mathf.Lerp(0, 0.5, var_58_7)

					arg_55_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1084ui_story.fillRatio = var_58_8
				end
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 and arg_55_1.var_.characterEffect1084ui_story then
				local var_58_9 = 0.5

				arg_55_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1084ui_story.fillRatio = var_58_9
			end

			local var_58_10 = arg_55_1.actors_["1084ui_story"].transform
			local var_58_11 = 0

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_10.localPosition
			end

			local var_58_12 = 0.001

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_11) / var_58_12
				local var_58_14 = Vector3.New(0, 100, 0)

				var_58_10.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, var_58_14, var_58_13)

				local var_58_15 = manager.ui.mainCamera.transform.position - var_58_10.position

				var_58_10.forward = Vector3.New(var_58_15.x, var_58_15.y, var_58_15.z)

				local var_58_16 = var_58_10.localEulerAngles

				var_58_16.z = 0
				var_58_16.x = 0
				var_58_10.localEulerAngles = var_58_16
			end

			if arg_55_1.time_ >= var_58_11 + var_58_12 and arg_55_1.time_ < var_58_11 + var_58_12 + arg_58_0 then
				var_58_10.localPosition = Vector3.New(0, 100, 0)

				local var_58_17 = manager.ui.mainCamera.transform.position - var_58_10.position

				var_58_10.forward = Vector3.New(var_58_17.x, var_58_17.y, var_58_17.z)

				local var_58_18 = var_58_10.localEulerAngles

				var_58_18.z = 0
				var_58_18.x = 0
				var_58_10.localEulerAngles = var_58_18
			end

			local var_58_19 = arg_55_1.actors_["10002_tpose"].transform
			local var_58_20 = 0.033

			if var_58_20 < arg_55_1.time_ and arg_55_1.time_ <= var_58_20 + arg_58_0 then
				arg_55_1.var_.moveOldPos10002_tpose = var_58_19.localPosition
			end

			local var_58_21 = 0.5

			if var_58_20 <= arg_55_1.time_ and arg_55_1.time_ < var_58_20 + var_58_21 then
				local var_58_22 = (arg_55_1.time_ - var_58_20) / var_58_21
				local var_58_23 = Vector3.New(0, -1.2, -5.8)

				var_58_19.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10002_tpose, var_58_23, var_58_22)

				local var_58_24 = manager.ui.mainCamera.transform.position - var_58_19.position

				var_58_19.forward = Vector3.New(var_58_24.x, var_58_24.y, var_58_24.z)

				local var_58_25 = var_58_19.localEulerAngles

				var_58_25.z = 0
				var_58_25.x = 0
				var_58_19.localEulerAngles = var_58_25
			end

			if arg_55_1.time_ >= var_58_20 + var_58_21 and arg_55_1.time_ < var_58_20 + var_58_21 + arg_58_0 then
				var_58_19.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_58_26 = manager.ui.mainCamera.transform.position - var_58_19.position

				var_58_19.forward = Vector3.New(var_58_26.x, var_58_26.y, var_58_26.z)

				local var_58_27 = var_58_19.localEulerAngles

				var_58_27.z = 0
				var_58_27.x = 0
				var_58_19.localEulerAngles = var_58_27
			end

			local var_58_28 = arg_55_1.actors_["10002_tpose"].transform
			local var_58_29 = 0

			if var_58_29 < arg_55_1.time_ and arg_55_1.time_ <= var_58_29 + arg_58_0 then
				arg_55_1.var_.moveOldPos10002_tpose = var_58_28.localPosition
			end

			local var_58_30 = 0.001

			if var_58_29 <= arg_55_1.time_ and arg_55_1.time_ < var_58_29 + var_58_30 then
				local var_58_31 = (arg_55_1.time_ - var_58_29) / var_58_30
				local var_58_32 = Vector3.New(0.7, -1.2, -5.8)

				var_58_28.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10002_tpose, var_58_32, var_58_31)

				local var_58_33 = manager.ui.mainCamera.transform.position - var_58_28.position

				var_58_28.forward = Vector3.New(var_58_33.x, var_58_33.y, var_58_33.z)

				local var_58_34 = var_58_28.localEulerAngles

				var_58_34.z = 0
				var_58_34.x = 0
				var_58_28.localEulerAngles = var_58_34
			end

			if arg_55_1.time_ >= var_58_29 + var_58_30 and arg_55_1.time_ < var_58_29 + var_58_30 + arg_58_0 then
				var_58_28.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_58_35 = manager.ui.mainCamera.transform.position - var_58_28.position

				var_58_28.forward = Vector3.New(var_58_35.x, var_58_35.y, var_58_35.z)

				local var_58_36 = var_58_28.localEulerAngles

				var_58_36.z = 0
				var_58_36.x = 0
				var_58_28.localEulerAngles = var_58_36
			end

			local var_58_37 = 0

			if var_58_37 < arg_55_1.time_ and arg_55_1.time_ <= var_58_37 + arg_58_0 then
				arg_55_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_58_38 = 0
			local var_58_39 = 1.175

			if var_58_38 < arg_55_1.time_ and arg_55_1.time_ <= var_58_38 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_40 = arg_55_1:FormatText(StoryNameCfg[39].name)

				arg_55_1.leftNameTxt_.text = var_58_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_41 = arg_55_1:GetWordFromCfg(102092014)
				local var_58_42 = arg_55_1:FormatText(var_58_41.content)

				arg_55_1.text_.text = var_58_42

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_43 = 47
				local var_58_44 = utf8.len(var_58_42)
				local var_58_45 = var_58_43 <= 0 and var_58_39 or var_58_39 * (var_58_44 / var_58_43)

				if var_58_45 > 0 and var_58_39 < var_58_45 then
					arg_55_1.talkMaxDuration = var_58_45

					if var_58_45 + var_58_38 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_45 + var_58_38
					end
				end

				arg_55_1.text_.text = var_58_42
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092014", "story_v_out_102092.awb") ~= 0 then
					local var_58_46 = manager.audio:GetVoiceLength("story_v_out_102092", "102092014", "story_v_out_102092.awb") / 1000

					if var_58_46 + var_58_38 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_46 + var_58_38
					end

					if var_58_41.prefab_name ~= "" and arg_55_1.actors_[var_58_41.prefab_name] ~= nil then
						local var_58_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_41.prefab_name].transform, "story_v_out_102092", "102092014", "story_v_out_102092.awb")

						arg_55_1:RecordAudio("102092014", var_58_47)
						arg_55_1:RecordAudio("102092014", var_58_47)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_102092", "102092014", "story_v_out_102092.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_102092", "102092014", "story_v_out_102092.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_48 = math.max(var_58_39, arg_55_1.talkMaxDuration)

			if var_58_38 <= arg_55_1.time_ and arg_55_1.time_ < var_58_38 + var_58_48 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_38) / var_58_48

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_38 + var_58_48 and arg_55_1.time_ < var_58_38 + var_58_48 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play102092015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 102092015
		arg_59_1.duration_ = 12.933

		local var_59_0 = {
			ja = 12.933,
			ko = 12.766,
			zh = 10.5,
			en = 10.4
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
				arg_59_0:Play102092016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_62_1 = 0
			local var_62_2 = 1.1

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_3 = arg_59_1:FormatText(StoryNameCfg[39].name)

				arg_59_1.leftNameTxt_.text = var_62_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(102092015)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 44
				local var_62_7 = utf8.len(var_62_5)
				local var_62_8 = var_62_6 <= 0 and var_62_2 or var_62_2 * (var_62_7 / var_62_6)

				if var_62_8 > 0 and var_62_2 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092015", "story_v_out_102092.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_102092", "102092015", "story_v_out_102092.awb") / 1000

					if var_62_9 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_1
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_102092", "102092015", "story_v_out_102092.awb")

						arg_59_1:RecordAudio("102092015", var_62_10)
						arg_59_1:RecordAudio("102092015", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_102092", "102092015", "story_v_out_102092.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_102092", "102092015", "story_v_out_102092.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_11 and arg_59_1.time_ < var_62_1 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	Play102092016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 102092016
		arg_63_1.duration_ = 15.2

		local var_63_0 = {
			ja = 12.333,
			ko = 13.2,
			zh = 13.9,
			en = 15.2
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
				arg_63_0:Play102092017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_1 = 0
			local var_66_2 = 1.4

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_3 = arg_63_1:FormatText(StoryNameCfg[39].name)

				arg_63_1.leftNameTxt_.text = var_66_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(102092016)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092016", "story_v_out_102092.awb") ~= 0 then
					local var_66_9 = manager.audio:GetVoiceLength("story_v_out_102092", "102092016", "story_v_out_102092.awb") / 1000

					if var_66_9 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_1
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_out_102092", "102092016", "story_v_out_102092.awb")

						arg_63_1:RecordAudio("102092016", var_66_10)
						arg_63_1:RecordAudio("102092016", var_66_10)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_102092", "102092016", "story_v_out_102092.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_102092", "102092016", "story_v_out_102092.awb")
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
	Play102092017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 102092017
		arg_67_1.duration_ = 19.4

		local var_67_0 = {
			ja = 16.733,
			ko = 18.5,
			zh = 15.933,
			en = 19.4
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
				arg_67_0:Play102092018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_2 = 0
			local var_70_3 = 1.6

			if var_70_2 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_4 = arg_67_1:FormatText(StoryNameCfg[39].name)

				arg_67_1.leftNameTxt_.text = var_70_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_5 = arg_67_1:GetWordFromCfg(102092017)
				local var_70_6 = arg_67_1:FormatText(var_70_5.content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 64
				local var_70_8 = utf8.len(var_70_6)
				local var_70_9 = var_70_7 <= 0 and var_70_3 or var_70_3 * (var_70_8 / var_70_7)

				if var_70_9 > 0 and var_70_3 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092017", "story_v_out_102092.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092017", "story_v_out_102092.awb") / 1000

					if var_70_10 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_2
					end

					if var_70_5.prefab_name ~= "" and arg_67_1.actors_[var_70_5.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_5.prefab_name].transform, "story_v_out_102092", "102092017", "story_v_out_102092.awb")

						arg_67_1:RecordAudio("102092017", var_70_11)
						arg_67_1:RecordAudio("102092017", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_102092", "102092017", "story_v_out_102092.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_102092", "102092017", "story_v_out_102092.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_12 and arg_67_1.time_ < var_70_2 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play102092018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 102092018
		arg_71_1.duration_ = 7.6

		local var_71_0 = {
			ja = 7.6,
			ko = 4.9,
			zh = 4.866,
			en = 6.266
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
				arg_71_0:Play102092019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1011ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and arg_71_1.var_.characterEffect1011ui_story == nil then
				arg_71_1.var_.characterEffect1011ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.1

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1011ui_story then
					arg_71_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and arg_71_1.var_.characterEffect1011ui_story then
				arg_71_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["10002_tpose"]
			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 and arg_71_1.var_.characterEffect10002_tpose == nil then
				arg_71_1.var_.characterEffect10002_tpose = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.1

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / var_74_6

				if arg_71_1.var_.characterEffect10002_tpose then
					local var_74_8 = Mathf.Lerp(0, 0.5, var_74_7)

					arg_71_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_71_1.var_.characterEffect10002_tpose.fillRatio = var_74_8
				end
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 and arg_71_1.var_.characterEffect10002_tpose then
				local var_74_9 = 0.5

				arg_71_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_71_1.var_.characterEffect10002_tpose.fillRatio = var_74_9
			end

			local var_74_10 = arg_71_1.actors_["1011ui_story"].transform
			local var_74_11 = 0

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.var_.moveOldPos1011ui_story = var_74_10.localPosition
			end

			local var_74_12 = 0.001

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_12 then
				local var_74_13 = (arg_71_1.time_ - var_74_11) / var_74_12
				local var_74_14 = Vector3.New(-0.7, -0.71, -6)

				var_74_10.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1011ui_story, var_74_14, var_74_13)

				local var_74_15 = manager.ui.mainCamera.transform.position - var_74_10.position

				var_74_10.forward = Vector3.New(var_74_15.x, var_74_15.y, var_74_15.z)

				local var_74_16 = var_74_10.localEulerAngles

				var_74_16.z = 0
				var_74_16.x = 0
				var_74_10.localEulerAngles = var_74_16
			end

			if arg_71_1.time_ >= var_74_11 + var_74_12 and arg_71_1.time_ < var_74_11 + var_74_12 + arg_74_0 then
				var_74_10.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_74_17 = manager.ui.mainCamera.transform.position - var_74_10.position

				var_74_10.forward = Vector3.New(var_74_17.x, var_74_17.y, var_74_17.z)

				local var_74_18 = var_74_10.localEulerAngles

				var_74_18.z = 0
				var_74_18.x = 0
				var_74_10.localEulerAngles = var_74_18
			end

			local var_74_19 = 0

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/1011/1011action/1011action2_1")
			end

			local var_74_20 = arg_71_1.actors_["10002_tpose"].transform
			local var_74_21 = 0.033

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.var_.moveOldPos10002_tpose = var_74_20.localPosition
			end

			local var_74_22 = 0.5

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_22 then
				local var_74_23 = (arg_71_1.time_ - var_74_21) / var_74_22
				local var_74_24 = Vector3.New(0.7, -1.2, -5.8)

				var_74_20.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10002_tpose, var_74_24, var_74_23)

				local var_74_25 = manager.ui.mainCamera.transform.position - var_74_20.position

				var_74_20.forward = Vector3.New(var_74_25.x, var_74_25.y, var_74_25.z)

				local var_74_26 = var_74_20.localEulerAngles

				var_74_26.z = 0
				var_74_26.x = 0
				var_74_20.localEulerAngles = var_74_26
			end

			if arg_71_1.time_ >= var_74_21 + var_74_22 and arg_71_1.time_ < var_74_21 + var_74_22 + arg_74_0 then
				var_74_20.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_74_27 = manager.ui.mainCamera.transform.position - var_74_20.position

				var_74_20.forward = Vector3.New(var_74_27.x, var_74_27.y, var_74_27.z)

				local var_74_28 = var_74_20.localEulerAngles

				var_74_28.z = 0
				var_74_28.x = 0
				var_74_20.localEulerAngles = var_74_28
			end

			local var_74_29 = arg_71_1.actors_["10002_tpose"].transform
			local var_74_30 = 0

			if var_74_30 < arg_71_1.time_ and arg_71_1.time_ <= var_74_30 + arg_74_0 then
				arg_71_1.var_.moveOldPos10002_tpose = var_74_29.localPosition
			end

			local var_74_31 = 0.001

			if var_74_30 <= arg_71_1.time_ and arg_71_1.time_ < var_74_30 + var_74_31 then
				local var_74_32 = (arg_71_1.time_ - var_74_30) / var_74_31
				local var_74_33 = Vector3.New(0, -1.2, -5.8)

				var_74_29.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10002_tpose, var_74_33, var_74_32)

				local var_74_34 = manager.ui.mainCamera.transform.position - var_74_29.position

				var_74_29.forward = Vector3.New(var_74_34.x, var_74_34.y, var_74_34.z)

				local var_74_35 = var_74_29.localEulerAngles

				var_74_35.z = 0
				var_74_35.x = 0
				var_74_29.localEulerAngles = var_74_35
			end

			if arg_71_1.time_ >= var_74_30 + var_74_31 and arg_71_1.time_ < var_74_30 + var_74_31 + arg_74_0 then
				var_74_29.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_74_36 = manager.ui.mainCamera.transform.position - var_74_29.position

				var_74_29.forward = Vector3.New(var_74_36.x, var_74_36.y, var_74_36.z)

				local var_74_37 = var_74_29.localEulerAngles

				var_74_37.z = 0
				var_74_37.x = 0
				var_74_29.localEulerAngles = var_74_37
			end

			local var_74_38 = 0

			if var_74_38 < arg_71_1.time_ and arg_71_1.time_ <= var_74_38 + arg_74_0 then
				arg_71_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_39 = 0
			local var_74_40 = 0.525

			if var_74_39 < arg_71_1.time_ and arg_71_1.time_ <= var_74_39 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_41 = arg_71_1:FormatText(StoryNameCfg[37].name)

				arg_71_1.leftNameTxt_.text = var_74_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_42 = arg_71_1:GetWordFromCfg(102092018)
				local var_74_43 = arg_71_1:FormatText(var_74_42.content)

				arg_71_1.text_.text = var_74_43

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_44 = 21
				local var_74_45 = utf8.len(var_74_43)
				local var_74_46 = var_74_44 <= 0 and var_74_40 or var_74_40 * (var_74_45 / var_74_44)

				if var_74_46 > 0 and var_74_40 < var_74_46 then
					arg_71_1.talkMaxDuration = var_74_46

					if var_74_46 + var_74_39 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_46 + var_74_39
					end
				end

				arg_71_1.text_.text = var_74_43
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092018", "story_v_out_102092.awb") ~= 0 then
					local var_74_47 = manager.audio:GetVoiceLength("story_v_out_102092", "102092018", "story_v_out_102092.awb") / 1000

					if var_74_47 + var_74_39 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_47 + var_74_39
					end

					if var_74_42.prefab_name ~= "" and arg_71_1.actors_[var_74_42.prefab_name] ~= nil then
						local var_74_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_42.prefab_name].transform, "story_v_out_102092", "102092018", "story_v_out_102092.awb")

						arg_71_1:RecordAudio("102092018", var_74_48)
						arg_71_1:RecordAudio("102092018", var_74_48)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_102092", "102092018", "story_v_out_102092.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_102092", "102092018", "story_v_out_102092.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_49 = math.max(var_74_40, arg_71_1.talkMaxDuration)

			if var_74_39 <= arg_71_1.time_ and arg_71_1.time_ < var_74_39 + var_74_49 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_39) / var_74_49

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_39 + var_74_49 and arg_71_1.time_ < var_74_39 + var_74_49 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play102092019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 102092019
		arg_75_1.duration_ = 11.666

		local var_75_0 = {
			ja = 11.666,
			ko = 6.933,
			zh = 6.933,
			en = 6.5
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
				arg_75_0:Play102092020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10002_tpose"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and arg_75_1.var_.characterEffect10002_tpose == nil then
				arg_75_1.var_.characterEffect10002_tpose = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.1

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect10002_tpose then
					arg_75_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and arg_75_1.var_.characterEffect10002_tpose then
				arg_75_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["1011ui_story"]
			local var_78_5 = 0

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 and arg_75_1.var_.characterEffect1011ui_story == nil then
				arg_75_1.var_.characterEffect1011ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.1

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = (arg_75_1.time_ - var_78_5) / var_78_6

				if arg_75_1.var_.characterEffect1011ui_story then
					local var_78_8 = Mathf.Lerp(0, 0.5, var_78_7)

					arg_75_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1011ui_story.fillRatio = var_78_8
				end
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 and arg_75_1.var_.characterEffect1011ui_story then
				local var_78_9 = 0.5

				arg_75_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1011ui_story.fillRatio = var_78_9
			end

			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			local var_78_11 = 0

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_12 = 0
			local var_78_13 = 0.625

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_14 = arg_75_1:FormatText(StoryNameCfg[39].name)

				arg_75_1.leftNameTxt_.text = var_78_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_15 = arg_75_1:GetWordFromCfg(102092019)
				local var_78_16 = arg_75_1:FormatText(var_78_15.content)

				arg_75_1.text_.text = var_78_16

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 25
				local var_78_18 = utf8.len(var_78_16)
				local var_78_19 = var_78_17 <= 0 and var_78_13 or var_78_13 * (var_78_18 / var_78_17)

				if var_78_19 > 0 and var_78_13 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19

					if var_78_19 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_12
					end
				end

				arg_75_1.text_.text = var_78_16
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092019", "story_v_out_102092.awb") ~= 0 then
					local var_78_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092019", "story_v_out_102092.awb") / 1000

					if var_78_20 + var_78_12 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_12
					end

					if var_78_15.prefab_name ~= "" and arg_75_1.actors_[var_78_15.prefab_name] ~= nil then
						local var_78_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_15.prefab_name].transform, "story_v_out_102092", "102092019", "story_v_out_102092.awb")

						arg_75_1:RecordAudio("102092019", var_78_21)
						arg_75_1:RecordAudio("102092019", var_78_21)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_102092", "102092019", "story_v_out_102092.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_102092", "102092019", "story_v_out_102092.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_13, arg_75_1.talkMaxDuration)

			if var_78_12 <= arg_75_1.time_ and arg_75_1.time_ < var_78_12 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_12) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_12 + var_78_22 and arg_75_1.time_ < var_78_12 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play102092020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 102092020
		arg_79_1.duration_ = 20.233

		local var_79_0 = {
			ja = 12.6,
			ko = 20.233,
			zh = 15.4,
			en = 17.7
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
				arg_79_0:Play102092021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.625

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[39].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(102092020)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 65
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092020", "story_v_out_102092.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_102092", "102092020", "story_v_out_102092.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_102092", "102092020", "story_v_out_102092.awb")

						arg_79_1:RecordAudio("102092020", var_82_9)
						arg_79_1:RecordAudio("102092020", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_102092", "102092020", "story_v_out_102092.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_102092", "102092020", "story_v_out_102092.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play102092021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 102092021
		arg_83_1.duration_ = 4.2

		local var_83_0 = {
			ja = 4.2,
			ko = 1.9,
			zh = 1.1,
			en = 1.7
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
				arg_83_0:Play102092022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1084ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.1

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1084ui_story then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_86_4 = arg_83_1.actors_["10002_tpose"]
			local var_86_5 = 0

			if var_86_5 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 and arg_83_1.var_.characterEffect10002_tpose == nil then
				arg_83_1.var_.characterEffect10002_tpose = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_6 = 0.1

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_6 then
				local var_86_7 = (arg_83_1.time_ - var_86_5) / var_86_6

				if arg_83_1.var_.characterEffect10002_tpose then
					local var_86_8 = Mathf.Lerp(0, 0.5, var_86_7)

					arg_83_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_83_1.var_.characterEffect10002_tpose.fillRatio = var_86_8
				end
			end

			if arg_83_1.time_ >= var_86_5 + var_86_6 and arg_83_1.time_ < var_86_5 + var_86_6 + arg_86_0 and arg_83_1.var_.characterEffect10002_tpose then
				local var_86_9 = 0.5

				arg_83_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_83_1.var_.characterEffect10002_tpose.fillRatio = var_86_9
			end

			local var_86_10 = 0
			local var_86_11 = 0.15

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
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_13 = arg_83_1:GetWordFromCfg(102092021)
				local var_86_14 = arg_83_1:FormatText(var_86_13.content)

				arg_83_1.text_.text = var_86_14

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_15 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092021", "story_v_out_102092.awb") ~= 0 then
					local var_86_18 = manager.audio:GetVoiceLength("story_v_out_102092", "102092021", "story_v_out_102092.awb") / 1000

					if var_86_18 + var_86_10 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_10
					end

					if var_86_13.prefab_name ~= "" and arg_83_1.actors_[var_86_13.prefab_name] ~= nil then
						local var_86_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_13.prefab_name].transform, "story_v_out_102092", "102092021", "story_v_out_102092.awb")

						arg_83_1:RecordAudio("102092021", var_86_19)
						arg_83_1:RecordAudio("102092021", var_86_19)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_102092", "102092021", "story_v_out_102092.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_102092", "102092021", "story_v_out_102092.awb")
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
	Play102092022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 102092022
		arg_87_1.duration_ = 12.933

		local var_87_0 = {
			ja = 9.533,
			ko = 6.133,
			zh = 6.2,
			en = 12.933
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
				arg_87_0:Play102092023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1011ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and arg_87_1.var_.characterEffect1011ui_story == nil then
				arg_87_1.var_.characterEffect1011ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.1

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1011ui_story then
					arg_87_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and arg_87_1.var_.characterEffect1011ui_story then
				arg_87_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["1084ui_story"]
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_6 = 0.1

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6

				if arg_87_1.var_.characterEffect1084ui_story then
					local var_90_8 = Mathf.Lerp(0, 0.5, var_90_7)

					arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_8
				end
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 and arg_87_1.var_.characterEffect1084ui_story then
				local var_90_9 = 0.5

				arg_87_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1084ui_story.fillRatio = var_90_9
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/1011/1011actionlink/1011action426")
			end

			local var_90_11 = 0

			if var_90_11 < arg_87_1.time_ and arg_87_1.time_ <= var_90_11 + arg_90_0 then
				arg_87_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_90_12 = 0
			local var_90_13 = 0.75

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_14 = arg_87_1:FormatText(StoryNameCfg[37].name)

				arg_87_1.leftNameTxt_.text = var_90_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_15 = arg_87_1:GetWordFromCfg(102092022)
				local var_90_16 = arg_87_1:FormatText(var_90_15.content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_17 = 30
				local var_90_18 = utf8.len(var_90_16)
				local var_90_19 = var_90_17 <= 0 and var_90_13 or var_90_13 * (var_90_18 / var_90_17)

				if var_90_19 > 0 and var_90_13 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_12
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092022", "story_v_out_102092.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092022", "story_v_out_102092.awb") / 1000

					if var_90_20 + var_90_12 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_12
					end

					if var_90_15.prefab_name ~= "" and arg_87_1.actors_[var_90_15.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_15.prefab_name].transform, "story_v_out_102092", "102092022", "story_v_out_102092.awb")

						arg_87_1:RecordAudio("102092022", var_90_21)
						arg_87_1:RecordAudio("102092022", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_102092", "102092022", "story_v_out_102092.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_102092", "102092022", "story_v_out_102092.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_13, arg_87_1.talkMaxDuration)

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_12) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_12 + var_90_22 and arg_87_1.time_ < var_90_12 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end
	end,
	Play102092023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 102092023
		arg_91_1.duration_ = 7.933

		local var_91_0 = {
			ja = 7.9,
			ko = 7.266,
			zh = 6.6,
			en = 7.933
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
				arg_91_0:Play102092024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1011ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and arg_91_1.var_.characterEffect1011ui_story == nil then
				arg_91_1.var_.characterEffect1011ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.1

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1011ui_story then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1011ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and arg_91_1.var_.characterEffect1011ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1011ui_story.fillRatio = var_94_5
			end

			local var_94_6 = arg_91_1.actors_["1011ui_story"].transform
			local var_94_7 = 0

			if var_94_7 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.var_.moveOldPos1011ui_story = var_94_6.localPosition
			end

			local var_94_8 = 0.001

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_8 then
				local var_94_9 = (arg_91_1.time_ - var_94_7) / var_94_8
				local var_94_10 = Vector3.New(0, 100, 0)

				var_94_6.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1011ui_story, var_94_10, var_94_9)

				local var_94_11 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_11.x, var_94_11.y, var_94_11.z)

				local var_94_12 = var_94_6.localEulerAngles

				var_94_12.z = 0
				var_94_12.x = 0
				var_94_6.localEulerAngles = var_94_12
			end

			if arg_91_1.time_ >= var_94_7 + var_94_8 and arg_91_1.time_ < var_94_7 + var_94_8 + arg_94_0 then
				var_94_6.localPosition = Vector3.New(0, 100, 0)

				local var_94_13 = manager.ui.mainCamera.transform.position - var_94_6.position

				var_94_6.forward = Vector3.New(var_94_13.x, var_94_13.y, var_94_13.z)

				local var_94_14 = var_94_6.localEulerAngles

				var_94_14.z = 0
				var_94_14.x = 0
				var_94_6.localEulerAngles = var_94_14
			end

			local var_94_15 = arg_91_1.actors_["10002_tpose"].transform
			local var_94_16 = 0.033

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.var_.moveOldPos10002_tpose = var_94_15.localPosition
			end

			local var_94_17 = 0.5

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17
				local var_94_19 = Vector3.New(0, -1.2, -5.8)

				var_94_15.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10002_tpose, var_94_19, var_94_18)

				local var_94_20 = manager.ui.mainCamera.transform.position - var_94_15.position

				var_94_15.forward = Vector3.New(var_94_20.x, var_94_20.y, var_94_20.z)

				local var_94_21 = var_94_15.localEulerAngles

				var_94_21.z = 0
				var_94_21.x = 0
				var_94_15.localEulerAngles = var_94_21
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 then
				var_94_15.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_94_22 = manager.ui.mainCamera.transform.position - var_94_15.position

				var_94_15.forward = Vector3.New(var_94_22.x, var_94_22.y, var_94_22.z)

				local var_94_23 = var_94_15.localEulerAngles

				var_94_23.z = 0
				var_94_23.x = 0
				var_94_15.localEulerAngles = var_94_23
			end

			local var_94_24 = arg_91_1.actors_["10002_tpose"].transform
			local var_94_25 = 0

			if var_94_25 < arg_91_1.time_ and arg_91_1.time_ <= var_94_25 + arg_94_0 then
				arg_91_1.var_.moveOldPos10002_tpose = var_94_24.localPosition
			end

			local var_94_26 = 0.001

			if var_94_25 <= arg_91_1.time_ and arg_91_1.time_ < var_94_25 + var_94_26 then
				local var_94_27 = (arg_91_1.time_ - var_94_25) / var_94_26
				local var_94_28 = Vector3.New(0.7, -1.2, -5.8)

				var_94_24.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10002_tpose, var_94_28, var_94_27)

				local var_94_29 = manager.ui.mainCamera.transform.position - var_94_24.position

				var_94_24.forward = Vector3.New(var_94_29.x, var_94_29.y, var_94_29.z)

				local var_94_30 = var_94_24.localEulerAngles

				var_94_30.z = 0
				var_94_30.x = 0
				var_94_24.localEulerAngles = var_94_30
			end

			if arg_91_1.time_ >= var_94_25 + var_94_26 and arg_91_1.time_ < var_94_25 + var_94_26 + arg_94_0 then
				var_94_24.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_94_31 = manager.ui.mainCamera.transform.position - var_94_24.position

				var_94_24.forward = Vector3.New(var_94_31.x, var_94_31.y, var_94_31.z)

				local var_94_32 = var_94_24.localEulerAngles

				var_94_32.z = 0
				var_94_32.x = 0
				var_94_24.localEulerAngles = var_94_32
			end

			local var_94_33 = 0
			local var_94_34 = 0.85

			if var_94_33 < arg_91_1.time_ and arg_91_1.time_ <= var_94_33 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_35 = arg_91_1:FormatText(StoryNameCfg[10].name)

				arg_91_1.leftNameTxt_.text = var_94_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_36 = arg_91_1:GetWordFromCfg(102092023)
				local var_94_37 = arg_91_1:FormatText(var_94_36.content)

				arg_91_1.text_.text = var_94_37

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_38 = 34
				local var_94_39 = utf8.len(var_94_37)
				local var_94_40 = var_94_38 <= 0 and var_94_34 or var_94_34 * (var_94_39 / var_94_38)

				if var_94_40 > 0 and var_94_34 < var_94_40 then
					arg_91_1.talkMaxDuration = var_94_40

					if var_94_40 + var_94_33 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_40 + var_94_33
					end
				end

				arg_91_1.text_.text = var_94_37
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092023", "story_v_out_102092.awb") ~= 0 then
					local var_94_41 = manager.audio:GetVoiceLength("story_v_out_102092", "102092023", "story_v_out_102092.awb") / 1000

					if var_94_41 + var_94_33 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_41 + var_94_33
					end

					if var_94_36.prefab_name ~= "" and arg_91_1.actors_[var_94_36.prefab_name] ~= nil then
						local var_94_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_36.prefab_name].transform, "story_v_out_102092", "102092023", "story_v_out_102092.awb")

						arg_91_1:RecordAudio("102092023", var_94_42)
						arg_91_1:RecordAudio("102092023", var_94_42)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_102092", "102092023", "story_v_out_102092.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_102092", "102092023", "story_v_out_102092.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_43 = math.max(var_94_34, arg_91_1.talkMaxDuration)

			if var_94_33 <= arg_91_1.time_ and arg_91_1.time_ < var_94_33 + var_94_43 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_33) / var_94_43

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_33 + var_94_43 and arg_91_1.time_ < var_94_33 + var_94_43 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end
	end,
	Play102092024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 102092024
		arg_95_1.duration_ = 19.266

		local var_95_0 = {
			ja = 11.433,
			ko = 19.266,
			zh = 19.266,
			en = 19.266
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
				arg_95_0:Play102092025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10002_tpose"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and arg_95_1.var_.characterEffect10002_tpose == nil then
				arg_95_1.var_.characterEffect10002_tpose = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.1

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect10002_tpose then
					arg_95_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and arg_95_1.var_.characterEffect10002_tpose then
				arg_95_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action423")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_98_6 = 0
			local var_98_7 = 2.075

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[39].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(102092024)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 83
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092024", "story_v_out_102092.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_102092", "102092024", "story_v_out_102092.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_102092", "102092024", "story_v_out_102092.awb")

						arg_95_1:RecordAudio("102092024", var_98_15)
						arg_95_1:RecordAudio("102092024", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_102092", "102092024", "story_v_out_102092.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_102092", "102092024", "story_v_out_102092.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end
	end,
	Play102092025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 102092025
		arg_99_1.duration_ = 11.966

		local var_99_0 = {
			ja = 11.966,
			ko = 7.033,
			zh = 6.433,
			en = 9.033
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
				arg_99_0:Play102092026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = "1019ui_story"

			if arg_99_1.actors_[var_102_0] == nil then
				local var_102_1 = Object.Instantiate(Asset.Load("Char/" .. var_102_0), arg_99_1.stage_.transform)

				var_102_1.name = var_102_0
				var_102_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_[var_102_0] = var_102_1

				local var_102_2 = var_102_1:GetComponentInChildren(typeof(CharacterEffect))

				var_102_2.enabled = true

				local var_102_3 = GameObjectTools.GetOrAddComponent(var_102_1, typeof(DynamicBoneHelper))

				if var_102_3 then
					var_102_3:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_2.transform, false)

				arg_99_1.var_[var_102_0 .. "Animator"] = var_102_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_[var_102_0 .. "Animator"].applyRootMotion = true
				arg_99_1.var_[var_102_0 .. "LipSync"] = var_102_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019action/1019action5_1")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_102_6 = 0
			local var_102_7 = 0.675

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[39].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_9 = arg_99_1:GetWordFromCfg(102092025)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 27
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092025", "story_v_out_102092.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_102092", "102092025", "story_v_out_102092.awb") / 1000

					if var_102_14 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_6
					end

					if var_102_9.prefab_name ~= "" and arg_99_1.actors_[var_102_9.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_9.prefab_name].transform, "story_v_out_102092", "102092025", "story_v_out_102092.awb")

						arg_99_1:RecordAudio("102092025", var_102_15)
						arg_99_1:RecordAudio("102092025", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_102092", "102092025", "story_v_out_102092.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_102092", "102092025", "story_v_out_102092.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_16 and arg_99_1.time_ < var_102_6 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end
	end,
	Play102092026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 102092026
		arg_103_1.duration_ = 3.6

		local var_103_0 = {
			ja = 3.6,
			ko = 2.933,
			zh = 2.7,
			en = 3.233
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play102092027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1019ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and arg_103_1.var_.characterEffect1019ui_story == nil then
				arg_103_1.var_.characterEffect1019ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.1

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1019ui_story then
					arg_103_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and arg_103_1.var_.characterEffect1019ui_story then
				arg_103_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_106_4 = arg_103_1.actors_["10002_tpose"]
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 and arg_103_1.var_.characterEffect10002_tpose == nil then
				arg_103_1.var_.characterEffect10002_tpose = var_106_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_6 = 0.1

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = (arg_103_1.time_ - var_106_5) / var_106_6

				if arg_103_1.var_.characterEffect10002_tpose then
					local var_106_8 = Mathf.Lerp(0, 0.5, var_106_7)

					arg_103_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_103_1.var_.characterEffect10002_tpose.fillRatio = var_106_8
				end
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 and arg_103_1.var_.characterEffect10002_tpose then
				local var_106_9 = 0.5

				arg_103_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_103_1.var_.characterEffect10002_tpose.fillRatio = var_106_9
			end

			local var_106_10 = arg_103_1.actors_["10002_tpose"].transform
			local var_106_11 = 0.033

			if var_106_11 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.var_.moveOldPos10002_tpose = var_106_10.localPosition
			end

			local var_106_12 = 0.5

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_11) / var_106_12
				local var_106_14 = Vector3.New(0.7, -1.2, -5.8)

				var_106_10.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10002_tpose, var_106_14, var_106_13)

				local var_106_15 = manager.ui.mainCamera.transform.position - var_106_10.position

				var_106_10.forward = Vector3.New(var_106_15.x, var_106_15.y, var_106_15.z)

				local var_106_16 = var_106_10.localEulerAngles

				var_106_16.z = 0
				var_106_16.x = 0
				var_106_10.localEulerAngles = var_106_16
			end

			if arg_103_1.time_ >= var_106_11 + var_106_12 and arg_103_1.time_ < var_106_11 + var_106_12 + arg_106_0 then
				var_106_10.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_106_17 = manager.ui.mainCamera.transform.position - var_106_10.position

				var_106_10.forward = Vector3.New(var_106_17.x, var_106_17.y, var_106_17.z)

				local var_106_18 = var_106_10.localEulerAngles

				var_106_18.z = 0
				var_106_18.x = 0
				var_106_10.localEulerAngles = var_106_18
			end

			local var_106_19 = arg_103_1.actors_["10002_tpose"].transform
			local var_106_20 = 0

			if var_106_20 < arg_103_1.time_ and arg_103_1.time_ <= var_106_20 + arg_106_0 then
				arg_103_1.var_.moveOldPos10002_tpose = var_106_19.localPosition
			end

			local var_106_21 = 0.001

			if var_106_20 <= arg_103_1.time_ and arg_103_1.time_ < var_106_20 + var_106_21 then
				local var_106_22 = (arg_103_1.time_ - var_106_20) / var_106_21
				local var_106_23 = Vector3.New(0, -1.2, -5.8)

				var_106_19.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10002_tpose, var_106_23, var_106_22)

				local var_106_24 = manager.ui.mainCamera.transform.position - var_106_19.position

				var_106_19.forward = Vector3.New(var_106_24.x, var_106_24.y, var_106_24.z)

				local var_106_25 = var_106_19.localEulerAngles

				var_106_25.z = 0
				var_106_25.x = 0
				var_106_19.localEulerAngles = var_106_25
			end

			if arg_103_1.time_ >= var_106_20 + var_106_21 and arg_103_1.time_ < var_106_20 + var_106_21 + arg_106_0 then
				var_106_19.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_106_26 = manager.ui.mainCamera.transform.position - var_106_19.position

				var_106_19.forward = Vector3.New(var_106_26.x, var_106_26.y, var_106_26.z)

				local var_106_27 = var_106_19.localEulerAngles

				var_106_27.z = 0
				var_106_27.x = 0
				var_106_19.localEulerAngles = var_106_27
			end

			local var_106_28 = arg_103_1.actors_["1019ui_story"].transform
			local var_106_29 = 0

			if var_106_29 < arg_103_1.time_ and arg_103_1.time_ <= var_106_29 + arg_106_0 then
				arg_103_1.var_.moveOldPos1019ui_story = var_106_28.localPosition
			end

			local var_106_30 = 0.001

			if var_106_29 <= arg_103_1.time_ and arg_103_1.time_ < var_106_29 + var_106_30 then
				local var_106_31 = (arg_103_1.time_ - var_106_29) / var_106_30
				local var_106_32 = Vector3.New(-0.7, -1.08, -5.9)

				var_106_28.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1019ui_story, var_106_32, var_106_31)

				local var_106_33 = manager.ui.mainCamera.transform.position - var_106_28.position

				var_106_28.forward = Vector3.New(var_106_33.x, var_106_33.y, var_106_33.z)

				local var_106_34 = var_106_28.localEulerAngles

				var_106_34.z = 0
				var_106_34.x = 0
				var_106_28.localEulerAngles = var_106_34
			end

			if arg_103_1.time_ >= var_106_29 + var_106_30 and arg_103_1.time_ < var_106_29 + var_106_30 + arg_106_0 then
				var_106_28.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_106_35 = manager.ui.mainCamera.transform.position - var_106_28.position

				var_106_28.forward = Vector3.New(var_106_35.x, var_106_35.y, var_106_35.z)

				local var_106_36 = var_106_28.localEulerAngles

				var_106_36.z = 0
				var_106_36.x = 0
				var_106_28.localEulerAngles = var_106_36
			end

			local var_106_37 = 0

			if var_106_37 < arg_103_1.time_ and arg_103_1.time_ <= var_106_37 + arg_106_0 then
				arg_103_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_106_38 = 0
			local var_106_39 = 0.325

			if var_106_38 < arg_103_1.time_ and arg_103_1.time_ <= var_106_38 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_40 = arg_103_1:FormatText(StoryNameCfg[13].name)

				arg_103_1.leftNameTxt_.text = var_106_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_41 = arg_103_1:GetWordFromCfg(102092026)
				local var_106_42 = arg_103_1:FormatText(var_106_41.content)

				arg_103_1.text_.text = var_106_42

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_43 = 13
				local var_106_44 = utf8.len(var_106_42)
				local var_106_45 = var_106_43 <= 0 and var_106_39 or var_106_39 * (var_106_44 / var_106_43)

				if var_106_45 > 0 and var_106_39 < var_106_45 then
					arg_103_1.talkMaxDuration = var_106_45

					if var_106_45 + var_106_38 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_45 + var_106_38
					end
				end

				arg_103_1.text_.text = var_106_42
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092026", "story_v_out_102092.awb") ~= 0 then
					local var_106_46 = manager.audio:GetVoiceLength("story_v_out_102092", "102092026", "story_v_out_102092.awb") / 1000

					if var_106_46 + var_106_38 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_46 + var_106_38
					end

					if var_106_41.prefab_name ~= "" and arg_103_1.actors_[var_106_41.prefab_name] ~= nil then
						local var_106_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_41.prefab_name].transform, "story_v_out_102092", "102092026", "story_v_out_102092.awb")

						arg_103_1:RecordAudio("102092026", var_106_47)
						arg_103_1:RecordAudio("102092026", var_106_47)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_102092", "102092026", "story_v_out_102092.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_102092", "102092026", "story_v_out_102092.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_48 = math.max(var_106_39, arg_103_1.talkMaxDuration)

			if var_106_38 <= arg_103_1.time_ and arg_103_1.time_ < var_106_38 + var_106_48 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_38) / var_106_48

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_38 + var_106_48 and arg_103_1.time_ < var_106_38 + var_106_48 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end
	end,
	Play102092027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 102092027
		arg_107_1.duration_ = 14.833

		local var_107_0 = {
			ja = 14.833,
			ko = 10.333,
			zh = 11,
			en = 11.1
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
				arg_107_0:Play102092028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10002_tpose"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and arg_107_1.var_.characterEffect10002_tpose == nil then
				arg_107_1.var_.characterEffect10002_tpose = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.1

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect10002_tpose then
					arg_107_1.var_.characterEffect10002_tpose.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and arg_107_1.var_.characterEffect10002_tpose then
				arg_107_1.var_.characterEffect10002_tpose.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["1019ui_story"]
			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 and arg_107_1.var_.characterEffect1019ui_story == nil then
				arg_107_1.var_.characterEffect1019ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_6 = 0.1

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6

				if arg_107_1.var_.characterEffect1019ui_story then
					local var_110_8 = Mathf.Lerp(0, 0.5, var_110_7)

					arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_8
				end
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 and arg_107_1.var_.characterEffect1019ui_story then
				local var_110_9 = 0.5

				arg_107_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1019ui_story.fillRatio = var_110_9
			end

			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action432")
			end

			local var_110_11 = 0

			if var_110_11 < arg_107_1.time_ and arg_107_1.time_ <= var_110_11 + arg_110_0 then
				arg_107_1:PlayTimeline("10002_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_110_12 = 0
			local var_110_13 = 0.925

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_14 = arg_107_1:FormatText(StoryNameCfg[39].name)

				arg_107_1.leftNameTxt_.text = var_110_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_15 = arg_107_1:GetWordFromCfg(102092027)
				local var_110_16 = arg_107_1:FormatText(var_110_15.content)

				arg_107_1.text_.text = var_110_16

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_17 = 37
				local var_110_18 = utf8.len(var_110_16)
				local var_110_19 = var_110_17 <= 0 and var_110_13 or var_110_13 * (var_110_18 / var_110_17)

				if var_110_19 > 0 and var_110_13 < var_110_19 then
					arg_107_1.talkMaxDuration = var_110_19

					if var_110_19 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_19 + var_110_12
					end
				end

				arg_107_1.text_.text = var_110_16
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092027", "story_v_out_102092.awb") ~= 0 then
					local var_110_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092027", "story_v_out_102092.awb") / 1000

					if var_110_20 + var_110_12 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_12
					end

					if var_110_15.prefab_name ~= "" and arg_107_1.actors_[var_110_15.prefab_name] ~= nil then
						local var_110_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_15.prefab_name].transform, "story_v_out_102092", "102092027", "story_v_out_102092.awb")

						arg_107_1:RecordAudio("102092027", var_110_21)
						arg_107_1:RecordAudio("102092027", var_110_21)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_102092", "102092027", "story_v_out_102092.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_102092", "102092027", "story_v_out_102092.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_22 = math.max(var_110_13, arg_107_1.talkMaxDuration)

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_22 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_12) / var_110_22

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_12 + var_110_22 and arg_107_1.time_ < var_110_12 + var_110_22 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end
	end,
	Play102092028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 102092028
		arg_111_1.duration_ = 1.999999999999

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
			arg_111_1.auto_ = false
		end

		function arg_111_1.playNext_(arg_113_0)
			arg_111_1.onStoryFinished_()
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1019ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and arg_111_1.var_.characterEffect1019ui_story == nil then
				arg_111_1.var_.characterEffect1019ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.1

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1019ui_story then
					arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and arg_111_1.var_.characterEffect1019ui_story then
				arg_111_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["10002_tpose"]
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 and arg_111_1.var_.characterEffect10002_tpose == nil then
				arg_111_1.var_.characterEffect10002_tpose = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.1

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6

				if arg_111_1.var_.characterEffect10002_tpose then
					local var_114_8 = Mathf.Lerp(0, 0.5, var_114_7)

					arg_111_1.var_.characterEffect10002_tpose.fillFlat = true
					arg_111_1.var_.characterEffect10002_tpose.fillRatio = var_114_8
				end
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 and arg_111_1.var_.characterEffect10002_tpose then
				local var_114_9 = 0.5

				arg_111_1.var_.characterEffect10002_tpose.fillFlat = true
				arg_111_1.var_.characterEffect10002_tpose.fillRatio = var_114_9
			end

			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019actionlink/1019action456")
			end

			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_114_12 = 0
			local var_114_13 = 0.125

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_14 = arg_111_1:FormatText(StoryNameCfg[13].name)

				arg_111_1.leftNameTxt_.text = var_114_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_15 = arg_111_1:GetWordFromCfg(102092028)
				local var_114_16 = arg_111_1:FormatText(var_114_15.content)

				arg_111_1.text_.text = var_114_16

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 5
				local var_114_18 = utf8.len(var_114_16)
				local var_114_19 = var_114_17 <= 0 and var_114_13 or var_114_13 * (var_114_18 / var_114_17)

				if var_114_19 > 0 and var_114_13 < var_114_19 then
					arg_111_1.talkMaxDuration = var_114_19

					if var_114_19 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_16
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092028", "story_v_out_102092.awb") ~= 0 then
					local var_114_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092028", "story_v_out_102092.awb") / 1000

					if var_114_20 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_12
					end

					if var_114_15.prefab_name ~= "" and arg_111_1.actors_[var_114_15.prefab_name] ~= nil then
						local var_114_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_15.prefab_name].transform, "story_v_out_102092", "102092028", "story_v_out_102092.awb")

						arg_111_1:RecordAudio("102092028", var_114_21)
						arg_111_1:RecordAudio("102092028", var_114_21)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_102092", "102092028", "story_v_out_102092.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_102092", "102092028", "story_v_out_102092.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_22 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_22 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_12) / var_114_22

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_12 + var_114_22 and arg_111_1.time_ < var_114_12 + var_114_22 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/B02c"
	},
	voices = {
		"story_v_out_102092.awb"
	}
}
