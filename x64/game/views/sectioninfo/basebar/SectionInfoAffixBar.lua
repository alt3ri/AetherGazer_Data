slot0 = class("SectionInfoAffixBar", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	for slot5 = 1, 3 do
		slot0["affixController" .. slot5 .. "_"] = slot0["affixControllerEx" .. slot5 .. "_"]:GetController("lcok")
	end

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["affixBtn" .. slot4 .. "_"], nil, function ()
			if uv0.isMain_ == false or uv0.affix_[uv1].isLock == false then
				return
			end

			slot0 = nil

			if uv1 == 1 then
				slot0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "A")
			elseif uv1 == 2 then
				slot0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "B")
			elseif uv1 == 3 then
				slot0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "C")
			end

			ShowTips(slot0)
		end)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.isMain_ = slot1
	slot0.affix_ = slot2
	slot0.titleText_.text = slot3
	slot4 = 0

	for slot8 = 1, 3 do
		if slot8 <= (slot0.isMain_ and 3 or 1) then
			SetActive(slot0["affixGo" .. slot8 .. "_"], true)

			if slot0.isMain_ then
				if slot2[slot8].isLock then
					slot0["affixController" .. slot8 .. "_"]:SetSelectedState("true")
				else
					slot0["affixController" .. slot8 .. "_"]:SetSelectedState("false")
				end
			else
				slot0["affixController" .. slot8 .. "_"]:SetSelectedState("false")
			end

			slot0["affixImage" .. slot8 .. "_"].sprite = getAffixSprite(slot2[slot8])
			slot0["affixName" .. slot8 .. "_"].text = getAffixName(slot2[slot8])
			slot0["affixDes" .. slot8 .. "_"].text = getAffixDesc(slot2[slot8])
		else
			SetActive(slot0["affixGo" .. slot8 .. "_"], false)
		end
	end
end

return slot0
