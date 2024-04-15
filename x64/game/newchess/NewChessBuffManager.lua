slot0 = singletonClass("NewChessBuffManager")

function slot0.Ctor(slot0)
	slot0.ActiveBuffList = {}
	slot0.EntityCount = 0
end

function slot0.SetServerData(slot0, slot1)
	slot0.ActiveBuffList = {}

	for slot5, slot6 in pairs(slot1) do
		slot0.EntityCount = slot0.EntityCount + 1
		slot7 = NewWarChessBuffPoolCfg[slot6.buffID]

		table.insert(slot0.ActiveBuffList, NewChessBuffConfig[slot7.type].New(slot6.buffID, slot0.EntityCount, slot7.updateround, slot7.remainround, slot7.param, {
			updateRound = slot7.updateround - slot6.duration % slot7.updateround,
			remainRound = slot7.remainround - slot6.duration
		}))
	end
end

function slot0.AddBuff(slot0, slot1)
	slot0.EntityCount = slot0.EntityCount + 1
	slot2 = NewWarChessBuffPoolCfg[slot1]
	slot3 = NewChessBuffConfig[slot2.type].New(slot1, slot0.EntityCount, slot2.updateround, slot2.remainround, slot2.param)

	slot3:OnBuffAwake()
	table.insert(slot0.ActiveBuffList, slot3)
	slot3:OnBuffStart()
	manager.NewChessManager:CreateTips({
		tipsType = NewChessConst.TIPS_TYPE.BUFF,
		tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_GET_BUFF"), slot2.name),
		tipsBuffEntity = slot3
	})
	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)

	return slot3
end

function slot0.UpdateBuff(slot0)
	for slot4, slot5 in pairs(slot0.ActiveBuffList) do
		slot5:OnBuffUpdate()
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function slot0.RemoveBuff(slot0, slot1)
	for slot5, slot6 in pairs(slot0.ActiveBuffList) do
		if slot6:GetBuffEntityID() == slot1 then
			slot7 = slot6

			slot7:OnBuffDisable()

			slot0.ActiveBuffList[slot5] = nil

			slot7:OnBuffDestroy()

			return
		end
	end

	manager.notify:CallUpdateFunc(NEWWARCHESS_BUFF_UPDATE)
end

function slot0.GetActiveBuffEntityList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.ActiveBuffList) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.GetBuffEntity(slot0, slot1)
	for slot5, slot6 in pairs(slot0.ActiveBuffList) do
		if slot6.buffPoolID == slot1 then
			return slot6
		end
	end
end

function slot0.Dispose(slot0)
	slot0.ActiveBuffList = {}
	slot0.EntityCount = 0
end

return slot0
