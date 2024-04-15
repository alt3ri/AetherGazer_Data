slot0 = class("ReserveMimirDataTemplate")

function slot0.Ctor(slot0)
	slot0.mimir_id = 0
	slot0.chip_list = {}
end

function slot0.UpdateServerData(slot0, slot1)
	slot0.mimir_id = slot1.mimir_id
	slot0.chip_list = cleanProtoTable(slot1.chip_list)
end

function slot0.ConvertToSendData(slot0)
	return {
		mimir_id = slot0.mimir_id,
		chip_list = clone(slot0.chip_list)
	}
end

function slot0.Reset(slot0)
	slot0.mimir_id = 0
	slot0.chip_list = {}
end

return slot0
