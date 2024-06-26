slot0 = class("ActivityNewbieDailyView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, ActivityNewbieDailyItem)
	slot0.itemList_ = {}

	slot0:AddListeners()

	slot0.newbieDailyUpdateHandler_ = handler(slot0, slot0.NewbieDailyUpdate)

	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, slot0.newbieDailyUpdateHandler_)

	slot0.newbieDailySubmitHandler_ = handler(slot0, slot0.RefreshUI)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.newbieDailySubmitHandler_)
end

function slot0.GetUIName(slot0)
	return "Widget/System/Activitynewbie/NewbieDailyUI"
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, slot0.newbieDailyUpdateHandler_)

	slot0.newbieDailyUpdateHandler_ = nil

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.newbieDailySubmitHandler_)

	slot0.newbieDailySubmitHandler_ = nil

	uv0.super.Dispose(slot0)
	slot0.scrollView_.onValueChanged:RemoveAllListeners()

	slot0.scrollView_ = nil
	slot0.itemList_ = nil

	slot0.scrollHelper_:Dispose()

	slot0.scrollHelper_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0.scrollHelper_:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.buttonPrev_, nil, function ()
		uv0.scrollHelper_:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.buttonNext_, nil, function ()
		uv0.scrollHelper_:SwitchToPage(uv0.pageIndex_ + 1)
	end)
	slot0.scrollView_.onValueChanged:AddListener(function ()
		uv0:RefreshItemAlpha()
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0)
	slot0:NewbieDailyUpdate()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	if not table.keyof(slot0.itemList, slot2) then
		table.insert(slot0.itemList_, slot2)
	end

	slot2:RefreshUI(slot1)
	slot2:RegistListener(function ()
		uv0.scrollHelper_:Refresh()
	end)
end

function slot0.OnPageChange(slot0, slot1)
	if slot1 == 0 then
		slot1 = 1
	end

	slot0.pageIndex_ = slot1

	SetActive(slot0.goPrev_, slot1 > 1)
	SetActive(slot0.goNext_, slot1 < #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER])
end

function slot0.RefreshItemAlpha(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:RefreshAlpha()
	end
end

function slot0.RefreshUI(slot0)
	slot1 = #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER]
	slot2 = TaskTools:GetNewbieDailyTaskFinishCnt()
	slot0.slider_.value = slot2 / slot1
	slot0.textCurCnt_.text = string.format("%s<size=30>/%s</size>", slot2, slot1)
end

function slot0.NewbieDailyUpdate(slot0, slot1)
	slot2 = false

	if not slot1 then
		slot2 = true
	else
		for slot6, slot7 in ipairs(slot1) do
			if AssignmentCfg[slot7.id] and slot8.type == TaskConst.TASK_TYPE.DAILY_OFFER then
				slot2 = true

				break
			end
		end
	end

	if slot2 then
		slot4 = TaskTools:GetTaskCountByType(TaskConst.TASK_TYPE.DAILY_OFFER)

		slot0.scrollHelper_:StartScroll(#AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER], slot4, true, false)
		slot0:OnPageChange(slot4)
		slot0:RefreshUI()
		slot0:RefreshItemAlpha()
	end
end

return slot0
