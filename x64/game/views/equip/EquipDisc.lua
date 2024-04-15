slot0 = class("EquipDisc", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipItem_ = {}

	for slot4 = 1, 6 do
		slot0.equipItem_[slot4] = EquipItem.New(slot0["equipItem_" .. slot4])
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0, slot1)
	if slot1.oldIndex and slot1.newIndex then
		slot0:ResetAngle()

		if slot1.oldIndex == slot1.newIndex then
			slot0.rotateServant_.transform.localEulerAngles = Vector3.New(0, 0, -120 - (slot1.newIndex - 1) * 60)

			slot0:HideItems()
		else
			slot0:RotateServant(slot1.oldIndex, slot1.newIndex)
		end
	end

	slot0.isShowDetail_ = slot1.isShowDetail
end

function slot0.RefreshItem(slot0, slot1)
	for slot5 = 1, 6 do
		slot0.equipItem_[slot5]:RefreshData(slot1[slot5], slot0.isShowDetail_)
		slot0.equipItem_[slot5]:RegistCallBack(function (slot0, slot1)
			if uv0.itemClickCallBack then
				uv0.itemClickCallBack(slot0, uv1)

				if uv0.lastSelectItem_ then
					uv0.lastSelectItem_:ShowSelect(false)
				end

				slot1:ShowSelect(true)

				uv0.lastSelectItem_ = slot1
			end
		end)
	end
end

function slot0.Reset(slot0)
	for slot4 = 1, 6 do
		slot0.equipItem_[slot4]:ShowSelect(false)
	end
end

function slot0.PlayAnim(slot0, slot1)
	if slot1 then
		slot0.servantAnim_:Play("Fx_servant_change")
	else
		slot0.servantAnim_:Play("Fx_servant_cx")
	end
end

function slot0.RotateServant(slot0, slot1, slot2)
	slot0.index_ = slot2

	if slot0:GetAngle(slot1, slot2) ~= 0 then
		slot0.rotateLeanTween_ = LeanTween.rotateAroundLocal(slot0.rotateServant_, Vector3.New(0, 0, 1), slot3, 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function slot0.GetAngle(slot0, slot1, slot2)
	if math.abs((slot1 - slot2) * 60) > 180 then
		slot3 = slot3 > 0 and slot3 - 360 or slot3 + 360
	end

	return slot3
end

function slot0.HideItems(slot0)
	for slot4, slot5 in ipairs(slot0.equipItem_) do
		slot5:Hide()
	end
end

function slot0.RegistItemButton(slot0, slot1)
	slot0.itemClickCallBack = slot1
end

function slot0.ShowAnim(slot0, slot1)
	slot0.equipItem_[slot1]:ShowAnim()
end

function slot0.RefreshItemByIndex(slot0, slot1, slot2)
	slot0.equipItem_[slot1]:RefreshData(slot2)
end

function slot0.ResetAngle(slot0)
	slot0.rotateServant_.transform.rotation = Vector3.zero
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.equipItem_) do
		slot5:Dispose()
	end

	slot0.equipItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
