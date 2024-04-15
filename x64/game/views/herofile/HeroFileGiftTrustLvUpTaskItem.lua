slot0 = class("HeroFileGiftTrustLvUpTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.completeStateController_ = slot0.conditionControllerEx_:GetController("completeState")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	if ConditionCfg[slot1] and slot3.type == 8023 then
		slot0.nameText_.text = string.format(slot3.desc, HeroCfg[slot2].suffix)
	else
		slot0.nameText_.text = slot3 and slot3.desc or ""
	end

	slot4, slot5, slot6 = IsConditionAchieved(slot1, {
		heroId = slot2
	})

	if slot4 then
		slot0.completeStateController_:SetSelectedState("done")

		slot0.processText_.text = math.min(slot5, slot6) .. "/" .. slot6
	else
		slot0.completeStateController_:SetSelectedState("not")

		slot0.processText_.text = "<color=#F65632>" .. slot5 .. "</color>" .. "/" .. slot6
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
