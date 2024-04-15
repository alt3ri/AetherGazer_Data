slot0 = class("CommonFilterGroup", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.items = {}
	slot0.alreadyBuild = false
	slot0.filterContext = slot2

	slot0:Init()
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.titleTxt_.text = GetTips(CommonFilterConst.GetGroupCfg(slot2).title)

	if not CommonFilterConst.GetFilterList(slot2) then
		return
	end

	slot0:BuildLayout(#slot4, slot3.mode or Filter_Group_Mode.MultiMode)

	for slot10 = 1, slot5 do
		slot0.items[slot10]:Refresh(slot1, slot2, slot4[slot10])
	end
end

function slot0.BuildLayout(slot0, slot1, slot2)
	if slot0.alreadyBuild then
		return
	end

	slot0.alreadyBuild = true

	for slot7 = 1, #slot0.items do
		slot0.items[slot7]:Dispose()
	end

	slot0.items = {}

	for slot7 = 1, slot1 do
		if slot2 == Filter_Group_Mode.SingleMode then
			table.insert(slot0.items, CommonSingleFilterItem.New(Object.Instantiate(slot0.singleFilterItemObj_, slot0.singleContent_), slot0.filterContext))
		else
			table.insert(slot0.items, CommonFilterItem.New(Object.Instantiate(slot0.commonFilterItemObj_, slot0.content_), slot0.filterContext))
		end
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	for slot4 = 1, #slot0.items do
		slot0.items[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
