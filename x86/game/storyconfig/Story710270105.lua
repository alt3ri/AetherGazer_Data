return {
	Play710270501 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270501
		slot1.duration_ = 4.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270502(uv1)
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

				uv1.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv1.narr_item_content.text = uv0:FormatText(uv0:GetWordFromCfg(710270501).content)

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
	Play710270502 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270502
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270503(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270502).content)

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
	Play710270503 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270503
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270504(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270503).content)

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
	Play710270504 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270504
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270505(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)
				SetActive(uv0.narr_item_head.transform.parent.gameObject, false)

				slot6 = slot2.transform:Find("container/b")
				slot7 = slot2.transform:Find("container/text")

				if slot2.transform:Find("container/a") and slot6 and slot7 then
					SetActive(slot5.gameObject, false)
					SetActive(slot6.gameObject, false)
					SetActive(slot7.gameObject, false)
				end

				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270504).content)

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
	Play710270505 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270505
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270506(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270505).content)

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
	Play710270506 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270506
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270507(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270506).content)

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
	Play710270507 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270507
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270508(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270507).content)

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
	Play710270508 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270508
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270509(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270508).content)

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
	Play710270509 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270509
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270510(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)
				SetActive(uv0.narr_item_head.transform.parent.gameObject, false)

				slot6 = slot2.transform:Find("container/b")
				slot7 = slot2.transform:Find("container/text")

				if slot2.transform:Find("container/a") and slot6 and slot7 then
					SetActive(slot5.gameObject, false)
					SetActive(slot6.gameObject, false)
					SetActive(slot7.gameObject, false)
				end

				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270509).content)

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
	Play710270510 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270510
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270511(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270510).content)

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
	Play710270511 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270511
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270512(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270511).content)

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
	Play710270512 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270512
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270513(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270512).content)

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
	Play710270513 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270513
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270514(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270513).content)

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
	Play710270514 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270514
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270515(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270514).content)

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
	Play710270515 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270515
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play710270516(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270515).content)

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
	Play710270516 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 710270516
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

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(710270516).content)

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
			"story_1081",
			710270501
		},
		{
			"story_1027",
			710270502
		},
		{
			"story_1081",
			710270503
		},
		{
			"",
			710270504
		},
		{
			"story_1081",
			710270505
		},
		{
			"story_1027",
			710270506
		},
		{
			"story_1081",
			710270507
		},
		{
			"story_1027",
			710270508
		},
		{
			"",
			710270509
		},
		{
			"story_1027",
			710270510
		},
		{
			"story_1081",
			710270511
		},
		{
			"story_1027",
			710270512
		},
		{
			"story_1081",
			710270513
		},
		{
			"story_1027",
			710270514
		},
		{
			"story_1081",
			710270515
		},
		{
			"story_1081",
			710270516
		}
	}
}
