slot0 = class("PolyhedronAstrolabeAdjustView", AstrolabeAdjustView)

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.loadBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()

		if AstrolabeConst.ASTROLABE_MAX_NUM <= uv0.equipNum_ then
			ShowTips("TIP_ASTROLABE_NUM_MAX")

			return
		end

		if not uv0:GetLastIsEquiped(slot0.id, slot0.heroId) then
			slot1 = HeroAstrolabeCfg[slot0.id - 1]

			ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(slot1.suit_name), GetI18NText(slot1.name)))

			return
		end

		PolyhedronAction.AstrolabeEquip(slot0.heroId, slot0.id)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()
		slot1 = HeroAstrolabeCfg[slot0.id]

		if uv0:GetNextIsEquiped(slot0.id, slot0.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function ()
					PolyhedronAction.AstrolabeUnload(uv0.heroId, uv0.id)
				end
			})
		else
			PolyhedronAction.AstrolabeUnload(slot0.heroId, slot0.id)
		end
	end)
	slot0:AddBtnListener(slot0.loadAllBtn_, nil, function ()
		slot0 = uv0.lastSelectItem_:GetItemInfo()

		PolyhedronAction.AstrolabeEquipAll(slot0.heroId, HeroAstrolabeCfg[slot0.id].hero_astrolabe_suit_id)
	end)
	slot0:AddBtnListener(slot0.unloadAllBtn_, nil, function ()
		PolyhedronAction.AstrolabeUnloadAll(uv0.lastSelectItem_:GetItemInfo().heroId)
	end)
end

function slot0.RefreshState(slot0, slot1)
	slot2 = HeroAstrolabeCfg[slot1.id]

	if slot1.isEquiped then
		slot0.stateController_:SetSelectedState("equip")
	elseif slot2.pos == 3 then
		slot0.stateController_:SetSelectedState("all")
	else
		slot0.stateController_:SetSelectedState("one")
	end

	slot0.lockCon_:SetSelectedState("false")
end

function slot0.GetLastIsEquiped(slot0, slot1, slot2)
	if HeroAstrolabeCfg[slot1].pos == 1 then
		return true
	else
		return AstrolabeTools.GetIsEquiped(PolyhedronData:GetHeroData(slot2).using_astrolabe, slot1 - 1)
	end

	return false
end

function slot0.GetNextIsEquiped(slot0, slot1, slot2)
	if HeroAstrolabeCfg[slot1].pos == 3 then
		return false
	else
		return AstrolabeTools.GetIsEquiped(PolyhedronData:GetHeroData(slot2).using_astrolabe, slot1 + 1)
	end

	return false
end

return slot0
