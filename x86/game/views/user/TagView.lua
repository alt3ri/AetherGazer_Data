slot0 = class("TagView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, TagViewPanel)
	slot0.tagSpace_ = slot0.tagPanelTemplate_:GetComponent("HorizontalLayoutGroup").spacing
	slot0.width_ = slot0.panel_.rect.width
	slot0.tagTemplateItem_ = TagItem.New(slot0.tagTemplate_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RegisterClickFunction(function (slot0)
		if uv0.usingList_[slot0] then
			uv0.usingList_[slot0] = nil
			uv0.useTotal_ = uv0.useTotal_ - 1

			uv1:RefreshSelect(uv0.usingList_)
		elseif GameSetting.profile_label_max_num.value[1] <= uv0.useTotal_ then
			ShowTips("PROFILE_LABEL_MAX_NUM")

			return
		else
			uv0.usingList_[slot0] = true
			uv0.useTotal_ = uv0.useTotal_ + 1

			uv1:RefreshSelect(uv0.usingList_)
		end

		uv0:RefreshText()

		if uv0.callback_ then
			slot1 = {}

			for slot5, slot6 in pairs(uv0.usingList_) do
				table.insert(slot1, slot5)
			end

			table.sort(slot1, function (slot0, slot1)
				if ProfileLabelCfg[slot0].type ~= ProfileLabelCfg[slot1].type then
					return slot3.type < slot2.type
				end

				if PlayerData:GetTagInfo(slot0).obtain_time ~= PlayerData:GetTagInfo(slot1).obtain_time then
					return slot4.obtain_time < slot5.obtain_time
				end

				return slot0 < slot1
			end)
			uv0.callback_(slot1)
		end
	end)
	slot2:RefreshData(slot0.panelList_[slot1])
	slot2:RefreshSelect(slot0.usingList_)
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshList()
	slot0:RefreshText()
end

function slot0.RefreshData(slot0)
	slot0.usingList_ = {}
	slot0.list_ = PlayerData:GetUnlockTagListInfo()

	for slot5, slot6 in ipairs(PlayerData:GetUsingTagListInfo()) do
		slot0.usingList_[slot6] = true
	end

	slot0.useTotal_ = #slot1
end

function slot0.RefreshList(slot0)
	slot1 = 0
	slot2 = 1
	slot0.panelList_ = {}

	for slot6, slot7 in ipairs(slot0.list_) do
		slot0.panelList_[slot2] = slot0.panelList_[slot2] or {}

		slot0.tagTemplateItem_:SetData(slot7)

		slot8 = slot0.tagTemplateItem_.transform_.rect.width
		slot9 = slot7.id

		if (slot1 == 0 and slot8 or slot1 + slot8 + slot0.tagSpace_) < slot0.width_ then
			table.insert(slot0.panelList_[slot2], slot7)
		else
			slot0.panelList_[slot2] = slot0.panelList_[slot2 + 1] or {}

			table.insert(slot0.panelList_[slot2], slot7)

			slot1 = slot8
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.panelList_)
end

function slot0.RefreshText(slot0)
	slot0.num_.text = string.format(GetTips("PROFILE_LABEL_SELECTIONAL_RESTRICTION"), slot0.useTotal_, GameSetting.profile_label_max_num.value[1])
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegisterClickFunction(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.OnExit(slot0)
	slot0.tagTemplateItem_:OnExit()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	slot0.tagTemplateItem_:Dispose()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
