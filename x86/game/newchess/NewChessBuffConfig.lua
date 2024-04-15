BaceAction = class("BaceAction")

function BaceAction.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.buffPoolID = slot1
	slot0.buffEntityID = slot2
	slot0.RemainRound = slot4

	if slot6 then
		slot0.CurRemainRound = slot6.remainRound
	else
		slot0.CurRemainRound = slot0.RemainRound
	end
end

function BaceAction.GetBuffEntityID(slot0)
	return slot0.buffEntityID
end

function BaceAction.OnBuffAwake(slot0)
end

function BaceAction.OnBuffStart(slot0)
end

function BaceAction.OnBuffUpdate(slot0)
	if slot0.CurRemainRound > 0 then
		slot0.CurRemainRound = slot0.CurRemainRound - 1

		if slot0.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(slot0.buffEntityID)
		end
	end
end

function BaceAction.OnBuffDisable(slot0)
end

function BaceAction.OnBuffDestroy(slot0)
end

BaceBuff = class("BaceBuff")

function BaceBuff.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.buffPoolID = slot1
	slot0.buffEntityID = slot2
	slot0.EventPoolID = slot5[1]
	slot0.UpdateRound = slot3
	slot0.RemainRound = slot4

	if slot6 then
		slot0.CurRemainRound = slot6.remainRound
		slot0.CurUpdateRound = slot6.updateRound
	else
		slot0.CurRemainRound = slot0.RemainRound
		slot0.CurUpdateRound = slot0.UpdateRound
	end
end

function BaceBuff.GetBuffEntityID(slot0)
	return slot0.buffEntityID
end

function BaceBuff.OnBuffAwake(slot0)
end

function BaceBuff.OnBuffStart(slot0)
end

function BaceBuff.OnBuffUpdate(slot0)
	slot0.CurUpdateRound = slot0.CurUpdateRound - 1

	if slot0.CurUpdateRound <= 0 then
		if slot0.EventPoolID ~= nil then
			manager.NewChessManager:ExecutChess(NewChessConst.TIMING_BUFF, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_BUFF, {
				slot0.buffPoolID
			}))
			manager.NewChessManager:StartExecuteEvent()
		end

		slot0.CurUpdateRound = slot0.UpdateRound
	end

	if slot0.CurRemainRound > 0 then
		slot0.CurRemainRound = slot0.CurRemainRound - 1

		if slot0.CurRemainRound <= 0 then
			manager.NewChessManager:RemoveBuff(slot0.buffEntityID)
		end
	end
end

function BaceBuff.OnBuffDisable(slot0)
end

function BaceBuff.OnBuffDestroy(slot0)
end

SubAttributeBuff = class("SubAttributeBuff", BaceAction)

function SubAttributeBuff.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.super.Ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)

	slot0.attributeID = slot5[1]
	slot0.num = slot5[2]
end

function SubAttributeBuff.OnBuffStart(slot0)
	NewWarChessData:SubAttribute(slot0.attributeID, slot0.num)
end

function SubAttributeBuff.OnBuffDisable(slot0)
	NewWarChessData:SubAttribute(slot0.attributeID, -slot0.num)
end

return {
	[1000] = SubAttributeBuff,
	[1001] = BaceBuff
}
