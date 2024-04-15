slot0 = class("NewWarChessSectionSelectHeroView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	slot0.super.OnEnter(slot0)
	SetActive(slot0.reservesBtn_.gameObject, false)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back()
		manager.NewChessManager:ClearBattleData()
	end)
	SetActive(slot0.chipPanel_, false)
	slot0:CheckNewWarChessTeamRedPoint()
	slot0:BindRedPoint()
end

function slot0.CheckNewWarChessTeamRedPoint(slot0)
	slot1 = NewWarChessData:GetHeroInfoList()
	slot2 = {}
	slot3 = false
	slot4 = false

	for slot8, slot9 in pairs(slot0.cacheHeroTeam_) do
		if slot9 == 0 then
			slot3 = true
		else
			table.insert(slot2, slot9)
		end
	end

	if slot3 then
		for slot8, slot9 in pairs(slot1) do
			if slot9[2] > 0 and table.keyof(slot2, NewWarChessHeroCfg[slot9[1]].hero_id) == nil then
				slot4 = true
			end
		end
	else
		slot4 = false
	end

	if slot4 then
		for slot8, slot9 in pairs(slot0.cacheHeroTeam_) do
			if slot9 == 0 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot8, 1)
			else
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot8, 0)
			end
		end
	else
		for slot8, slot9 in pairs(slot0.cacheHeroTeam_) do
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_HERO_USE .. slot8, 0)
		end
	end
end

function slot0.BindRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.addBtnImg_) do
		manager.redPoint:bindUIandKey(slot5.transform, RedPointConst.NEW_WARCHESS_HERO_USE .. slot4)
	end
end

function slot0.UnBindRedPoint(slot0)
	for slot4, slot5 in pairs(slot0.addBtnImg_) do
		manager.redPoint:unbindUIandKey(slot5.transform, RedPointConst.NEW_WARCHESS_HERO_USE .. slot4)
	end
end

function slot0.GetHeroTeamInfoRoute(slot0)
	return "/newWarChessHeroTeamInfoView"
end

function slot0.OnExit(slot0)
	slot0.super.OnExit(slot0)
	slot0:UnBindRedPoint()
end

return slot0
