slot0 = class("IdolTraineeCampDeployCharacterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampDeployCharaView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.selHeroID = nil
	slot0.dataList = nil
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot4 = slot0.heroList_
	slot0.characterScroll = LuaList.New(handler(slot0, slot0.IndexItem), slot4, IdolTraineeCampCharacterItem)
	slot0.targets = {}

	for slot4 = 1, slot0.targets_.childCount do
		slot5 = slot0.targets_:GetChild(slot4 - 1)
		slot6 = {}

		slot0:BindCfgUI(slot5.gameObject, slot6)

		slot6.stateController = slot6.controllers_:GetController("state")

		table.insert(slot0.targets, {
			trs = slot5,
			com = slot6
		})
	end

	slot0:RegisterEvents()
	slot0:UpdateCurHeroNum()

	function slot0.selectCharaFunc(slot0)
		uv0.selHeroID = IdolTraineeCampCharacterItem.curGrabbing and IdolTraineeCampBridge.GetCharacterHeroID(slot1) or slot0

		uv0.characterScroll:Refresh()
	end

	slot0.recallHeroFunc = handler(slot0, slot0.RecallHero)

	slot0:AddBtnListenerScale(slot0.backBtn_, nil, function ()
		slot0 = {}

		for slot5, slot6 in pairs(IdolTraineeCampBridge.charaAtPos) do
			table.insert(slot0, {
				hero_id = IdolTraineeCampBridge.GetCharacterHeroID(slot6),
				pos = slot5
			})
		end

		IdolTraineeAction.RequestSetHeroPos(slot0, function ()
			JumpTools.Back()
		end)
	end)
	slot0:AddBtnListenerScale(slot0.quickRecall_, nil, function ()
		slot0 = {}

		for slot4, slot5 in pairs(IdolTraineeCampBridge.charaAtPos) do
			if DormData:GetHeroFatigue(IdolTraineeCampBridge.GetCharacterHeroID(slot5)) < GameSetting.canteen_hero_fatigue_max.value[1] then
				table.insert(slot0, {
					hero_id = slot6,
					pos = slot4
				})
			end
		end

		IdolTraineeAction.RequestSetHeroPos(slot0, function ()
			IdolTraineeCampBridge.RefreshCharacterAtPos(false)
			uv0:UpdateCurHeroNum()
		end)
	end)
end

function slot0.RecallHero(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(IdolTraineeCampBridge.charaAtPos) do
		if slot1 ~= IdolTraineeCampBridge.GetCharacterHeroID(slot7) then
			table.insert(slot2, {
				hero_id = slot8,
				pos = slot6
			})
		end
	end

	IdolTraineeAction.RequestSetHeroPos(slot2, function ()
		IdolTraineeCampBridge.RefreshCharacterAtPos(false)
		uv0:UpdateCurHeroNum()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0, slot0.dataList[slot1])
	slot2:InDragFunc(slot0.selectCharaFunc)
	slot2:RecallHero(slot0.recallHeroFunc)
end

function slot0.IndexOf(slot0, slot1)
	return table.indexof(slot0.dataList, slot0.heroID)
end

function slot0.RefreshDormHeroList(slot0)
	slot0.dataList = IdolTraineeData:GetIdolHeroList()

	slot0.characterScroll:StartScroll(#slot0.dataList)
end

function slot0.OnEnter(slot0)
	slot0:RefreshDormHeroList()
	slot0:UpdateCurHeroNum()
end

function slot0.OnExit(slot0)
	slot0.selHeroID = nil
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	IdolTraineeCampCharacterItem.curDragging = nil

	slot0.characterScroll:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function ()
		uv0.characterScroll:Refresh()
		uv0:UpdateCurHeroNum()
	end)
	slot0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function ()
		uv0.characterScroll:Refresh()
	end)
end

function slot0.UpdateCurHeroNum(slot0)
	slot0.curnumText_.text = IdolTraineeCampBridge.entityManager:EntityNum()
end

function slot0.SetCharacterAtPos(slot0, slot1, slot2)
	IdolTraineeCampBridge.SetPosOfCharacter(slot1, slot2)
end

function slot0.SnapCharacterOnTarget(slot0, slot1, slot2)
	if nullable(Dorm.storage:PickData("idol.camp.pos." .. slot2), "transform") then
		Dorm.DormEntityManager.PutEntityAt(slot1, slot3)

		return true
	end
end

function slot0.NotDragOutYet(slot0, slot1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(slot0.dragOutRect_, slot1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera)
end

function slot0.BeginDragHeroList(slot0, slot1, slot2)
	slot0.heroList_:OnBeginDrag(slot1)

	slot0.isDraggingHeroList = true

	if slot2 and slot2:IsDragBlocked() then
		return
	end

	for slot6, slot7 in pairs(slot0.targets) do
		slot7.com.stateController:SetSelectedState("show")
	end
end

function slot0.DragHeroList(slot0, slot1, slot2)
	slot0.heroList_:OnDrag(slot1)
end

function slot0.EndDragHeroList(slot0, slot1, slot2)
	if slot0.isDraggingHeroList then
		slot6 = slot1

		slot0.heroList_:OnEndDrag(slot6)

		for slot6, slot7 in pairs(slot0.targets) do
			slot7.com.stateController:SetSelectedState("hide")
		end
	end
end

function slot0.HoverHightDragOnTarget(slot0, slot1, slot2)
	for slot6 = 1, #slot0.targets do
		slot0.targets[slot6].com.stateController:SetSelectedState(slot6 == slot2 and "highlight" or "show")
	end
end

return slot0
