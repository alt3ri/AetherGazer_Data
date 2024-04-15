slot0 = class("SpringPreheatLetterTextItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.richText_ = slot0:FindCom("RichText", "", slot1.transform)

	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0.richText_:AddListener(function (slot0, slot1)
		if slot0 == "1" then
			uv0:SelectLetter(uv0.paragIdx_, tonumber(slot1))
		end
	end)

	if slot0.btn_ then
		slot1 = slot0.richText_.gameObject
		slot3 = slot1:GetComponent("RectTransform")

		slot0:GetOrAddComponent(slot1, typeof(EventTriggerListener)):AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			uv1:SelectLetter(uv1.paragIdx_, uv1:FindNearestUnderlineIndex(LuaHelper.ScreenToLocal(uv0, slot1.position, slot1.enterEventCamera).x))
		end))
	end
end

function slot0.Dispose(slot0)
	slot0.richText_:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.isSelecting_ = slot4

	slot0.richText_:AddSprite("selecting", slot2)
	slot0.richText_:AddSprite("selected", slot3)

	if slot0.paragIdx_ ~= slot1 then
		slot0.paragIdx_ = slot1

		slot0:InitLetterInfo()
	end

	slot0:UpdateRichText()
end

function slot0.SetPreviewMode(slot0, slot1)
	slot0.previewMode_ = slot1
end

function slot0.SetSendingMode(slot0, slot1)
	slot0.sendingMode_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0:UpdateRichText()
end

function slot0.UpdateRichText(slot0)
	slot2 = slot0.richText_
	slot4 = 1
	slot5 = 1
	slot6 = ""
	slot7 = GetTips("SPRING_PREHEAT_WORD_BRACKET")
	slot9 = 1

	for slot13 = 1, #slot0.letterInfo_ do
		slot14 = slot0.letterInfo_[slot13]

		if SpringPreheatData:IsEnableOption(SpringPreheatData:GetPlayerLetter().id, slot0.paragIdx_, slot13) then
			slot15 = nil
			slot15 = (slot14 == 0 or GetTips(slot14)) and (slot0.previewMode_ and "______" or "______")
			slot16 = slot14 == 0 and GameDisplayCfg.spring_preheat_select_color.value[1] or nil
			slot6 = slot0.sendingMode_ and slot6 .. slot15 or slot16 and slot6 .. slot15 .. string.format(string.format("<color=%s>%s</color>", slot16, slot7), string.format("<material=underline c=%s h=-1.5 event=1 args=%d>%s</material>", slot16, slot9, slot15)) or slot6 .. slot15 .. string.format(string.format("<color=%s>%s</color>", slot16, slot7), string.format("<material=underline c=%s h=-1.5 event=1 args=%d>%s</material>", slot16, slot9, slot15)) .. string.format(slot7, string.format("<material=underline h=1.5 event=1 args=%d>%s</material>", slot9, slot15))
			slot9 = slot9 + 1
		else
			slot6 = slot6 .. GetTips(slot14)
		end
	end

	slot2.text = slot6
	slot0.underlineCount_ = slot9 - 1

	slot0:CalcUnderlineData()
end

function slot0.InitLetterInfo(slot0)
	slot0.letterInfo_ = {}
	slot0.richTextList_ = {}
	slot0.hasOption_ = false

	for slot6 = 1, #SpringPreheatData:GetPlayerLetter().option_button_list[slot0.paragIdx_] do
		if SpringPreheatData:IsEnableOption(slot1.id, slot2, slot6) then
			slot0.letterInfo_[slot6] = 0
			slot0.hasOption_ = true
		else
			slot0.letterInfo_[slot6] = SpringPreheatData:GetLetterFixedText(slot1.id, slot2, slot6)
		end
	end
end

function slot0.SetLetterInfo(slot0, slot1)
	for slot7, slot8 in pairs(slot1) do
		if SpringPreheatData:IsEnableOption(SpringPreheatData:GetPlayerLetter().id, slot0.paragIdx_, slot7) then
			slot0.letterInfo_[slot7] = slot8
		end
	end
end

function slot0.SelectLetter(slot0, slot1, slot2)
	if not slot0.hasOption_ or slot0.sendingMode_ then
		return
	end

	if not slot0.previewMode_ then
		-- Nothing
	else
		slot3.updateAni = true
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", {
		isStickerMode = false,
		paragIdx = slot1,
		optionIdx = slot2,
		letterInfo = slot0:GetLetterInfo(),
		onChangeFullLetter = function (slot0)
			uv0:SetLetterInfo(slot0)
			uv0:RefreshUI()
		end
	})
end

function slot0.ResetLetterInfo(slot0)
	slot0:InitLetterInfo()
	slot0:UpdateRichText()
end

function slot0.GetLetterInfo(slot0)
	return slot0.letterInfo_
end

function slot0.IsComplete(slot0)
	for slot4, slot5 in ipairs(slot0.letterInfo_) do
		if slot5 == 0 then
			return false
		end
	end

	return true
end

function slot0.CalcUnderlineData(slot0)
	Timer.New(function ()
		uv0.underlinePos_ = {}

		for slot6 = 1, math.min(uv0.richText_.gameObject:GetComponentsInChildren(typeof(RectTransform)).Length - 1, uv0.underlineCount_) do
			table.insert(uv0.underlinePos_, uv0.richText_.transform.rect.center.x + slot0[slot6].anchoredPosition.x)
		end
	end, 0.5, 0):Start()
end

function slot0.FindNearestUnderlineIndex(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.underlinePos_ or {}) do
		if math.abs(slot7 - slot1) <= math.abs(slot0.underlinePos_[1] - slot1) then
			slot2 = slot6
		end
	end

	return slot2
end

function slot0.UpdateAnim(slot0, slot1, slot2)
	if slot0.ani_ then
		slot0.ani_.enabled = slot1

		SetActive(slot0.aniGo_, slot1)

		if slot1 then
			slot0.ani_:Play(slot2, -1, 0)
		end
	end
end

return slot0
