slot0 = class("DanceGameTaskRunner", DormTaskRunner)

function slot0.Ctor(slot0)
	uv0.super.Ctor(slot0)

	slot0.offset = 0
end

function slot0.SetPlayback(slot0, slot1)
	slot0.playSrc = slot1
	slot0.offset = 0
end

function slot0.Time(slot0)
	if slot0.playSrc == nil then
		return 0
	end

	slot1, slot2 = nil
	slot3, slot2 = int64.tonum2(slot0.playSrc:GetTimeSyncedWithAudio())

	if slot0.lastUpdate and slot3 + slot0.offset < slot0.lastUpdate then
		slot3, slot4 = int64.tonum2(slot0.playSrc:GetTime())
		slot1 = slot3
		slot0.offset = slot3 - slot1
	end

	return slot1 / 1000
end

function slot0.Reset(slot0)
	slot0.playSrc = nil
	slot0.offset = 0

	uv0.super.Reset(slot0)
end

return slot0
