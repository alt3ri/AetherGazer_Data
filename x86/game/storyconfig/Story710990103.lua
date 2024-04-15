return {
	Play710990301 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990301
		slot1.duration_ = 1.033399999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990302(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.D999 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.D999
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "D999" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			ComponentBinder.GetInstance():BindCfgUI(uv1, uv0.narrativeGo_)

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				SetActive(uv0.hideBtn_, false)
				SetActive(uv0.narrativeGo_, true)

				uv1.narr_chapter_text.text = uv0:FormatText(uv0:GetWordFromCfg(101).content)
				uv1.narr_time_text.text = uv0:FormatText(uv0:GetWordFromCfg(100012006).content)
				uv0.narrativeListGo_.movementType = ScrollRect.MovementType.Clamped

				if uv0.narrativeListGo_:GetComponent(typeof(Image)) then
					slot8.raycastTarget = false
				end

				SetActive(uv0.narrativeContinueBtn_.gameObject, false)
			end

			slot4 = 0.0334

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 and uv0.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv0.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				-- Nothing
			end

			ComponentBinder.GetInstance():BindCfgUI(uv1, uv0.narrativeGo_)

			if 0.0334 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = Object.Instantiate(uv0.narrativeItemGo_)
				slot7 = slot6:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv1, slot6)

				uv1.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv1.narr_item_content.text = uv0:FormatText(uv0:GetWordFromCfg(710990301).content)

				slot6.transform:SetParent(uv0.narrativeItemGo_.transform.parent)

				slot6.transform.localPosition = Vector3(0, 0, 0)
				slot6.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot6, true)
			end

			slot6 = 1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 and uv0.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv0.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990302 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990302
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990303(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_2")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990302).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990303 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990303
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990304(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990303).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990304 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990304
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990305(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_1")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990304).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990305 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990305
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990306(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990305).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990306 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990306
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990307(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990306).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990307 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990307
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990308(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990307).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990308 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990308
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990309(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990308).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990309 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990309
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990310(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990309).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990310 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990310
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990311(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_6")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990310).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990311 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990311
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990312(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990311).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990312 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990312
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990313(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990312).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990313 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990313
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990314(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990313).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990314 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990314
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990315(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990314).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990315 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990315
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990316(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990315).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990316 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990316
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990317(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990316).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990317 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990317
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990318(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990317).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990318 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990318
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990319(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990318).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990319 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990319
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990320(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990319).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990320 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990320
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710990321(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_2")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990320).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end
		end
	end,
	Play710990321 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710990321
		slot1.duration_ = 1.033399999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
			uv0.auto_ = false
		end

		function slot1.playNext_(slot0)
			uv0.onStoryFinished_()
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710990321).content)

				slot2.transform:SetParent(uv1.narrativeItemGo_.transform.parent)

				slot2.transform.localPosition = Vector3(0, 0, 0)
				slot2.transform.localScale = Vector3(1, 1, 1)

				SetActive(slot2, true)
			end

			slot2 = 1

			if slot1 <= uv1.time_ and uv1.time_ < slot1 + slot2 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot1 + slot2 and uv1.time_ < slot1 + slot2 + slot0 then
				-- Nothing
			end

			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 1 < uv1.time_ and uv1.time_ <= slot3 + slot0 then
				-- Nothing
			end

			slot4 = 0.0334

			if slot3 <= uv1.time_ and uv1.time_ < slot3 + slot4 and uv1.narrativeListGo_.verticalNormalizedPosition >= 0.001 then
				uv1.narrativeListGo_.verticalNormalizedPosition = 0
			end

			if uv1.time_ >= slot3 + slot4 and uv1.time_ < slot3 + slot4 + slot0 then
				uv1.narrativeListGo_.movementType = ScrollRect.MovementType.Elastic

				if uv1.narrativeListGo_:GetComponent(typeof(Image)) then
					slot5.raycastTarget = true
				end

				SetActive(uv1.narrativeContinueBtn_.gameObject, true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/D999"
	},
	voices = {},
	narrativeChapter = 101,
	narrativeTime = 100012006,
	narrativeData = {
		{
			"story_1099",
			710990301
		},
		{
			"story_1019_split_2",
			710990302
		},
		{
			"story_1099",
			710990303
		},
		{
			"story_1019_split_1",
			710990304
		},
		{
			"story_1099",
			710990305
		},
		{
			"story_1099",
			710990306
		},
		{
			"story_1099",
			710990307
		},
		{
			"story_1019_split_4",
			710990308
		},
		{
			"story_1019_split_6",
			710990309
		},
		{
			"story_1019_split_6",
			710990310
		},
		{
			"story_1099",
			710990311
		},
		{
			"story_1099",
			710990312
		},
		{
			"story_1019_split_4",
			710990313
		},
		{
			"story_1099",
			710990314
		},
		{
			"story_1019",
			710990315
		},
		{
			"story_1019",
			710990316
		},
		{
			"story_1099",
			710990317
		},
		{
			"story_1019",
			710990318
		},
		{
			"story_1099",
			710990319
		},
		{
			"story_1019_split_2",
			710990320
		},
		{
			"story_1099",
			710990321
		}
	}
}
