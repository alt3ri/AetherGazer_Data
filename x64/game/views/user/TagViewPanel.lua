slot0 = class("TagViewPanel", ReduxView)

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

	slot0.tagItem_ = {}
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1)
	slot0.list_ = slot1

	for slot5, slot6 in ipairs(slot0.list_) do
		if not slot0.tagItem_[slot5] then
			slot0.tagItem_[slot5] = TagItem.New(Object.Instantiate(slot0.tagTemplate_, slot0.transform_))

			slot0.tagItem_[slot5]:RegisterClickFunction(function (slot0)
				if uv0.callback_ then
					uv0.callback_(slot0)
				end
			end)
		end

		slot0.tagItem_[slot5]:SetData(slot6)
	end

	for slot5 = #slot0.list_ + 1, #slot0.tagItem_ do
		slot0.tagItem_[slot5]:Show(false)
	end
end

function slot0.RefreshSelect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.tagItem_) do
		slot6:RefreshSelect(slot1[slot6.id_] == true)
	end
end

function slot0.RegisterClickFunction(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in ipairs(slot0.tagItem_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
