slot0 = class("DrawInfoCommonItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.upCon_ = slot0.transform_:GetComponent("ControllerExCollection"):GetController("UP")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBg_, nil, function ()
		if uv0.isHero then
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				hid = DrawItemCfg[uv0.itemId].item_id
			})
		else
			uv0:Go("/showServantView", {
				stage = 5,
				state = "onlydetail",
				id = slot0
			})
		end
	end)
end

function slot0.RefreshData(slot0, slot1, slot2)
	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end

	slot0:Show(true)

	slot0.item = CommonItemView.New(slot0.commonItem)
	slot0.isHero = slot2
	slot0.itemId = slot1

	if slot2 then
		slot0.item:SetData({
			id = DrawItemCfg[slot1].item_id or 0
		})
	else
		slot0.item:SetData({
			id = slot4
		})
	end
end

function slot0.RefreshUp(slot0, slot1, slot2)
	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			if slot0.itemId == slot7 then
				slot0.upCon_:SetSelectedIndex(1)

				break
			end
		end
	else
		slot0.upCon_:SetSelectedIndex(0)
	end

	if not slot2 then
		slot0.upCon_:SetSelectedIndex(0)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.item then
		slot0.item:Dispose()
		Object.Destroy(slot0.item.gameObject_)

		slot0.item = nil
	end

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot0
