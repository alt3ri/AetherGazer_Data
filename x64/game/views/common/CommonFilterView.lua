slot0 = class("CommonFilterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/CommonFilterView/CommonFilterView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.OnCommonFilterItemClick = handler(slot0, slot0.OnItemClick)
	slot0.items = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:RegisteBottomComponent()
end

function slot0.AddUIListeners(slot0)
	if slot0.maskBtn_ then
		slot0:AddBtnListener(slot0.maskBtn_, nil, handler(slot0, slot0.Back))
	end

	if slot0.cancelBtn_ then
		slot0:AddBtnListener(slot0.cancelBtn_, nil, handler(slot0, slot0.Back))
	end

	if slot0.allBtn_ then
		slot0:AddBtnListener(slot0.allBtn_, nil, handler(slot0, slot0.OnBtnAllClick))
	end

	slot0:AddBtnListener(slot0.okBtn_, nil, handler(slot0, slot0.OnBtnOKClick))
end

function slot0.BuildContext(slot0)
	slot0.filterContext = CommonFilterData:GetFilterDataCopy(slot0.filter_id)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener("OnCommonFilterItemClick", slot0.OnCommonFilterItemClick)

	slot0.filter_id = slot0.params_.filterGroup.filter_id
	slot0.filterGroup = slot0.params_.filterGroup.groupList

	if not slot0.filterGroup then
		print("CommonFilterView参数错误")

		return
	end

	slot0:BuildContext()

	slot0.count = #slot0.filterGroup

	slot0:BuildLayout()
	slot0:Refresh()
end

function slot0.BuildLayout(slot0)
	for slot5 = 1, #slot0.items do
		slot0.items[slot5]:Dispose()
	end

	slot0.items = {}

	for slot5 = 1, slot0.count do
		table.insert(slot0.items, CommonFilterGroup.New(Object.Instantiate(slot0.filterGroupObj_, slot0.content_), slot0.filterContext))
	end
end

function slot0.OnItemClick(slot0, slot1)
	slot0:CheckSingleState(slot1)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	if slot0.AllController then
		slot0.isAll = slot0.filterContext:IsAll(slot0.filter_id)

		slot0.AllController:SetSelectedIndex(slot0.isAll and 1 or 0)
	end

	for slot4 = 1, slot0.count do
		slot0.items[slot4]:Refresh(slot0.filter_id, slot0.filterGroup[slot4])
	end

	slot0:TryUpdateBottom()
end

function slot0.CheckSingleState(slot0, slot1)
	for slot5 = 1, slot0.count do
		slot6 = slot0.filterGroup[slot5]

		if slot1.gId == slot6 and CommonFilterConst.GetGroupCfg(slot6).mode == Filter_Group_Mode.SingleMode and not slot0.filterContext:AtLeastOneChooseGroup(slot6) then
			if slot1.tId then
				slot0.filterContext:SelectTag(slot6, slot1.tId)
			else
				slot0.filterContext:SelectTag(slot6, slot7.tags[1])
			end
		end
	end
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener("OnCommonFilterItemClick", slot0.OnCommonFilterItemClick)
end

function slot0.Dispose(slot0)
	for slot4 = 1, #slot0.items do
		slot0.items[slot4]:Dispose()
	end

	slot0:RemoveAllListeners()
	slot0:DisposeBottomView()
	uv0.super.Dispose(slot0)
end

function slot0.OnBtnAllClick(slot0)
	if slot0.isAll then
		return
	end

	slot0:Refresh()
end

function slot0.OnBtnOKClick(slot0)
	if not slot0.filterContext:CheckIsSame(CommonFilterData:GetFilterDataCopy(slot0.filter_id)) then
		CommonFilterData:ApplyFilterCopy(slot0.filterContext)
		manager.notify:CallUpdateFunc(COMMON_FILTER_OK)
		manager.notify:Invoke(COMMON_FILTER_OK)
	end

	slot0:Back()
end

function slot0.RegisteBottomComponent(slot0)
	if slot0.filterBottomObj_ and not slot0.filterBottomView then
		slot0.filterBottomView = CommonFilterBottom.New(slot0.filterBottomObj_)

		slot0.filterBottomView:RegisteClearBtnListener(handler(slot0, slot0.OnClearBtnClick))
	end
end

function slot0.OnClearBtnClick(slot0)
	slot0.filterContext:Clear()
	slot0:Refresh()
end

function slot0.TryUpdateBottom(slot0)
	slot0:RegisteBottomComponent()

	if slot0.filterBottomView then
		slot2 = {}

		for slot6, slot7 in ipairs(slot0.filterGroup) do
			if CommonFilterConst.GetGroupCfg(slot7).mode ~= Filter_Group_Mode.SingleMode then
				slot12 = slot7

				for slot12, slot13 in ipairs(({
					[slot7] = slot0.filterContext:GetGroupSelectedTags(slot12)
				})[slot7]) do
					table.insert(slot2, {
						name = GetTips(CommonFilterConst.GetFilterTagCfg(slot13).name)
					})
				end
			end
		end

		slot0.filterBottomView:Refresh(slot2)
	end
end

function slot0.DisposeBottomView(slot0)
	if slot0.filterBottomView then
		slot0.filterBottomView:Dispose()

		slot0.filterBottomView = nil
	end
end

return slot0
