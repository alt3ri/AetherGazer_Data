slot0 = class("FishHook", ReduxView)
slot1 = 70
slot2 = 1
slot3 = 540
slot4 = 1200
slot5 = 1200

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.catchingFishIndex_ = 0

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.angleSpeed_ = 60

	slot0:GetTmpCorners()
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveBuffController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveBuff")
	slot0.oriHeight_ = slot0.hookTransform_.rect.height

	FishGameManager.GetInstance():AddBuffHandler(handler(slot0, slot0.OnBuffChange))
end

function slot0.OnBuffChange(slot0, slot1, slot2, slot3)
	if slot1 == 2 then
		slot0.haveBuffController_:SetSelectedState("true")
	else
		slot0.haveBuffController_:SetSelectedState("false")
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.StartHooking(slot0)
	if not slot0.hooking_ then
		slot0.hooking_ = true

		manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
	end
end

function slot0.Update(slot0, slot1)
	if not slot0.hooking_ then
		FishGameManager.GetInstance():SetStatus("idle")
		slot0:SwitchToAnimatorState("Hook_idle")

		slot2 = slot0.rotaryTransform_.eulerAngles
		slot3 = slot1 * slot0.angleSpeed_ * uv0 + slot2.z
		slot2.z = slot3
		slot0.rotaryTransform_.eulerAngles = slot2

		if slot3 > 0 and slot3 <= 180 then
			if uv1 < slot3 then
				uv0 = -1
			end
		elseif slot3 > 180 and slot3 <= 360 and slot3 - 360 < -uv1 then
			uv0 = 1
		end
	elseif slot0.catchingFishIndex_ >= 1 then
		if slot0.catchingFish_:GetData().fishId == 4 then
			FishGameManager.GetInstance():SetStatus("fail")
		else
			FishGameManager.GetInstance():SetStatus("catch")
		end

		slot0:SwitchToAnimatorState("Hook_catch", function ()
			uv0.catching_ = false
			uv0.animator_.speed = 0
		end)

		if slot0.rotaryTransform_.eulerAngles.z >= 0 and slot2.z < 90 then
			slot3 = slot0.hitImageTransform_.localScale
			slot3.x = 1
			slot0.hitImageTransform_.localScale = slot3
			slot4 = slot0.fishContainer.localScale
			slot4.x = 1
			slot0.fishContainer.localScale = slot4
		else
			slot3 = slot0.hitImageTransform_.localScale
			slot3.x = -1
			slot0.hitImageTransform_.localScale = slot3
			slot4 = slot0.fishContainer.localScale
			slot4.x = -1
			slot0.fishContainer.localScale = slot4
		end

		if not slot0.catching_ then
			slot3 = slot0.hookTransform_.sizeDelta
			slot4 = GameFishCfg[slot0.catchingFish_:GetData().fishId]

			if FishGameManager.GetInstance():GetBuff() == 2 then
				slot3.y = slot3.y - uv2 * slot1
			else
				slot3.y = slot3.y - uv3 * slot1 / (slot4.weight * 0.5)
			end

			if slot3.y <= slot0.oriHeight_ then
				slot3.y = slot0.oriHeight_

				FishGameManager.GetInstance():AddScore(slot4.score)

				if slot0.catchingFish_:GetData().fishId == 6 then
					FishGameManager.GetInstance():RandomBuff()
				elseif slot0.catchingFish_:GetData().fishId == 5 then
					FishGameManager.GetInstance():AddTreasure()
				end

				FishGameManager.GetInstance():CheckEnd()

				slot0.hooking_ = false

				FishGameManager.GetInstance():PlayFishDisappear(slot0.catchingFish_, function (slot0)
					slot0:Dispose()
				end)

				slot0.catchingFish_ = nil
				slot0.catchingFishIndex_ = 0

				manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
			end

			slot0.hookTransform_.sizeDelta = slot3
		end
	elseif slot0.catchingEmpty_ then
		FishGameManager.GetInstance():SetStatus("fail")
		slot0:SwitchToAnimatorState("Hook_catchEmpty", function ()
			uv0.animator_.speed = 0
		end)

		slot2 = slot0.hookTransform_.sizeDelta
		slot2.y = slot2.y - uv3 * slot1

		if slot2.y <= slot0.oriHeight_ then
			slot2.y = slot0.oriHeight_
			slot0.catchingEmpty_ = false
			slot0.hooking_ = false

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
		end

		slot0.hookTransform_.sizeDelta = slot2
	else
		FishGameManager.GetInstance():SetStatus("cast")
		slot0:SwitchToAnimatorState("Hook_cast", function ()
			uv0.animator_.speed = 0
		end)

		slot2 = slot0.hookTransform_.sizeDelta
		slot2.y = slot2.y + uv4 * slot1
		slot0.hookTransform_.sizeDelta = slot2
		slot3, slot4 = slot0:GetHitFish()

		if slot3 > 0 then
			slot5 = slot4:GetData()
			slot0.catchingFishIndex_ = slot3
			slot0.catching_ = true

			slot4.transform_:SetParent(slot0.fishContainer, false)

			slot4.transform_.pivot = Vector2(slot5.pivotX / 100, 1 - slot5.pivotY / 100)
			slot4.transform_.localPosition = Vector2(0, 0)

			FishGameManager.GetInstance():RemoveFish(slot4)

			slot0.catchingFish_ = slot4
		elseif slot0:IsOutOfGameView() then
			slot0.catchingEmpty_ = true

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_up_empty", "")
		end
	end

	if slot0.animator_:GetCurrentAnimatorStateInfo(0):IsName(slot0.curState_) and slot0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 and slot0.handler_ ~= nil then
		slot0.handler_(slot0.curState_)
	end
end

function slot0.SwitchToAnimatorState(slot0, slot1, slot2)
	if slot0.curState_ ~= nil and slot1 == slot0.curState_ then
		return
	end

	slot0.handler_ = slot2
	slot0.curState_ = slot1

	slot0.animator_:Play(slot1, -1, 0)

	slot0.animator_.speed = 1
end

function slot0.IsOutOfGameView(slot0)
	slot1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	slot6 = UnityEngine.RectTransformUtility.WorldToScreenPoint(slot1, slot0.hitGo_.transform:TransformPoint(0, 0, 0)) - UnityEngine.RectTransformUtility.WorldToScreenPoint(slot1, FishGameManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0))
	slot7 = 1080 / Screen.height
	slot8 = (slot7 * slot6).x

	if -(slot7 * slot6).y > 1080 or slot8 < 0 or slot8 > 1920 then
		CustomLog.Log(string.format("out !!!!!!!!!!!!!!!, screenPoint = %s", tostring(slot7 * slot6)))

		return true
	end

	return false
end

function slot0.GetHitFish(slot0)
	slot1, slot2, slot3, slot4 = slot0:GetScreenCorners(slot0.hitGo_.transform)

	for slot9, slot10 in ipairs(FishGameManager.GetInstance():GetFishes()) do
		slot11 = slot10:GetData()
		slot12, slot13, slot14, slot15 = slot0:GetScreenCorners(slot10.hitArea_)

		if slot0:HitCheckObb(slot1, slot2, slot3, slot4, slot12, slot13, slot14, slot15) then
			return slot9, slot10
		end
	end

	return 0
end

function slot0.GetScreenCorners(slot0, slot1)
	slot2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	slot1:GetWorldCorners(slot0.corners)

	return UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[0]), UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[1]), UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[2]), UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[3])
end

function slot0.HitCheckObb(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot10 = (slot1 + slot3) / 2
	slot11 = (slot5 + slot7) / 2
	slot12 = Vector2.New(slot10.x - slot11.x, slot10.y - slot11.y)
	slot13 = Vector2.New(slot1.x - slot10.x, slot1.y - slot10.y)
	slot14 = Vector2.New(slot2.x - slot10.x, slot2.y - slot10.y)
	slot15 = Vector2.New(slot5.x - slot11.x, slot5.y - slot11.y)
	slot16 = Vector2.New(slot6.x - slot11.x, slot6.y - slot11.y)
	slot17 = false

	for slot21, slot22 in ipairs({
		Vector2.Normalize(slot2 - slot1),
		Vector2.Normalize(slot3 - slot2),
		Vector2.Normalize(slot6 - slot5),
		Vector2.Normalize(slot7 - slot6)
	}) do
		if math.abs(slot22.x * slot12.x + slot22.y * slot12.y) > math.max(math.abs(slot22.x * slot13.x + slot22.y * slot13.y), math.abs(slot22.x * slot14.x + slot22.y * slot14.y)) + math.max(math.abs(slot22.x * slot15.x + slot22.y * slot15.y), math.abs(slot22.x * slot16.x + slot22.y * slot16.y)) then
			slot17 = true

			break
		end
	end

	return not slot17
end

function slot0.GetTmpCorners(slot0)
	if slot0.corners == nil then
		slot0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function slot0.Reset(slot0)
	if slot0.catchingFish_ then
		slot0.catchingFish_:Dispose()

		slot0.catchingFish_ = nil
	end

	if slot0.hookTransform_.sizeDelta.y <= slot0.oriHeight_ then
		slot1.y = slot0.oriHeight_
	end

	slot0.hooking_ = false
	slot0.catchingFishIndex_ = 0
	slot0.hookTransform_.sizeDelta = slot1
	slot2 = slot0.rotaryTransform_.eulerAngles
	slot2.z = 0
	slot0.rotaryTransform_.eulerAngles = slot2
end

function slot0.Dispose(slot0)
	if slot0.catchingFish_ then
		slot0.catchingFish_:Dispose()

		slot0.catchingFish_ = nil
	end

	if slot0.hookTransform_.sizeDelta.y <= slot0.oriHeight_ then
		slot1.y = slot0.oriHeight_
	end

	slot0.hookTransform_.sizeDelta = slot1

	uv0.super.Dispose(slot0)
end

return slot0
