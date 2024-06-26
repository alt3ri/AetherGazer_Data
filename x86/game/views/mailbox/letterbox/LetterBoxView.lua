slot0 = class("LetterBoxView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Mailbox/LetterBox"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.roleSrollHelper_ = LuaList.New(handler(slot0, slot0.indexRoleItem), slot0.roleListGo_, LetterBoxRoleItem)
	slot0.letterScrollHelper_ = LuaList.New(handler(slot0, slot0.indexLetterItem), slot0.letterListGo_, LetterBoxListItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.filterBtn_, nil, function ()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Mail_Filter_List
		})
	end)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(LETTER_READ_UPDATE, handler(slot0, slot0.OnLetterReadUpdate))
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.FilterUpdataList))
end

function slot0.OnLetterReadUpdate(slot0, slot1)
	LetterAction.UpdateLetterRedPoint(slot1)
end

function slot0.indexRoleItem(slot0, slot1, slot2)
	slot2.handler_ = handler(slot0, slot0.OnRoleClick)

	slot2:SetData(LetterData.GetSender(slot0.heroList_[slot1]))

	if slot0.curSenderId_ and slot0.curSenderId_ == slot4.id then
		slot2:SetSelected(true)
	else
		slot2:SetSelected(false)
	end
end

function slot0.indexLetterItem(slot0, slot1, slot2)
	slot2.handler_ = handler(slot0, slot0.OnLetterClick)

	slot2:SetData(slot1, LetterData.GetLetter(LetterData.GetLettersFromSender(slot0.curSenderId_)[slot1]))
end

function slot0.OnRoleClick(slot0, slot1)
	slot0:SelectRole(slot1:GetData().id)
end

function slot0.OnLetterClick(slot0, slot1)
	slot2 = slot1:GetData().id

	LetterAction.ReadLetter(slot2)
	JumpTools.OpenPageByJump("letterPop", {
		letterId = slot2
	})
end

function slot0.OnEnter(slot0)
	LetterAction.SortLetters()
	slot0:AddEventListener()
	slot0:UpdateList()
end

function slot0.UpdateList(slot0, slot1)
	slot0.heroList_ = LetterData.GetFilterSendSort()

	SetActive(slot0.filterBtn_.gameObject, #LetterData.GetSenderSort() > 0)
	slot0.emptyController_:SetSelectedState(#slot0.heroList_ <= 0 and "true" or "false")

	if #slot0.heroList_ <= 0 then
		slot0.roleSrollHelper_:StartScroll(0)

		slot0.curSenderId_ = nil
	else
		if not slot0.curSenderId_ or slot1 then
			slot0.curSenderId_ = slot0:GetFirstSelectedId()
		end

		if slot0.curSenderId_ ~= 0 then
			slot0.roleSrollHelper_:StartScroll(#slot0.heroList_, table.indexof(slot0.heroList_, slot0.curSenderId_))
			slot0.roleSrollHelper_:Refresh()
			slot0:UpdateLetterView(slot0.curSenderId_)
		else
			slot0.roleSrollHelper_:StartScroll(0)

			slot0.curSenderId_ = nil
		end
	end
end

function slot0.GetFirstSelectedId(slot0)
	return slot0.heroList_[math.min(1, #slot0.heroList_)] or 0
end

function slot0.SelectRole(slot0, slot1)
	if slot1 == 0 then
		return
	end

	if slot1 == slot0.curSenderId_ then
		return
	end

	slot0.curSenderId_ = slot1

	slot0.roleSrollHelper_:Refresh()
	slot0:UpdateLetterView(slot1)
end

function slot0.UpdateLetterView(slot0, slot1)
	if #LetterData.GetLettersFromSender(slot1) <= 0 then
		slot0.letterScrollHelper_:StartScroll(0)
	else
		slot0.letterScrollHelper_:StartScroll(#slot2)
	end
end

function slot0.FilterUpdataList(slot0)
	slot0:UpdateList(true)
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	CommonFilterData:ClearFilter(Filter_Root_Define.Mail_Filter_List.filter_id)
	slot0:RemoveAllEventListener()

	slot0.curSenderId_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()

	if slot0.roleSrollHelper_ then
		slot0.roleSrollHelper_:Dispose()

		slot0.roleSrollHelper_ = nil
	end

	if slot0.letterScrollHelper_ then
		slot0.letterScrollHelper_:Dispose()

		slot0.letterScrollHelper_ = nil
	end

	manager.classPool:DisposeOnePool(LetterBoxListItem)
	uv0.super.Dispose(slot0)
end

return slot0
