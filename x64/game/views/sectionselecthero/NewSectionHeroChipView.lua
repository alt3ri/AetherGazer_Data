slot0 = class("NewSectionHeroChipView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Show(true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = slot0.controllerExCollection_:GetController("lock")
	slot0.managerController_ = slot0.controllerExCollection_:GetController("chipManager")
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			return
		end

		if uv0.isCustom_ then
			ShowTips("CANNOT_CHANGE_CHIP")

			return
		end

		ChipAction:UpdateChipRed()
		uv0:Go("/battleChipManager", {
			stageType = uv0.stageType_,
			stageID = uv0.stageID_,
			reserveParams = uv0.reserveParams_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.reserveParams_ = slot3
	slot0.isCustom_ = false

	if BattleStageTools.GetStageCfg(slot1, slot2) and type(slot4.chip_list) == "table" then
		slot0.isCustom_ = true
		slot0.enabledID_ = slot4.chip_list[1]
		slot0.chipList_ = {}

		for slot8 = 2, 3 do
			slot0.chipList_[slot8 - 1] = slot4.chip_list[slot8]
		end

		slot0:RefreshUI()

		return
	end

	slot0.enabledID_ = slot0:GetChipManagerID()
	slot0.chipList_ = slot0:GetChipList()

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLock()
	slot0:RefreshChipManager()
	slot0:RefreshChipList()
end

function slot0.RefreshLock(slot0)
	slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == true

	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.RefreshChipManager(slot0)
	if (slot0.enabledID_ or 0) ~= 0 then
		slot0.managerController_:SetSelectedState("true")

		slot0.chipManagerIcon_.sprite = ChipTools.GetChipManagerIcon(slot1)
	else
		slot0.managerController_:SetSelectedState("false")
	end
end

function slot0.RefreshChipList(slot0)
	slot1 = slot0.chipList_

	if GameSetting.ai_secondary_chip_equip_num.value[1] < #slot0.chipList_ then
		for slot6 = #slot0.chipList_, slot2 + 1, -1 do
			slot0.chipList_[slot6] = nil
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7 == nil or slot7 == 0 then
			break
		end

		SetActive(slot0[string.format("chipIconGo_%s", slot6)], true)

		if ChipCfg[slot7] == nil then
			print(string.format("ChipCfg[%s] is nil", slot7))
		end

		slot0[string.format("chipIcon_%s", slot6)].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot7].picture_id)
	end

	for slot6 = #slot1 + 1, slot2 do
		SetActive(slot0[string.format("chipIconGo_%s", slot6)], false)
	end
end

function slot0.GetChipManagerID(slot0)
	return ReserveTools.GetMimirID(slot0.reserveParams_)
end

function slot0.GetChipList(slot0)
	return ReserveTools.GetMimirChipList(slot0.reserveParams_)
end

function slot0.GetCurEnabledID(slot0)
	return slot0.enabledID_ or 0
end

function slot0.GetCurChipList(slot0)
	return slot0.chipList_ or {}
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
