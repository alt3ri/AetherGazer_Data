slot0 = class("HeroRaiseTrack")
slot1 = "UI/HeroCamera/CameraData/camreaData_"

function slot0.Ctor(slot0)
	slot0.trackGo = nil
	slot0.trackTransform = nil
	slot0.curTrack = 0
	slot0.trackList = {}
	slot0.cameraList = {}
	slot0.tx_property_break_Go = nil
	slot0.tx_property_break_Animator = nil
end

function slot0.SetTrackData(slot0, slot1)
	if slot0.curTrack == slot1 or slot1 == 0 then
		return
	end

	if slot0.curTrack ~= 0 then
		SetActive(slot0.trackList[slot0.curTrack], false)
	end

	slot0.curTrack = slot1

	SetActive(slot0.trackList[slot1], true)

	slot7 = Cinemachine.CinemachineVirtualCamera
	slot0.cameraList = {}

	for slot7, slot8 in ipairs(slot0.trackList[slot1].transform:GetComponentsInChildren(typeof(slot7), true):ToTable()) do
		table.insert(slot0.cameraList, slot8)
	end
end

function slot0.LoadTrackGo(slot0)
	slot0.trackGo = Object.Instantiate(Asset.Load("UI/HeroCamera/HeroRaiseTrack_CM.prefab"))
	slot0.trackTransform = slot0.trackGo.transform

	for slot4 = 0, slot0.trackTransform.childCount - 1 do
		slot6 = slot0.trackTransform:GetChild(slot4).gameObject

		SetActive(slot6, false)
		table.insert(slot0.trackList, slot6)
	end

	if slot0.curTrack == 0 then
		slot0:SetTrackData(1)
	end
end

function slot0.ChangeCamera(slot0, slot1)
	slot0:CheckLoadTrackGo()

	slot2 = HeroRaiseTrackConst.HeroRaiseName[slot1] or ""

	if #slot0.cameraList > 0 then
		for slot6, slot7 in ipairs(slot0.cameraList) do
			if slot2 == slot7.name then
				SetActive(slot7.gameObject, true)
			else
				SetActive(slot7.gameObject, false)
			end
		end
	end
end

function slot0.SetActive(slot0, slot1)
	slot0:CheckLoadTrackGo()
	SetActive(slot0.trackGo, slot1)
end

function slot0.UnloadTrackGo(slot0)
	Object.Destroy(slot0.trackGo)

	slot0.trackGo = nil
	slot0.trackTransform = nil
	slot0.curTrack = 0
	slot0.trackList = {}
	slot0.cameraList = {}
end

function slot0.CheckLoadTrackGo(slot0)
	if isNil(slot0.trackGo) then
		slot0:LoadTrackGo()
	end
end

function slot0.Dispose(slot0)
	slot0:UnloadTrackGo()
end

return slot0
