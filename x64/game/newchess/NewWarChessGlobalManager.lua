NewWarChessGlobalEventEntity = class("NewWarChessGlobalEventEntity")

function NewWarChessGlobalEventEntity.Ctor(slot0, slot1)
	slot0.globalEventID_ = slot1
	slot0.active_ = true
end

function NewWarChessGlobalEventEntity.SetServerData(slot0, slot1, slot2)
end

function NewWarChessGlobalEventEntity.Check(slot0, slot1)
end

function NewWarChessGlobalEventEntity.OnSettlement(slot0, slot1)
end

function NewWarChessGlobalEventEntity.Dispose(slot0)
	slot0.globalEventID_ = nil
end

NewWarChessGlobalEventEntity_Type_1 = class("NewWarChessGlobalEventEntity_Type_1", NewWarChessGlobalEventEntity)

function NewWarChessGlobalEventEntity_Type_1.Ctor(slot0, slot1, slot2)
	slot0.super:Ctor(slot1)

	slot3 = NewWarChessGlobalCfg[slot1]
	slot0.xzList_ = deepClone(slot3.params[1])
	slot0.initExtendObjectID_ = slot3.params[2]
	slot0.successAni_ = slot3.params[3]
	slot0.faildAni_ = slot3.params[4]
	slot0.eventStatus_ = 0

	if not slot2 then
		for slot7, slot8 in pairs(slot0.xzList_) do
			manager.NewChessManager:ChangeObjectByExtentID(slot8[1], slot8[2], slot0.initExtendObjectID_)
		end

		if slot3.start_event ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				slot0.globalEventID_
			}))
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1.SetServerData(slot0, slot1, slot2)
	slot0.eventStatus_ = slot1
	slot0.severxzList_ = slot2
end

function NewWarChessGlobalEventEntity_Type_1.Check(slot0, slot1)
	if slot0.eventStatus_ ~= 0 then
		slot0:OnSettlement(slot1)
	end
end

function NewWarChessGlobalEventEntity_Type_1.OnSettlement(slot0, slot1)
	if slot0.active_ == false then
		return
	end

	slot0.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	if #slot0.severxzList_ > 0 then
		for slot6, slot7 in pairs(slot0.severxzList_) do
			slot10 = nil

			if slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				manager.NewChessManager:PlayGridAnimation(slot7[1], slot7[2], slot0.successAni_, 2, function ()
					uv0 = uv0 - 1

					if uv0 <= 0 then
						for slot3, slot4 in pairs(uv1.xzList_) do
							manager.NewChessManager:DeleteObject(slot4[1], slot4[2])
						end

						if NewWarChessGlobalCfg[uv1.globalEventID_].success_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								uv1.globalEventID_
							}))
							manager.NewChessManager:StartExecuteEvent()
						end

						if uv2 then
							uv2()
						end
					end
				end)
			elseif slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				manager.NewChessManager:PlayGridAnimation(slot8, slot9, slot0.faildAni_, 2, function ()
					uv0 = uv0 - 1

					if uv0 <= 0 then
						for slot3, slot4 in pairs(uv1.xzList_) do
							manager.NewChessManager:DeleteObject(slot4[1], slot4[2])
						end

						if NewWarChessGlobalCfg[uv1.globalEventID_].fail_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								uv1.globalEventID_
							}))
							manager.NewChessManager:StartExecuteEvent()
						end

						if uv2 then
							uv2()
						end
					end
				end)
			end
		end
	else
		for slot6, slot7 in pairs(slot0.xzList_) do
			manager.NewChessManager:DeleteObject(slot7[1], slot7[2])
		end

		if slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[slot0.globalEventID_].success_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					slot0.globalEventID_
				}))
				manager.NewChessManager:StartExecuteEvent()
			end

			if slot1 then
				slot1()
			end
		else
			if NewWarChessGlobalCfg[slot0.globalEventID_].fail_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					slot0.globalEventID_
				}))
				manager.NewChessManager:StartExecuteEvent()
			end

			if slot1 then
				slot1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_1.Dispose(slot0)
	slot0.xzList_ = nil
	slot0.initExtendObjectID_ = nil
	slot0.successAni_ = nil
	slot0.faildAni_ = nil
	slot0.severxzList_ = nil
	slot0.eventStatus_ = nil

	slot0.super:Dispose()
end

NewWarChessGlobalEventEntity_Type_2 = class("NewWarChessGlobalEventEntity_Type_2", NewWarChessGlobalEventEntity)

function NewWarChessGlobalEventEntity_Type_2.Ctor(slot0, slot1, slot2)
	slot0.super:Ctor(slot1)

	slot3 = NewWarChessGlobalCfg[slot1]
	slot0.hexInfoList_ = deepClone(slot3.params[1])
	slot0.successAni_ = slot3.params[2]
	slot0.faildAni_ = slot3.params[3]
	slot0.eventStatus_ = 0

	if not slot2 then
		for slot7, slot8 in pairs(slot0.hexInfoList_) do
			for slot13, slot14 in pairs(slot8) do
				if slot13 > 1 then
					manager.NewChessManager:ChangeObjectByExtentID(slot14[1], slot14[2], slot8[1])
				end
			end
		end

		if slot3.start_event ~= 0 then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
				slot0.globalEventID_
			}))
			manager.NewChessManager:StartExecuteEvent()
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2.SetServerData(slot0, slot1, slot2)
	slot0.eventStatus_ = slot1
	slot0.severxzList_ = slot2
end

function NewWarChessGlobalEventEntity_Type_2.Check(slot0, slot1)
	if slot0.eventStatus_ ~= 0 then
		slot0:OnSettlement(slot1)
	end
end

function NewWarChessGlobalEventEntity_Type_2.OnSettlement(slot0, slot1)
	if slot0.active_ == false then
		return
	end

	slot0.active_ = false

	manager.NewChessManager:ClearInteractChess()
	NewChessLuaBridge.StopRoleMoving()

	if #slot0.severxzList_ > 0 then
		for slot6, slot7 in pairs(slot0.severxzList_) do
			slot10 = nil

			if slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
				manager.NewChessManager:PlayGridAnimation(slot7[1], slot7[2], slot0.successAni_, 2, function ()
					uv0 = uv0 - 1

					if uv0 <= 0 then
						for slot3, slot4 in pairs(uv1.hexInfoList_) do
							for slot8, slot9 in pairs(slot4) do
								if slot8 > 1 then
									manager.NewChessManager:DeleteObject(slot9[1], slot9[2])
								end
							end
						end

						if NewWarChessGlobalCfg[uv1.globalEventID_].success_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								uv1.globalEventID_
							}))
							manager.NewChessManager:StartExecuteEvent()
						end

						if uv2 then
							uv2()
						end
					end
				end)
			elseif slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.FAILD then
				manager.NewChessManager:PlayGridAnimation(slot8, slot9, slot0.faildAni_, 2, function ()
					uv0 = uv0 - 1

					if uv0 <= 0 then
						for slot3, slot4 in pairs(uv1.hexInfoList_) do
							for slot8, slot9 in pairs(slot4) do
								if slot8 > 1 then
									manager.NewChessManager:DeleteObject(slot9[1], slot9[2])
								end
							end
						end

						if NewWarChessGlobalCfg[uv1.globalEventID_].fail_event ~= 0 then
							manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
								uv1.globalEventID_
							}))
							manager.NewChessManager:StartExecuteEvent()
						end

						if uv2 then
							uv2()
						end
					end
				end)
			end
		end
	else
		for slot6, slot7 in pairs(slot0.hexInfoList_) do
			for slot11, slot12 in pairs(slot7) do
				if slot11 > 1 then
					manager.NewChessManager:DeleteObject(slot12[1], slot12[2])
				end
			end
		end

		if slot0.eventStatus_ == NewChessConst.GLOBAL_EVENT_STATUS.SUCCESS then
			if NewWarChessGlobalCfg[slot0.globalEventID_].success_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					slot0.globalEventID_
				}))
				manager.NewChessManager:StartExecuteEvent()
			end

			if slot1 then
				slot1()
			end
		else
			if NewWarChessGlobalCfg[slot0.globalEventID_].fail_event ~= 0 then
				manager.NewChessManager:ExecutChess(NewChessConst.TIMING_GLOBAL_EVENT, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_GLOBAL_EVENT, {
					slot0.globalEventID_
				}))
				manager.NewChessManager:StartExecuteEvent()
			end

			if slot1 then
				slot1()
			end
		end
	end
end

function NewWarChessGlobalEventEntity_Type_2.Dispose(slot0)
	slot0.hexInfoList_ = nil
	slot0.successAni_ = nil
	slot0.faildAni_ = nil
	slot0.severxzList_ = nil
	slot0.eventStatus_ = nil

	slot0.super:Dispose()
end

slot0 = singletonClass("NewWarChessGlobalManager")
slot1 = {
	NewWarChessGlobalEventEntity_Type_1,
	NewWarChessGlobalEventEntity_Type_2
}

function slot0.Ctor(slot0)
	slot0.ActiveGlobalEventList_ = {}
	slot0.NextInitGlobalEventList_ = {}
end

function slot0.SetServerData(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.ActiveGlobalEventList_[slot6] = uv0[NewWarChessGlobalCfg[slot6].type].New(slot6, true)
	end
end

function slot0.InsertNextInitGlobalEvent(slot0, slot1)
	table.insert(slot0.NextInitGlobalEventList_, slot1)
end

function slot0.InitGlobalEvent(slot0, slot1)
	if NewWarChessGlobalCfg[slot1] == nil then
		error("NewWarChessGlobalCfg 中不存在", slot1)

		return
	end

	slot0.ActiveGlobalEventList_[slot1] = uv0[slot2.type].New(slot1, false)
end

function slot0.UpdateGlobalEventServerData(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot0.ActiveGlobalEventList_) do
		if slot8.globalEventID_ == slot1 then
			slot8:SetServerData(slot2, slot3)

			return
		end
	end
end

function slot0.CheckStartGlobalEventList(slot0)
	for slot4, slot5 in pairs(slot0.NextInitGlobalEventList_) do
		slot0.NextInitGlobalEventList_[slot4] = nil

		slot0:InitGlobalEvent(slot0.NextInitGlobalEventList_[slot4])
	end

	slot0.NextInitGlobalEventList_ = {}
end

function slot0.CheckSettlementGlobalEventList(slot0)
	for slot4, slot5 in pairs(slot0.ActiveGlobalEventList_) do
		slot5:Check(function ()
			uv0.ActiveGlobalEventList_[uv1.globalEventID_] = nil

			uv1:Dispose()
		end)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.ActiveGlobalEventList_) do
		slot5:Dispose()
	end

	slot0.ActiveGlobalEventList_ = {}
	slot0.NextInitGlobalEventList_ = {}
end

return slot0
