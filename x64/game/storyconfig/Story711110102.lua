return {
	Play711110201 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110201
		slot1.duration_ = 1.033399999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110202(uv1)
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

				uv1.narr_chapter_text.text = uv0:FormatText(uv0:GetWordFromCfg(100).content)
				uv1.narr_time_text.text = uv0:FormatText(uv0:GetWordFromCfg(100).content)
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

				uv1.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")
				uv1.narr_item_content.text = uv0:FormatText(uv0:GetWordFromCfg(711110201).content)

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
	Play711110202 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110202
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110203(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110202).content)

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
	Play711110203 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110203
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110204(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110203).content)

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
	Play711110204 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110204
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110205(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110204).content)

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
	Play711110205 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110205
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110206(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110205).content)

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
	Play711110206 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110206
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110207(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110206).content)

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
	Play711110207 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110207
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110208(uv1)
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

				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110207).content)

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
	Play711110208 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110208
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110209(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110208).content)

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
	Play711110209 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110209
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110210(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110209).content)

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
	Play711110210 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110210
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110211(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110210).content)

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
	Play711110211 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110211
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110212(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110211).content)

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
	Play711110212 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110212
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110213(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110212).content)

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
	Play711110213 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110213
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110214(uv1)
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

				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110213).content)

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
	Play711110214 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110214
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110215(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110214).content)

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
	Play711110215 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110215
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110216(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110215).content)

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
	Play711110216 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110216
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110217(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110216).content)

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
	Play711110217 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110217
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110218(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110217).content)

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
	Play711110218 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110218
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110219(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110218).content)

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
	Play711110219 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110219
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110220(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110219).content)

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
	Play711110220 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110220
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110221(uv1)
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

				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110220).content)

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
	Play711110221 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110221
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110222(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110221).content)

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
	Play711110222 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110222
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110223(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110222).content)

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
	Play711110223 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110223
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110224(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110223).content)

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
	Play711110224 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110224
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110225(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110224).content)

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
	Play711110225 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110225
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play711110226(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			ComponentBinder.GetInstance():BindCfgUI(uv0, uv1.narrativeGo_)

			if 0 < uv1.time_ and uv1.time_ <= slot1 + slot0 then
				slot2 = Object.Instantiate(uv1.narrativeItemGo_)
				slot3 = slot2:GetComponent("ComponentCfger")

				ComponentBinder.GetInstance():BindCfgUI(uv0, slot2)

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110225).content)

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
	Play711110226 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 711110226
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

				uv0.narr_item_head.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")
				uv0.narr_item_content.text = uv1:FormatText(uv1:GetWordFromCfg(711110226).content)

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
	narrativeChapter = 100,
	narrativeTime = 100,
	narrativeData = {
		{
			"story_1011",
			711110201
		},
		{
			"story_1028",
			711110202
		},
		{
			"story_1011",
			711110203
		},
		{
			"story_1028",
			711110204
		},
		{
			"story_1011",
			711110205
		},
		{
			"story_1028",
			711110206
		},
		{
			"",
			711110207
		},
		{
			"story_1011",
			711110208
		},
		{
			"story_1028",
			711110209
		},
		{
			"story_1111",
			711110210
		},
		{
			"story_1011",
			711110211
		},
		{
			"story_1111",
			711110212
		},
		{
			"",
			711110213
		},
		{
			"story_1028",
			711110214
		},
		{
			"story_1111",
			711110215
		},
		{
			"story_1028",
			711110216
		},
		{
			"story_1111",
			711110217
		},
		{
			"story_1028",
			711110218
		},
		{
			"story_1111",
			711110219
		},
		{
			"",
			711110220
		},
		{
			"story_1111",
			711110221
		},
		{
			"story_1028",
			711110222
		},
		{
			"story_1111",
			711110223
		},
		{
			"story_1028",
			711110224
		},
		{
			"story_1111",
			711110225
		},
		{
			"story_1028",
			711110226
		}
	}
}
