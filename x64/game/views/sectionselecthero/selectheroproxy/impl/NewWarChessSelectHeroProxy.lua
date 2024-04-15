slot1 = class("NewWarChessSelectHeroProxy", import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy"))

function slot1.InitCustomParams(slot0, slot1)
	slot0.needPresetReservePanel = false
	slot0.needMimirPanel = false
end

function slot1.OnSectionSelectEnter(slot0)
	slot0:CheckNewWarChessTeamRedPoint()
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back()
		manager.NewChessManager:ClearBattleData()
	end)
end

function slot1.GetHeroTeamInfoRoute(slot0)
	return "/newWarChessHeroTeamInfoView"
end

function slot1.CheckNewWarChessTeamRedPoint(slot0)
	slot2 = NewWarChessData:GetHeroInfoList()
	slot3 = {}
	slot4 = false
	slot5 = false

	for slot9, slot10 in pairs(slot0:GetHeroIDList()) do
		if slot10 == 0 then
			slot4 = true
		else
			table.insert(slot3, slot10)
		end
	end

	if slot4 then
		for slot9, slot10 in pairs(slot2) do
			if slot10[2] > 0 and table.keyof(slot3, NewWarChessHeroCfg[slot10[1]].hero_id) == nil then
				slot5 = true
			end
		end
	else
		slot5 = false
	end

	if slot5 then
		for slot9, slot10 in pairs(slot1) do
			if slot10 == 0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot9, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot9, 0)
			end
		end
	else
		for slot9, slot10 in pairs(slot1) do
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot9, 0)
		end
	end
end

function slot1.CustomHeroBindRedPoint(slot0, slot1, slot2)
	manager.redPoint:bindUIandKey(slot2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. slot1)
end

function slot1.CustomHeroUnBindRedPoint(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot2.addBtnRedPointContain_, RedPointConst.NEW_WARCHESS_HERO_USE .. slot1)
end

function slot1.CustomGetHeroHP(slot0, slot1, slot2, slot3)
	slot4 = NewWarChessData:GetHeroHp(slot2)

	return slot4, math.ceil(slot4 / NewChessConst.HERO_HP_RATE * 100)
end

return slot1
