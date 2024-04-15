slot0 = class("DormRoomItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.roomStateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.roomDetailController = ControllerUtil.GetController(slot0.transform_, "detail")
	slot0.heroIconController = ControllerUtil.GetController(slot0.transform_, "hero")
	slot0.visitController = ControllerUtil.GetController(slot0.transform_, "visit")
	slot0.move = false
	slot0.animation = slot0.gameObject_:GetComponent("Animation")
	slot0.heroItem = BackHomeNewHeroItem.New(slot0.heroItemGo_)

	slot0.heroItem:SetItemFunction({
		showFatigue = true,
		showState = true
	})

	slot0.textCanvas = slot0.detailsGo_:GetComponent("Canvas")
end

function slot0.AddUIListener(slot0)
	slot0:AddPressByTimeListener(slot0.buttonBtn_.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.roomID, uv0.oriPos)
		end
	end, function (slot0, slot1, slot2)
		if uv0.startDrag then
			uv0:startDrag()
		end
	end, function (slot0, slot1, slot2)
		if uv0.endDrag then
			uv0:endDrag()
		end
	end, slot0.oriPos)
	slot0:AddDragListener(slot0.buttonBtn_.gameObject, function ()
	end, function ()
		if uv0.onDrag then
			uv0:onDrag()
		end
	end, function ()
	end)
	slot0:AddPonitListener(slot0.buttonBtn_.gameObject, function ()
		if uv0.changePositionFunc then
			uv0:changePositionFunc()
		end
	end, function ()
	end)
end

function slot0.SetPosAndRoomID(slot0, slot1, slot2)
	slot0.oriPos = slot1
	slot0.roomID = slot2
	slot0.curPos = slot1
end

function slot0.RefreshItemState(slot0, slot1)
	slot0.roomDetailController:SetSelectedState("false")
	slot0.heroIconController:SetSelectedState("false")
	slot0.visitController:SetSelectedState("false")

	if slot0.roomID then
		if DormRoomTools:GetPrivateDormRoomState(slot0.roomID) == DormEnum.DormRoomUseState.Lock then
			slot0.roomStateController:SetSelectedState("lock")
		elseif slot2 == DormEnum.DormRoomUseState.Unlock then
			slot0.roomStateController:SetSelectedState("unlock")

			if slot1 then
				slot0.animation:Play("DormEntranceUI_item_unlock")
			end
		elseif slot2 == DormEnum.DormRoomUseState.HadPlace then
			slot0.roomStateController:SetSelectedState("normal")

			if slot0.roomID == DormVisitTools:GetCurTemplateExhibit() then
				slot0.visitController:SetSelectedState("true")
			end

			if DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList and #slot3 > 0 then
				slot0.roomStateController:SetSelectedState("true")
				slot0.roomDetailController:SetSelectedState("true")

				slot4 = slot3[1]
				slot5 = DormData:GetHeroInfoList()[slot4]
				slot0.heroID = slot5.hero_id
				slot0.comfortNum.text = DormitoryData:GetDormExp(slot0.roomID)
				slot0.levelNum.text = DormitoryData:GetDormLevel(slot0.roomID)
				slot0.heroName.text = HeroRecordCfg[slot4].name

				if slot5:GetHeroState() ~= DormEnum.DormHeroState.OutDorm and slot6 ~= DormEnum.DormHeroState.InPublicDorm and slot6 ~= DormEnum.DormHeroState.InIdolTraineeCamp then
					slot0.heroIconController:SetSelectedState("true")
					slot0.heroItem:RefreshUI(slot0.heroID)
				end
			end
		end
	else
		slot0.roomStateController:SetSelectedState("lock")
	end
end

function slot0.ClickItemCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.StartDrag(slot0, slot1)
	if slot1 then
		slot0.startDrag = slot1
	end
end

function slot0.OnDrag(slot0, slot1)
	if slot1 then
		slot0.onDrag = slot1
	end
end

function slot0.EndDrag(slot0, slot1)
	if slot1 then
		slot0.endDrag = slot1
	end
end

function slot0.ChangePosition(slot0, slot1)
	if slot1 then
		slot0.changePositionFunc = slot1
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.heroItem:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
