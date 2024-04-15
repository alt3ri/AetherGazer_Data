slot0 = class("LikeInfoPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/UserInfor/LikerecordUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, LikeInfoPopItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.curList_[slot1]

	slot2:RefreshData(slot0.listInfo_[slot3.id], slot3.time)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		uv0.index_ = uv0.index_ - 1
		uv0.params_.index = uv0.index_

		uv0:TryGetInfo()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		uv0.index_ = uv0.index_ + 1
		uv0.params_.index = uv0.index_

		uv0:TryGetInfo()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.list_ = {}
	slot0.listInfo_ = {}

	for slot5, slot6 in ipairs(PlayerData:GetLikeInfo()) do
		table.insert(slot0.list_, {
			id = slot6.id,
			time = slot6.time
		})
	end

	slot0.index_ = slot0.params_.index

	slot0:TryGetInfo()
end

function slot0.TryGetInfo(slot0)
	slot3 = {}
	slot0.curList_ = {}

	for slot7 = (slot0.index_ - 1) * GameSetting.profile_like_page_num.value[1] + 1, slot0.index_ * GameSetting.profile_like_page_num.value[1] do
		if not slot0.list_[slot7] then
			break
		end

		table.insert(slot0.curList_, slot8)

		if not slot0.listInfo_[slot8.id] then
			table.insert(slot3, slot9)
		end
	end

	if #slot3 <= 0 then
		slot0:RefreshUI()
		slot0.scrollHelper_:StartScroll(#slot0.curList_)
	else
		ForeignInfoAction:GetSimpleForeignInfo(slot3)
	end
end

function slot0.RefreshUI(slot0)
	slot0.page_.text = slot0.index_

	SetActive(slot0.leftBtn_.gameObject, slot0.index_ ~= 1)
	SetActive(slot0.rightBtn_.gameObject, slot0.index_ * GameSetting.profile_like_page_num.value[1] < #slot0.list_)
end

function slot0.OnGetSimpleForeignInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.listInfo_[slot6.user_id] = {
			id = slot6.user_id,
			nick = slot6.base_info.nick,
			icon = slot6.base_info.icon,
			frame = slot6.base_info.icon_frame,
			level = slot6.level
		}
	end

	slot0:RefreshUI()
	slot0.scrollHelper_:StartScroll(#slot0.curList_)
end

function slot0.OnExit(slot0)
	slot0.curList_ = {}
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
