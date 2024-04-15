slot1 = class("BattleChipSchemeItem", import("game.views.chip.scheme.ChipSchemeItem"))

function slot1.OnEnabledBtn(slot0)
	slot0.dataTemplate.useChipIdList = slot0.schemeData_.chipList

	slot0.dataTemplate.sectionProxy_:SetMimirChipList(slot0.schemeData_.chipList)
	manager.notify:Invoke(ENABLED_SCHEME)
end

return slot1
