DormRhythmItemTemplate = class("DormRhythmItemTemplate")

function DormRhythmItemTemplate.Ctor(slot0, slot1, slot2, slot3)
	if slot1 then
		slot0.go = Object.Instantiate(slot1.itemGo, slot1.parentTrs)
		slot0.trs = slot0.go.transform

		slot0.trs:SetAsFirstSibling()

		slot0.parentTrs = slot1.parentTrs
		slot0.index = slot2.index
		slot0.controller = ControllerUtil.GetController(slot0.trs, "state")
		slot0.type = slot2.type

		if slot0.type == 1 then
			slot0.controller:SetSelectedState("left")
		elseif slot0.type == 2 then
			slot0.controller:SetSelectedState("right")
		end

		slot0.totalNum = slot2.totalNum

		slot0:SetInitialPosition()

		slot0.effectTrs = slot0.trs:Find("effect_glow").gameObject:GetComponent("RectTransform")
		slot4, slot5 = DormRhythmGameData:GetDeterLength()
		slot6 = math.random(slot4[1], slot4[2]) * 10
		slot0.rectTransform = slot0.go:GetComponent("RectTransform")
		slot0.rectTransform.sizeDelta = Vector2(slot6, slot0.trs.rect.height)
		slot0.effectTrs.localScale = Vector3((slot6 + 40) / 140, 1, 1)
		slot0.effectController = ControllerUtil.GetController(slot0.trs, "effect")
		slot0.stageCfg = slot3
	else
		print("传入对象数据错误")
	end
end

function DormRhythmItemTemplate.Tick(slot0)
	if slot0.go then
		slot0:UpdatePos()
	end
end

function DormRhythmItemTemplate.SetInitialPosition(slot0)
	if slot0.trs then
		slot0.trs.localPosition = Vector3(slot0.parentTrs.rect.width / 2, 0, 0)
	end
end

function DormRhythmItemTemplate.UpdatePos(slot0)
	if slot0.trs then
		slot0.trs.localPosition = Vector3.New(slot0.trs.localPosition.x - DormRhythmGameData:GetGameSpeed(), slot0.trs.localPosition.y, 0)

		if slot0.trs.localPosition.x <= -slot0.parentTrs.rect.width / 2 then
			DormRhythmGameData:DisPoseItem(slot0.index)

			return
		end

		if slot0.trs.localPosition.x < 0 - DormRhythmGameData:GetJudgeWidth() / 2 and not slot0.hasCheck then
			slot0.hasCheck = true
			slot3 = slot0:IsLast()

			if not slot0.hasHit then
				DormRhythmGameData:UpdateBatterNum(false, slot3)
			end

			if slot3 then
				manager.notify:Invoke(BREAK_GAME_LAST_SUCCESS)
			end
		end
	end
end

function DormRhythmItemTemplate.IsLast(slot0)
	return slot0.totalNum == slot0.stageCfg[DormRhythmGameData:GetLevelData().levelID].total_check
end

function DormRhythmItemTemplate.CheckHit(slot0, slot1)
	slot3 = slot1.judgeWidth

	if slot0.trs then
		if slot0.trs.localPosition.x >= slot3 / 2 and slot0.trs.localPosition.x - slot0.trs.rect.width <= -slot3 / 2 then
			if slot1.buttonType ~= slot0.type then
				return false, true
			else
				if not slot0.hasHit then
					slot0.effectController:SetSelectedState("none")

					if slot0.type == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
						slot0.effectController:SetSelectedState("blue")
					else
						slot0.effectController:SetSelectedState("red")
					end
				end

				return true, true
			end
		end

		return false
	end
end

function DormRhythmItemTemplate.Dispose(slot0)
	Object.Destroy(slot0.go)

	slot0.go = nil
	slot0.trs = nil
end
