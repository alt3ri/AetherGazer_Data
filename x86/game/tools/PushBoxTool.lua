slot1 = 99
slot2 = GameDisplayCfg.activity_celebration_grid_max_length.value[1]
slot3 = GameDisplayCfg.activity_celebration_box_speed and GameDisplayCfg.activity_celebration_box_speed.value[1] or 0.5
slot4 = 0
slot5 = 0

return {
	GetFatigueID = function (slot0, slot1)
		for slot6, slot7 in ipairs(GameSetting.activity_fatigue_info.value) do
			if slot7[1] == slot1 then
				return slot7[2]
			end
		end
	end,
	GetFatigueMax = function (slot0, slot1)
		slot2 = 0

		for slot7, slot8 in ipairs(GameSetting.activity_celebration_cake_fatigue_default.value) do
			if slot8[1] == slot1 then
				slot2 = slot8[2]

				break
			end
		end

		return slot2
	end,
	SetStartTime = function (slot0)
		uv0 = manager.time:GetServerTime()
	end,
	SendSdk = function (slot0, slot1, slot2, slot3)
		uv0 = manager.time:GetServerTime()

		SDKTools.SendMessageToSDK("activity_combat_over", {
			activity_id = slot1,
			stage_id = slot2,
			result = slot3,
			use_seconds = uv0 - uv1
		})
	end,
	Init = function (slot0)
		if slot0.isInit_ then
			return
		end

		slot0.isInit_ = true
		slot0.boxItem_ = {}
		slot0.cellItem_ = {}
		slot0.mapSize_ = 1
		slot0.mapWidth_ = 1
		slot0.mapHeight_ = 1
		slot0.cellWidth_ = 1
		slot0.actionCnt_ = 0
		slot0.routhMap_ = {}
		slot0.dirMap_ = {}
		slot0.tween_ = nil
		slot0.goalTbl_ = {}
	end,
	InitMap = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		slot0:Init()

		slot7 = ActivityCelebrationGameCfg[slot1]
		slot0.mapWidth_ = slot7.width
		slot0.mapHeight_ = slot7.height
		slot0.mapSize_ = slot0.mapWidth_ * slot0.mapHeight_
		slot0.cellWidth_ = slot4.rect.width / slot0.mapWidth_ < slot4.rect.height / slot0.mapHeight_ and slot10 or slot11
		slot0.cellWidth_ = uv0 < slot0.cellWidth_ and uv0 or slot0.cellWidth_
		slot2:GetComponent("GridLayoutGroup").cellSize = Vector2.New(slot0.cellWidth_, slot0.cellWidth_)
		slot2.sizeDelta = Vector2.New(slot0.mapWidth_ * slot0.cellWidth_, slot0.mapHeight_ * slot0.cellWidth_)
		slot3.sizeDelta = Vector2.New(slot0.mapWidth_ * slot0.cellWidth_, slot0.mapHeight_ * slot0.cellWidth_)
		slot13 = {}

		for slot18, slot19 in ipairs(ActivityCelebrationBoxCfg.get_id_list_by_mapId[slot7.mapId]) do
			slot20 = ActivityCelebrationBoxCfg[slot19]

			table.insert(slot13, {
				slot20.x + (slot20.y - 1) * slot0.mapWidth_,
				slot20.type
			})
		end

		table.sort(slot13, function (slot0, slot1)
			return slot0[1] < slot1[1]
		end)

		slot0.goalTbl_ = {}
		slot15 = 1

		for slot20 = 1, slot0.mapWidth_ * slot0.mapHeight_ do
			if not slot0.cellItem_[slot20] then
				slot0.cellItem_[slot20] = PushBoxCellItem.New(Object.Instantiate(slot5, slot2))
			end

			slot21 = slot20 % slot0.mapWidth_ == 0 and slot0.mapWidth_ or slot20 % slot0.mapWidth_
			slot22 = slot20 % slot0.mapWidth_ == 0 and slot20 / slot0.mapWidth_ or math.floor(slot20 / slot0.mapWidth_) + 1
			slot23 = PushBoxConst.CELL_TYPE.NORMAL

			if slot13[slot15] and slot13[slot15][1] == slot20 then
				slot23 = slot13[slot15][2]
				slot15 = slot15 + 1
			end

			if slot23 == PushBoxConst.CELL_TYPE.GOAL then
				table.insert(slot0.goalTbl_, slot20)
			end

			slot0.cellItem_[slot20]:SetData(slot21, slot22, slot23)
			SetActive(slot0.cellItem_[slot20].gameObject_, true)
		end

		for slot20 = slot16 + 1, #slot0.cellItem_ do
			SetActive(slot0.cellItem_[slot20].gameObject_, false)
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot2)

		for slot21, slot22 in ipairs(slot7.box_list) do
			if not slot0.boxItem_[slot21] then
				slot0.boxItem_[slot21] = PushBoxItem.New(Object.Instantiate(slot6, slot3))
			end

			slot0.boxItem_[slot21]:SetSize(slot0.cellWidth_)
			slot0:SyncBoxPosition(slot21, slot22[1], slot22[2])
			slot0.boxItem_[slot21]:SetData(slot21)
			SetActive(slot0.boxItem_[slot21].gameObject_, true)
		end

		for slot21 = #slot17 + 1, #slot0.boxItem_ do
			SetActive(slot0.boxItem_[slot21].gameObject_, false)
		end

		return slot0.boxItem_, slot0.cellItem_, slot0.goalTbl_
	end,
	GetCellIndex = function (slot0, slot1, slot2)
		return slot0.mapWidth_ * (slot2 - 1) + slot1
	end,
	SyncBoxPosition = function (slot0, slot1, slot2, slot3)
		slot5, slot6 = slot0.cellItem_[slot0:GetCellIndex(slot2, slot3)]:GetLoaclPosition()

		slot0.boxItem_[slot1]:SetPos(slot2, slot3, slot5, slot6)
	end,
	OperateMove = function (slot0, slot1, slot2, slot3)
		slot0.actionCnt_ = 0
		slot0.routhMap_ = {}
		slot0.dirMap_ = {}
		slot4, slot5 = slot0.boxItem_[slot3]:GetCoordinate()

		if slot0:CalMove(slot4, slot5, slot1, slot2) then
			if #slot0.routhMap_ <= 1 then
				manager.notify:Invoke(PUSH_BOX_STOP)

				return
			end

			manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carmove")
			slot0:AniMove(2, slot3)
		end
	end,
	CalMove = function (slot0, slot1, slot2, slot3, slot4)
		slot0.actionCnt_ = slot0.actionCnt_ + 1

		table.insert(slot0.routhMap_, {
			slot1,
			slot2
		})
		table.insert(slot0.dirMap_, {
			slot3,
			slot4
		})

		if slot0.cellItem_[slot0:GetCellIndex(slot1, slot2)]:GetType() == PushBoxConst.CELL_TYPE.GOAL and slot0.actionCnt_ > 1 then
			return true
		end

		if uv0 <= slot0.actionCnt_ then
			error("路径过长")

			return false
		end

		slot8 = slot1 + slot3
		slot10 = slot0:GetCellIndex(slot8, slot2 + slot4)

		if slot8 < 1 or slot9 < 1 or slot0.mapWidth_ < slot8 or slot0.mapHeight_ < slot9 then
			return true
		end

		slot11 = slot0.cellItem_[slot10]

		if slot11:IsCanPass() then
			slot6:ActionPass()

			if slot11:GetType() == PushBoxConst.CELL_TYPE.UP_SLIDER then
				return slot0:CalMove(slot8, slot9, 0, -1)
			elseif slot13 == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
				return slot0:CalMove(slot8, slot9, 0, 1)
			elseif slot13 == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
				return slot0:CalMove(slot8, slot9, -1, 0)
			elseif slot13 == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
				return slot0:CalMove(slot8, slot9, 1, 0)
			else
				return slot0:CalMove(slot8, slot9, slot3, slot4)
			end
		else
			return true
		end
	end,
	AniMove = function (slot0, slot1, slot2)
		slot0:RemoveTween()
		slot0.boxItem_[slot2]:PlayDirct(slot0.dirMap_[slot1 - 1])

		slot3 = slot0:GetCellIndex(slot0.routhMap_[slot1][1], slot0.routhMap_[slot1][2])

		slot0.cellItem_[slot3]:OnReadyEnter()

		slot4, slot5 = slot0.cellItem_[slot3]:GetLoaclPosition()
		slot0.tween_ = LeanTween.moveLocal(slot0.boxItem_[slot2].gameObject_, Vector3.New(slot4, slot5, 0), uv0):setEase(LeanTweenType.linear):setOnComplete(LuaHelper.VoidAction(function ()
			uv0.cellItem_[uv0:GetCellIndex(uv0.routhMap_[uv1 - 1][1], uv0.routhMap_[uv1 - 1][2])]:OnPass()

			if uv1 == #uv0.routhMap_ then
				uv0:RemoveTween()
				uv0.boxItem_[uv2]:StopAni()

				slot1, slot2 = uv0.cellItem_[uv3]:GetPos()

				uv0.boxItem_[uv2]:SetPos(slot1, slot2, uv4, uv5)

				if uv0.cellItem_[uv3]:GetType() == PushBoxConst.CELL_TYPE.GOAL then
					manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_success")
				end

				manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_carstop")
				manager.notify:Invoke(PUSH_BOX_STOP)

				return
			end

			uv0:AniMove(uv1 + 1, uv2)
		end))
	end,
	GetCanPassDir = function (slot0, slot1)
		slot2, slot3 = slot0.boxItem_[slot1]:GetCoordinate()

		return slot0:CheckCanPass(slot2, slot3, 0, -1), slot0:CheckCanPass(slot2, slot3, 0, 1), slot0:CheckCanPass(slot2, slot3, -1, 0), slot0:CheckCanPass(slot2, slot3, 1, 0)
	end,
	CheckCanPass = function (slot0, slot1, slot2, slot3, slot4)
		slot6 = slot0.cellItem_[slot0:GetCellIndex(slot1, slot2)]
		slot7 = slot1 + slot3
		slot9 = slot0:GetCellIndex(slot7, slot2 + slot4)

		if slot7 < 1 or slot8 < 1 or slot0.mapWidth_ < slot7 or slot0.mapHeight_ < slot8 then
			return false
		end

		return slot0.cellItem_[slot9]:IsCanPass()
	end,
	RemoveTween = function (slot0)
		if slot0.tween_ then
			slot0.tween_:setOnComplete(nil)
			LeanTween.cancel(slot0.tween_.id)

			slot0.tween_ = nil
		end
	end,
	OnExit = function (slot0)
	end,
	Dispose = function (slot0)
		slot0.cellItem_ = {}
		slot0.boxItem_ = {}
		slot0.isInit_ = false
	end
}
