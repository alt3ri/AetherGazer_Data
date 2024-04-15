slot0 = singletonClass("SystemData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitData(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.open_system) do
		table.insert(uv0, slot7)
	end
end

function slot0.ModifyData(slot0, slot1)
	slot3 = slot1.close_system

	for slot8, slot9 in ipairs(slot1.open_system) do
		table.insert(uv0, slot9)
		table.insert({}, slot9)
	end

	for slot8, slot9 in ipairs(slot3) do
		if table.indexof(uv0, slot9) then
			table.remove(uv0, slot10)
		end
	end

	slot0:SolveSystemRed(slot4)
end

slot0.ChessSystemId = 312

function slot0.SolveSystemRed(slot0, slot1)
	SystemRedPoint:CheckIsSystemUnlock(slot1)
	BattleEquipData:OnSystemUnlock(slot1)
	DailyNewRedPoint:OnSystemUnlock(slot1)

	if slot0:GetSystemIsOpen(uv0.ChessSystemId) then
		WarChessAction.UpdateWarChessRedPoint()
	end

	manager.notify:Invoke(SYSTEM_OPEN_OR_LOCK, slot1)
end

function slot0.GetSystemIsOpen(slot0, slot1)
	return table.indexof(uv0, slot1) ~= false
end

function slot0.GetOpenSystemList(slot0)
	return uv0
end

function slot0.ServerSystemIsLocked(slot0, slot1)
	if SystemCfg[slot1] and slot2.system_hide == 1 then
		return {
			"server_lock"
		}
	end

	if slot2 and not SystemData:GetSystemIsOpen(slot1) then
		return {
			"server_lock"
		}
	end

	return JumpTools.CustomLock(slot1)
end

return slot0
