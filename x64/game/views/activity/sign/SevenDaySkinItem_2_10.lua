slot0 = class("SevenDaySkinItem_2_10", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InjectUI()
	slot0:AddListeners()
end

function slot0.InjectUI(slot0)
	slot0:BindCfgUI()

	slot0.ctrl = ControllerUtil.GetController(slot0.transform_, "receive")
	slot0.nameController = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.qualityController = ControllerUtil.GetController(slot0.transform_, "quality")
end

function slot0.RefreshView(slot0, slot1, slot2)
	slot0.item = slot1
	slot3 = slot1[1]

	slot0.group:SetActive(slot1[2] >= 1)
	slot0.ctrl:SetSelectedIndex(slot2)

	slot6 = ItemCfg[slot3].display_rare

	slot0.nameController:SetSelectedIndex(slot6 - 1)
	slot0.qualityController:SetSelectedIndex(slot6 - 1)

	slot0.txt.text = slot4

	if slot3 == 106001 then
		slot0.icon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/106001")
	else
		slot0.icon.sprite = ItemTools.getItemSprite(slot3)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn, nil, handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0)
	ShowPopItem(POP_ITEM, slot0.item)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
