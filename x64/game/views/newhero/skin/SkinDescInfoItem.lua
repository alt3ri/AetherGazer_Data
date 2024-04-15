slot0 = class("SkinDescInfoItem", ReduxView)
slot1 = "Atlas/HeroAtlas"

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.tagList_ = slot2
	slot0.type_ = slot3
	slot0.descItemList_ = nil

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoTransform_)
end

function slot0.RefreshUI(slot0)
	slot2 = SkinTagDescCfg[slot0.tagList_[1]]
	slot0.text_.text = slot2.type_desc
	slot0.image_.sprite = getSprite(uv0, slot2.type_icon)

	slot0:LoadDescItem()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoTransform_)
end

function slot0.LoadDescItem(slot0)
	slot0.descItemList_ = {}

	for slot4, slot5 in ipairs(slot0.tagList_) do
		if not slot0.descItemList_[slot4] then
			slot0.descItemList_[slot4] = SkinDescItem.New(Object.Instantiate(slot0.descTemplate_, slot0.infoTransform_))
		end

		slot0.descItemList_[slot4]:RefreshUI(slot5)
		slot0.descItemList_[slot4]:Show(true)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.infoTransform_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.descItemList_) do
		slot5:Dispose()
	end

	slot0.descItemList_ = {}

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
