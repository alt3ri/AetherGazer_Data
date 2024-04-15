slot0 = class("CommonFilterBottom", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.emptyController_ = slot0.emptyCon_:GetController("empty")
	slot0.filterItmeList_ = {}
end

function slot0.Refresh(slot0, slot1)
	slot0.filterInfoList_ = slot1

	for slot5, slot6 in ipairs(slot0.filterInfoList_) do
		if slot0.filterItmeList_[slot5] == nil then
			slot7 = CommonFilterBottomItem.New(Object.Instantiate(slot0.filterItemGo_, slot0.filterContent_))

			slot7:RegistCallBack(function (slot0)
				if uv0.itemClickCallback then
					uv0.itemClickCallback(slot0)
				end
			end)

			slot0.filterItmeList_[slot5] = slot7
		end

		slot7:Refresh(slot6)
	end

	for slot5 = #slot0.filterInfoList_ + 1, #slot0.filterItmeList_ do
		SetActive(slot0.filterItmeList_[slot5].gameObject_, false)
	end

	slot2 = #slot0.filterInfoList_ == 0

	slot0.emptyController_:SetSelectedState(tostring(slot2))
	SetActive(slot0.gameObject_, not slot2)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.clearBtn_, nil, function ()
		if uv0.clearCallback then
			slot0()
		end
	end)
end

function slot0.RegisteClearBtnListener(slot0, slot1)
	if not slot0.clearCallback then
		slot0.clearCallback = slot1
	end
end

function slot0.RegisteItemClickListener(slot0, slot1)
	if not slot0.itemClickCallback then
		slot0.itemClickCallback = slot1
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.filterItmeList_) do
		slot5:Dispose()
	end

	slot0.filterItmeList_ = nil

	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
