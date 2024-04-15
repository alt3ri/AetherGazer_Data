slot0 = class("DrawInfoMessageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.items = {}
end

function slot0.RefreshData(slot0, slot1)
	SetActive(slot0.UpGo_, true)
	slot0:Show(true)

	slot0.labelTxt_.text = GetI18NText(slot1.name)
	slot0.tips01.text = GetI18NText(slot1.probability)
	slot0.tips02.text = ""

	if slot1.probability2 then
		slot0.tips02.text = GetI18NText(slot1.probability2)
	end

	if slot1.s_all_hero then
		if slot1.s_up_probability then
			slot0.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_1"), slot1.s_up_probability .. "%")
		end

		slot0:RefreshItem(slot1.s_all_hero, true, slot1.s_up_hero)
	end

	if slot1.a_all_hero then
		if slot1.a_up_probability then
			slot0.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_2"), slot1.a_up_probability .. "%")
		end

		if not slot1.a_up_hero or #slot1.a_up_hero <= 0 then
			SetActive(slot0.UpGo_, false)
		end

		slot0:RefreshItem(slot1.a_all_hero, true, slot1.a_up_hero)
	end

	if slot1.b_hero then
		SetActive(slot0.UpGo_, false)
		slot0:RefreshItem(slot1.b_hero, true)
	end

	if slot1.s_all_servant then
		SetActive(slot0.UpGo_, false)
		slot0:RefreshItem(slot1.s_all_servant, false, slot1.s_up_servant)
	end

	if slot1.a_all_servant then
		SetActive(slot0.UpGo_, false)
		slot0:RefreshItem(slot1.a_all_servant, false, slot1.a_up_servant)
	end

	if slot1.b_servant then
		SetActive(slot0.UpGo_, false)
		slot0:RefreshItem(slot1.b_servant, false)
	end
end

function slot0.RefreshItem(slot0, slot1, slot2, slot3)
	for slot8 = 1, #slot1 do
		if not slot0.items[slot8] then
			slot0.items[slot8] = DrawInfoCommonItem.New(Object.Instantiate(slot0.infoItem_, slot0.contentTrs_))
		end

		slot0.items[slot8]:RefreshData(slot1[slot8], slot2)
		slot0.items[slot8]:RefreshUp(slot3, slot2)
	end

	for slot8 = slot4 + 1, #slot0.items do
		slot0.items[slot8]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.items then
		for slot4, slot5 in ipairs(slot0.items) do
			slot5:Dispose()
			Object.Destroy(slot0.items[slot4].gameObject_)
		end

		slot0.items = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot0
