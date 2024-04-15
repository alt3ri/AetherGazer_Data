slot0 = class("StrongholdOperateBasePage", ReduxView)

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == slot0.active then
		return
	end

	slot0.active = slot1

	if slot1 then
		slot0:OnShow()
	else
		slot0:OnHide()
	end
end

function slot0.OnShow(slot0)
end

function slot0.OnHide(slot0)
end

function slot0.Refresh(slot0, slot1)
end

return slot0
