slot0 = class("DanceGameDanmakuSubView", BaseView)
slot1 = class("DanceGameDanmakuSubView")

function slot1.Ctor(slot0, slot1, slot2, slot3)
	slot0.kp = slot1
	slot0.ki = slot2 or 0
	slot0.kd = slot3 or 0
	slot0.v = 0
	slot0.expect = 0
	slot0.pause = 0
end

function slot1.Update(slot0, slot1)
	if slot0.pause <= 0 then
		if (slot0.monitorValue and slot0.monitorValue() or slot0.v) - slot0.expect > 0 then
			slot4 = -(slot0.kp * slot1 * math.random())
		elseif slot3 == 0 then
			slot4 = (math.random() * 2 - 1) * slot1
		end

		slot0.v = slot4 + slot0.v
	end

	slot0.pause = slot0.pause - slot1
end

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.pool = {}
	slot0.danmaku = {}
	slot0.ticker = nil
	slot0.danmakuAmountControl = uv0.New(1.5)

	function slot0.danmakuAmountControl.monitorValue()
		return #uv0.danmaku
	end

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	slot0:ClearAllDanmaku()

	for slot4, slot5 in pairs(slot0.pool) do
		Object.Destroy(slot5.obj)
	end

	slot0.danmaku = nil
	slot0.pool = nil
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0:StopUpdateTicker()
end

function slot0.Update(slot0, slot1)
	slot0:UpdateActiveDanmaku(slot1)
	slot0:UpdateGenDanmakuTask(slot1)
end

function slot0.StartUpdateTicker(slot0)
	slot0:StopUpdateTicker()

	slot1 = Time.time
	slot0.ticker = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		slot0 = Time.time

		uv1:Update(slot0 - uv0)

		uv0 = slot0
	end, -1, true)
end

function slot0.StopUpdateTicker(slot0)
	if slot0.ticker then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.ticker)

		slot0.ticker = nil
	end
end

function slot2(slot0, slot1)
	return slot0.anchoredPosition.x >= 0 and slot3.y <= slot0.rect.height and slot3.y > -slot1.rect.height
end

function slot3(slot0, slot1)
	slot2 = slot0.obj.transform
	slot2.anchoredPosition = slot2.anchoredPosition + Vector2.left * slot1 * slot0.speed
end

function slot0.UpdateActiveDanmaku(slot0, slot1)
	for slot5, slot6 in pairs(slot0.danmaku) do
		if uv0(slot6.obj.transform, slot0.viewport_) then
			slot7 = slot6.speed

			uv1(slot6, slot1)
		else
			slot0:RecycleDanmaku(slot6)

			slot0.danmaku[slot5] = nil
		end
	end
end

function slot0.ClaimDanmakuFromPool(slot0)
	if slot0.pool[1] then
		return table.remove(slot0.pool)
	end

	slot1 = Object.Instantiate(slot0.danmakuPrefab_, slot0.viewport_)

	return {
		speed = 1,
		active = false,
		obj = slot1,
		text = slot1:GetComponent("Text")
	}
end

function slot0.ClearAllDanmaku(slot0)
	for slot4, slot5 in pairs(slot0.danmaku) do
		slot0:RecycleDanmaku(slot5)

		slot0.danmaku[slot4] = nil
	end
end

function slot0.RecycleDanmaku(slot0, slot1)
	slot1.active = false

	SetActive(slot1.obj, false)
	table.insert(slot0.pool, slot1)
end

function slot0.GenDanmaku(slot0, slot1, slot2)
	slot3 = slot0:ClaimDanmakuFromPool()

	SetActive(slot3.obj, true)

	slot3.text.text = slot1
	slot3.speed = slot2

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot3.obj.transform)
	slot0:ArrangeDanmaku(slot3)

	slot3.active = true

	table.insert(slot0.danmaku, slot3)
end

function slot0.ArrangeDanmaku(slot0, slot1)
	slot2 = slot1.obj.transform
	slot3 = slot2.rect.width
	slot4 = slot2.rect.height

	for slot11 = 0.25 * slot4 * math.random(), slot0.viewport_.rect.height - slot4, 1.1 * slot4 do
		table.insert({}, {
			weight = 0,
			y = -slot11
		})
	end

	for slot11, slot12 in pairs(slot0.danmaku) do
		slot13 = slot12.obj.transform
		slot14 = slot13.anchoredPosition

		for slot20, slot21 in pairs(slot7) do
			if slot21.y <= slot14.y + slot4 and slot22 >= slot14.y - slot13.rect.height - slot4 then
				slot21.weight = slot21.weight + slot13.rect.width
			end
		end
	end

	CommonTools.UniversalSortEx(slot7, {
		ascend = true,
		map = function (slot0)
			return slot0.weight
		end
	}, {
		map = function (slot0)
			return slot0.y
		end
	})

	slot2.anchoredPosition = Vector2(slot0.viewport_.rect.width + slot3, slot7[1].y)
end

function slot0.SetDanmakuFilter(slot0, slot1)
	slot0.danmakuFilter = slot1
end

slot4 = 2

function slot0.UpdateGenDanmakuTask(slot0, slot1)
	slot0.danmakuAmountControl:Update(slot1)

	slot3 = 0
	slot4 = nil
	slot4 = (not slot0.danmakuFilter or IdolBulletComment.get_id_list_by_comment_type[slot0.danmakuFilter]) and IdolBulletComment.all

	if math.min(uv0, math.round(slot0.danmakuAmountControl.v) - #slot0.danmaku) > 0 then
		slot6 = IdolBulletComment[slot4[math.random(slot4 and #slot4 or 0)]]

		slot0:GenDanmaku(slot6.comment_desc, slot6.comment_speed * 100)

		slot0.danmakuAmountControl.pause = 1 / slot2 * math.random()
	end
end

function slot0.SetExpectDanmakuAmount(slot0, slot1)
	slot0.danmakuAmountControl.expect = slot1
end

return slot0
