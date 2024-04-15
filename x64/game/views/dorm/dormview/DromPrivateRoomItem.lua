slot0 = class("DromPrivateRoomItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.publicHeroScroll = LuaList.New(handler(slot0, slot0.indexHeroItem), slot0.uilistGo_, BackHomeNewHeroItem)
	slot0.publicStateController = ControllerUtil.GetController(slot0.transform_, "roomType")
	slot0.emptyController = ControllerUtil.GetController(slot0.uilistGo_.transform, "empty")
	slot0.publicVisitController = ControllerUtil.GetController(slot0.publicGo_.transform, "visit")
	slot0.floorAniamtion = slot0.dimianGo_:GetComponent("Animation")
	slot0.edit = false
	slot0.time = 2 / GameDisplayCfg.dorm_area_swap_speed.value[1]

	slot0:InitPrivateRoomItemInfo()
	slot0:RegisterEvents()
	slot0:AddUIListener()
end

function slot0.InitPrivateRoomItemInfo(slot0)
	slot0.itemPosition = {}
	slot0.item = {}

	for slot4 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot0.item[slot4] = DormRoomItem.New(slot0["item" .. slot4 .. "Go_"])

		slot0.item[slot4]:SetPosAndRoomID(slot4)
		slot0:AddBtnCallBack(slot0.item[slot4])

		slot0.itemPosition[slot4] = {
			has = true,
			pos = Vector3.New(slot0.item[slot4].transform_.localPosition.x, slot0.item[slot4].transform_.localPosition.y, slot0.item[slot4].transform_.localPosition.z)
		}
	end

	slot0.itemPosition[1].slibing = 6
	slot0.itemPosition[2].slibing = 2
	slot0.itemPosition[3].slibing = 5
	slot0.itemPosition[4].slibing = 7
	slot0.itemPosition[5].slibing = 3
	slot0.itemPosition[6].slibing = 1
	slot0.itemPosition[7].slibing = 4
	slot0.itemPosition[8].slibing = 8
	slot0.itemPosition[9].slibing = 8
	slot0.itemPosition[10].slibing = 8
	slot0.itemPosition[11].slibing = 8

	for slot4 = 1, DormConst.DORM_FIRST_FLOOR_ROOM_NUM do
		slot0.item[slot4].transform_:SetSiblingIndex(slot0.itemPosition[slot4].slibing)
	end
end

function slot0.OnBehind(slot0)
	slot0:SetItemCanvasSortOrder(false)
end

function slot0.SetItemCanvasSortOrder(slot0, slot1)
	if slot0.item then
		for slot5, slot6 in ipairs(slot0.item) do
			if slot6.curPos ~= 5 then
				slot6.textCanvas.overrideSorting = slot1

				if slot1 then
					slot6.textCanvas.sortingOrder = 1
				end
			end
		end
	end
end

function slot0.OnEnter(slot0)
	if manager.guide:IsPlaying() then
		slot0:SetItemCanvasSortOrder(false)
	else
		slot0:SetItemCanvasSortOrder(true)
	end
end

function slot0.OnTop(slot0)
	if manager.guide:IsPlaying() then
		slot0:SetItemCanvasSortOrder(false)
	else
		slot0:SetItemCanvasSortOrder(true)
	end
end

function slot0.OnUpdate(slot0)
end

function slot0.StartGuide(slot0)
	if manager.guide:IsPlaying() then
		slot0:SetItemCanvasSortOrder(false)
	else
		slot0:SetItemCanvasSortOrder(true)
	end
end

function slot0.OnExit(slot0)
	slot0:SetItemCanvasSortOrder(false)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.floor = slot1

	if slot1 == GameDisplayCfg.dorm_lobby_layer.value[1] then
		slot0.publicStateController:SetSelectedState("public")
		slot0:RefreshPublicRoomHeroList()
	else
		slot0.publicStateController:SetSelectedState("private")
	end

	slot0:InitRoomPos()

	for slot5 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot0.item[slot5]:RefreshItemState()
	end
end

function slot0.InitRoomPos(slot0)
	for slot4 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		slot5 = slot0.item[slot4].curPos

		slot0.item[slot4]:SetPosAndRoomID(slot5, DormitoryData:GetRoomIDByPosID(slot0:ChangItemPosToServerPosID(slot5)))
	end
end

function slot0.AddBtnCallBack(slot0, slot1)
	slot1:ClickItemCallBack(handler(slot0, slot0.ClickRoom))
	slot1:StartDrag(handler(slot0, slot0.StartDrag))
	slot1:OnDrag(handler(slot0, slot0.OnDrag))
	slot1:EndDrag(handler(slot0, slot0.EndDrag))
	slot1:ChangePosition(handler(slot0, slot0.RayPoint))
end

function slot0.ClickRoom(slot0, slot1, slot2)
	if not slot0.edit then
		slot0.selPos = slot2

		if slot1 then
			if DormData:GetCurrectSceneID() == slot1 then
				JumpTools.OpenPageByJump("/dorm")

				return
			end

			if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				BackHomeTools:GotoBackHomeRoom(slot1)
			elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				if DormRoomTools:GetPrivateDormRoomState(slot1) == DormEnum.DormRoomUseState.Unlock then
					JumpTools.OpenPageByJump("dormUnLockRoomConfirmView", {
						roomID = slot1
					})
				elseif slot4 == DormEnum.DormRoomUseState.HadPlace then
					BackHomeTools:GotoBackHomeRoom(slot1)
				end
			end
		else
			if slot0.unLockRoomID then
				return
			end

			slot0.unLockRoomID = DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1
			slot3 = slot0:ChangItemPosToServerPosID(slot2)
			slot4 = BackHomeCfg[slot0.unLockRoomID].unlock_cost[1]

			if slot0.unLockRoomID then
				if slot4 then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(slot4[1]), slot4[2], GetTips("DORM_UNLOCK_COST_TIPS2")),
						OkCallback = function ()
							uv0:PopCostCallBack()
						end,
						CancelCallback = function ()
							uv0.unLockRoomID = nil
						end
					})
				else
					DormAction:UnLockDormArchitecture(slot0.unLockRoomID, slot3)

					slot0.unLockRoomID = nil
				end
			end
		end
	end
end

function slot0.OnDrag(slot0, slot1)
	if slot1.heroID and slot0.edit then
		slot5, slot1.transform_.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.fatherTrs, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})
	end
end

function slot0.RayPoint(slot0, slot1)
	if slot0.edit and slot0.dragPos ~= slot1.oriPos and not slot1.move then
		for slot5, slot6 in pairs(slot0.itemPosition) do
			if not slot6.has then
				slot1.move = true
				slot0.itemPosition[slot1.curPos].has = false
				slot6.has = true
				slot0.tweenValue_ = LeanTween.value(0, 1, slot0.time):setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.transform_.localPosition = Vector3(Mathf.Lerp(uv0.transform_.localPosition.x, uv1.itemPosition[uv2].pos.x, slot0), Mathf.Lerp(uv0.transform_.localPosition.y, uv1.itemPosition[uv2].pos.y, slot0), Mathf.Lerp(uv0.transform_.localPosition.z, uv1.itemPosition[uv2].pos.z, slot0))
				end)):setOnComplete(LuaHelper.VoidAction(function ()
					uv0.curPos = uv1

					if DormConst.DORM_FIRST_FLOOR_ROOM_NUM < uv1 then
						uv0.transform_:SetParent(uv2.centerTrs, false)
					else
						uv0.transform_:SetParent(uv2.fatherTrs, false)
					end

					uv0.move = false

					uv0.transform_:SetSiblingIndex(uv2.itemPosition[uv1].slibing)
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function slot0.StartDrag(slot0, slot1)
	if not slot0.edit and slot1.heroID and DormRoomTools:GetPrivateDormRoomState(slot1.roomID) == DormEnum.DormRoomUseState.HadPlace then
		slot0.edit = true
		slot0.dragPos = slot1.curPos

		slot1.roomStateController:SetSelectedState("select")
		slot1.transform_:SetParent(slot0.fatherTrs, false)
		slot1.transform_:SetAsFirstSibling()

		slot0.itemPosition[slot1.oriPos].has = false

		slot0:SetItemCanvasSortOrder(false)
	end
end

function slot0.EndDrag(slot0, slot1)
	if slot0.edit and slot1.heroID then
		slot5 = "normal"

		slot1.roomStateController:SetSelectedState(slot5)

		for slot5, slot6 in pairs(slot0.itemPosition) do
			if not slot6.has then
				slot6.has = true
				slot0.tweenValue_ = LeanTween.value(0, 1, slot0.time):setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.transform_.localPosition = Vector3(Mathf.Lerp(uv0.transform_.localPosition.x, uv1.itemPosition[uv2].pos.x, slot0), Mathf.Lerp(uv0.transform_.localPosition.y, uv1.itemPosition[uv2].pos.y, slot0), Mathf.Lerp(uv0.transform_.localPosition.z, uv1.itemPosition[uv2].pos.z, slot0))
				end)):setOnComplete(LuaHelper.VoidAction(function ()
					uv0.curPos = uv1

					if DormConst.DORM_FIRST_FLOOR_ROOM_NUM < uv1 then
						uv0.transform_:SetParent(uv2.centerTrs, false)
					else
						uv0.transform_:SetParent(uv2.fatherTrs, false)
					end

					uv0.transform_:SetSiblingIndex(uv2.itemPosition[uv1].slibing)
					uv2.centerTrs:SetAsLastSibling()

					uv2.edit = false
					uv2.dragPos = nil

					uv2:RevisePrivateDormPos()
					uv2:SetItemCanvasSortOrder(true)
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_PRIVATE_DORM_CHANGE, function (slot0)
		slot1 = DormitoryData:GetDormSceneData(slot0).pos_id
		slot2 = slot1 - DormConst.DORM_POS_ID_OFFSET
		slot3 = uv0:ChangServerPosIDToItemPos(slot1)
		slot4, slot5 = nil

		if uv0.floor == 1 then
			slot4 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM
			slot5 = 1
		else
			slot5 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (uv0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM - DormConst.DORM_FLOOR_ROOM_NUM + 1
		end

		if slot2 >= slot5 and slot2 <= slot4 and uv0:GetItemByCurPos(slot3) then
			slot6.roomID = slot0

			if BackHomeCfg[slot0].type == DormConst.BACKHOME_TYPE.PublicDorm and uv0.floor == 1 then
				uv0:RefreshPublicRoomHeroList()
			elseif BackHomeCfg[slot0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				uv0:GetItemByCurPos(slot3):RefreshItemState(true)
			end
		end
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.publicBtn_, nil, function ()
		uv0:ClickRoom(DormConst.PUBLIC_DORM_ID)
	end)
end

function slot0.GetItemByCurPos(slot0, slot1)
	if slot0.item then
		for slot5, slot6 in pairs(slot0.item) do
			if slot6.oriPos == slot1 then
				return slot6
			end
		end

		print("未找到对应item")
	end
end

function slot0.RevisePrivateDormPos(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.item) do
		if slot6.oriPos ~= slot6.curPos then
			slot6.oriPos = slot6.curPos
			slot7 = slot0:ChangItemPosToServerPosID(slot6.curPos)

			if slot6.roomID then
				if DormRoomTools:CheckRoomPosSameLevel(DormitoryData:GetDormSceneData(slot6.roomID).pos_id, slot7) then
					table.insert(slot1, {
						roomID = slot6.roomID,
						posID = slot7
					})
				end
			end
		end
	end

	if #slot1 > 0 then
		DormAction:RevisePrivateDormPos(slot1)
	end
end

function slot0.PopCostCallBack(slot0)
	if slot0.unLockRoomID then
		slot1 = BackHomeCfg[slot0.unLockRoomID].unlock_cost[1]
		slot0.unLockRoomID = nil

		if ItemTools.getItemNum(slot1[1]) < slot1[2] then
			ShowTips(GetTips("DORM_UNLOCK_ITEM_NOT_ENOUGH"))

			return
		end

		slot4 = slot0:ChangItemPosToServerPosID(slot0.selPos)

		if DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1 and slot4 then
			DormAction:UnLockDormArchitecture(slot3, slot4)
		end
	end
end

function slot0.ChangItemPosToServerPosID(slot0, slot1)
	if slot1 then
		slot2 = DormConst.DORM_POS_ID_OFFSET

		return slot0.floor <= 1 and slot2 + slot1 or slot2 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (slot0.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM + slot1
	end
end

function slot0.ChangServerPosIDToItemPos(slot0, slot1)
	if slot1 then
		slot2 = DormConst.DORM_POS_ID_OFFSET

		return slot0.floor <= 1 and slot1 - slot2 or slot1 - DormConst.DORM_FIRST_FLOOR_ROOM_NUM - (slot0.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM - slot2
	end
end

function slot0.indexHeroItem(slot0, slot1, slot2)
	slot2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	slot2:RefreshUI(slot0.heroList[slot1])
end

function slot0.RefreshPublicRoomHeroList(slot0)
	slot0.heroList = {}

	for slot6, slot7 in ipairs(DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList) do
		table.insert(slot0.heroList, DormData:GetHeroInfo(slot7):GetHeroId())
	end

	slot0.publicHeroScroll:StartScroll(#slot0.heroList)

	if #slot0.heroList == 0 then
		slot0.emptyController:SetSelectedState("false")
	end

	slot0.publicNum.text = string.format("%s/%s", #slot0.heroList, GameSetting.dorm_lobby_hero_max.value[1])

	if DormVisitTools:GetCurTemplateExhibit() == slot1 then
		slot0.publicVisitController:SetSelectedState("true")
	else
		slot0.publicVisitController:SetSelectedState("false")
	end
end

function slot0.PlayFloorAnimation(slot0)
	for slot4, slot5 in ipairs(slot0.item) do
		if slot5.curPos <= DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
			slot5.animation:Play("DormEntranceUI_item_cx", 0)
		elseif slot0.floor ~= GameDisplayCfg.dorm_lobby_layer.value[1] then
			slot5.animation:Play("DormEntranceUI_item_cx", 0)
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.publicHeroScroll then
		slot0.publicHeroScroll:Dispose()
	end

	if slot0.item then
		for slot4, slot5 in pairs(slot0.item) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
