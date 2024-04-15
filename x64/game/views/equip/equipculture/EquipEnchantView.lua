slot0 = class("EquipEnchantView", EquipBaseView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.params_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitEnchant()

	slot0.skillFixedItems_ = {}
	slot0.fixedSkillScroller_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.fixedListGo_, EnchantSkillItem)
end

function slot0.InitEnchant(slot0)
	slot0.enchants = {}

	for slot4 = 1, 2 do
		slot5 = {
			skills = {}
		}

		ComponentBinder.GetInstance():BindCfgUI(slot5, slot0["enchant_" .. slot4])

		slot9 = "lock"
		slot5.lockController_ = slot5.transCon_:GetController(slot9)

		for slot9 = 1, 2 do
			slot5.skills[slot9] = EnchantSkillItem.New(slot5["skill_" .. slot9])
		end

		slot0:AddBtnListener(slot5.button_, nil, function ()
			uv0:OnEnchantClick(uv1)
		end)
		table.insert(slot0.enchants, slot5)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		JumpTools.OpenPageByJump("equipSkillPreviewPage", {
			equipId = uv0.equipId
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:OnEquipChange(slot0.params_.equipId)
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.slotNum = EquipCfg[slot0.equip.prefab_id].slot_num or 0
	slot0.slotOpenLevel = slot2.slot_open_level or {}

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if not slot0.equip then
		return
	end

	slot0:RefreshFixedSkill()
	slot0:RefreshEnchantSkill()
end

function slot0.RefreshFixedSkill(slot0)
	slot0.fixedSkillList_ = slot0.equip:GetBaseSkill()

	slot0.fixedSkillScroller_:StartScroll(#slot0.fixedSkillList_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.fixedSkillList_[slot1]
	slot3.equipLevel = slot0.equip:GetLevel()

	slot2:RegistCallBack(handler(slot0, slot0.OnEnchantSkillClick))
	slot2:RefreshData(slot3)
end

function slot0.RefreshEnchantSkill(slot0)
	for slot4 = 1, slot0.slotNum do
		slot6 = slot0.equip.enchant[slot4]

		SetActive(slot0.enchants[slot4].gameObject_, true)

		if slot0.equip:GetLevel() < (slot0.slotOpenLevel[slot4] or 0) then
			slot5.lockController_:SetSelectedState("lock")

			slot5.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot7)
		elseif not slot6 or #slot6 == 0 then
			slot5.lockController_:SetSelectedState("empty")
		else
			slot5.lockController_:SetSelectedState("skill")
		end

		if #slot6 > 0 then
			for slot11 = 1, 2 do
				if slot6[slot11] then
					slot12.equipLevel = slot0.equip:GetLevel()
				end

				slot5.skills[slot11]:RefreshData(slot12)
			end
		end
	end

	for slot4 = slot0.slotNum + 1, #slot0.enchants do
		SetActive(slot0.enchants[slot4].gameObject_, false)
	end
end

function slot0.OnEnchantClick(slot0, slot1)
	if slot0.equip:GetLevel() < (slot0.slotOpenLevel[slot1] or 0) then
		ShowTips(string.format(GetTips("EQUIP_ENCHANT_OEPN_LEVEL"), slot2))

		return
	end

	slot0.handler_:HidePop()
	slot0:Go("/enchantChangeView", {
		equipId = slot0.equipId,
		enchatPos = slot1,
		proxy = slot0.params_.proxy
	})
end

function slot0.OnEnchantSkillClick(slot0, slot1, slot2)
	slot0.handler_:RefreshSkillInfo(slot1, slot2)
end

function slot0.OnExit(slot0)
	slot0.handler_:HidePop()
end

function slot0.Dispose(slot0)
	slot0.fixedSkillScroller_:Dispose()

	for slot4, slot5 in ipairs(slot0.enchants) do
		for slot9 = 1, 2 do
			slot5.skills[slot9]:Dispose()
		end
	end

	slot0.enchants = nil

	uv0.super.Dispose(slot0)
end

return slot0
