slot0 = class("ProposalCheck", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/EquipmentUsePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.equipS_ = {}
	slot0.itemS_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.InitItem(slot0, slot1)
	slot2 = {}

	ComponentBinder.GetInstance():BindCfgUI(slot2, slot1)

	slot2.gameObject_ = slot1
	slot2.equip = EquipItem.New(slot2.equipItemGo_)

	function slot2.RefreshUI(slot0, slot1)
		slot0.equip:RefreshData(slot1, true)

		slot0.heroIcon_.sprite = HeroTools.GetSmallHeadSprite(slot1.equiping)
	end

	return slot2
end

function slot0.RefreshItems(slot0)
	for slot4 = 1, #slot0.list_ do
		if not slot0.itemS_[slot4] then
			slot5 = Object.Instantiate(slot0.itemGo_, slot0.equipTrs_)
			slot0.itemS_[slot4] = slot0:InitItem(slot5)

			SetActive(slot5, true)
			slot0.itemS_[slot4]:RefreshUI(slot0.list_[slot4])
		else
			SetActive(slot0.itemS_[slot4].gameObject_, true)
			slot0.itemS_[slot4]:RefreshUI(slot0.list_[slot4])
		end
	end

	for slot4 = #slot0.list_ + 1, #slot0.itemS_ do
		SetActive(slot0.itemS_[slot4].gameObject_, false)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_okBtn_, nil, function ()
		for slot4 = 1, #uv0.equipS_ do
		end

		EquipAction.EquipQuickDressOn(uv0.heroID_, {
			[slot4] = {
				pos = uv0.equipS_[slot4].pos,
				equip_id = uv0.equipS_[slot4].equip_id
			}
		})
	end)
	slot0:AddBtnListener(slot0.btn_cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEquipQuickDressOn(slot0, slot1, slot2)
	for slot6 = 1, 6 do
		HeroAction.HeroChangeEquip(slot2.hero_id, slot2.use_equip_list[slot6].equip_id, slot2.use_equip_list[slot6].pos)
	end

	slot0:Back()
end

function slot0.OnEnter(slot0)
	slot0.equipS_ = slot0.params_.equipS
	slot0.heroID_ = slot0.params_.heroID

	slot0:UpdateData()
	slot0:RefreshItems()
end

function slot0.OnExit(slot0)
end

function slot0.UpdateData(slot0)
	slot0.list_ = {}

	for slot4, slot5 in pairs(slot0.equipS_) do
		if slot5.equip_id ~= 0 and slot5.equiping then
			slot7 = deepClone(EquipData:GetEquipData(slot6))
			slot7.equiping = slot5.equiping

			table.insert(slot0.list_, slot7)
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.itemS_) do
		slot5.equip:Dispose()
	end

	slot0.itemS_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
