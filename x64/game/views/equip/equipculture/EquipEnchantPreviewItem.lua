slot0 = class("EquipEnchantPreviewItem", ReduxView)

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
	slot0:InitEnchant()

	slot0.stateController_ = slot0.transCon_:GetController("state")
	slot0.skillItemList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnChoose_, nil, function ()
		uv0:OnEnchantConfirmClick(true)
	end)
	slot0:AddBtnListener(slot0.btnDelete_, nil, function ()
		uv0:OnEnchantConfirmClick(false)
	end)
end

function slot0.InitEnchant(slot0)
	slot0.skills = {}

	for slot4 = 1, 2 do
		slot0.skills[slot4] = EnchantSkillItem.New(slot0["skill_" .. slot4])
	end
end

function slot0.OnEnchantConfirmClick(slot0, slot1)
	EquipAction.QueryEquipEnchantConfirm(slot0.equipId, slot0.enchatPos, slot1, slot0.index)
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.equipId = slot3
	slot0.prefabId = EquipData:GetEquipData(slot0.equipId).prefab_id
	slot0.enchatPos = slot4
	slot0.index = slot5
	slot0.textIndex_.text = slot0.index
	slot0.isEmpty_ = true
	slot7 = {}

	for slot11, slot12 in ipairs(slot1) do
		slot7[slot12.id] = slot7[slot12.id] and slot7[slot12.id] + 1 or 1
	end

	for slot11, slot12 in ipairs(slot0.skills) do
		slot13 = nil

		if slot1[slot11] then
			slot0.isEmpty_ = false
			slot14 = slot1[slot11].id
			slot15 = {
				isEquip = true,
				level = 1,
				id = slot0.equipId,
				prefab_id = slot0.prefabId
			}
			slot16 = 1

			if slot2 and slot2[slot14] then
				slot17 = clone(slot2[slot14])

				if not slot6[slot14] then
					slot17.num = slot17.num + 1
				else
					slot17.num = slot17.num + slot7[slot14] - slot6[slot14]
				end

				slot18 = false

				for slot22, slot23 in ipairs(slot17.location) do
					if slot23.id == slot0.equipId then
						slot23.level = slot23.level + slot16
						slot18 = true

						break
					end
				end

				if not slot18 then
					table.insert(slot17.location, slot15)
				end

				slot13 = slot17
			else
				slot13 = {
					num = 1,
					isShowLocate = true,
					id = slot14,
					location = {
						slot15
					}
				}
			end
		end

		slot12:RefreshData(slot13)
		slot12:RegistCallBack(function (slot0, slot1)
			if uv0.skllCallBack then
				uv0.skllCallBack(slot0, slot1)
			end
		end)
	end

	slot0.stateController_:SetSelectedState(slot0.isEmpty_ and "empty" or "notEmpty")
end

function slot0.RegistSkillClickCallBck(slot0, slot1)
	slot0.skllCallBack = slot1
end

function slot0.ShowAnim(slot0)
	slot0.glowAnim_:Play("glow_bg", -1, 0)
end

function slot0.Dispose(slot0)
	if slot0.skillItemList then
		for slot4, slot5 in ipairs(slot0.skillItemList) do
			slot5:Dispose()
		end

		slot0.skillItemList = {}
	end

	for slot4, slot5 in pairs(slot0.skills) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
