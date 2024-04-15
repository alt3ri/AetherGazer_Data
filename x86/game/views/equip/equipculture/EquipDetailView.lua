slot0 = class("EquipDetailView", EquipBaseView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.params_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)

	slot0.equipInfoView = EquipInfoView.New(slot0.equipInfoGo_)

	slot0.equipInfoView:RegisterSkillClick(handler(slot0, slot0.SkillClick))
	slot0.equipInfoView:RegisterChange(handler(slot0, slot0.HidePop))
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnSource_, nil, function ()
		ShowPopItemSource(uv0.equip_.prefab_id)
	end)
end

function slot0.RegistHeroButton(slot0, slot1, slot2)
	slot0.changeFunc_ = slot1
	slot0.cultureFunc_ = slot2
end

function slot0.OnEnter(slot0)
	slot0:OnEquipChange(slot0.params_.equipId)
end

function slot0.OnEquipChange(slot0, slot1)
	SetActive(slot0.equipInfoGo_, false)

	slot0.equipId = slot1
	slot0.equip_ = EquipData:GetEquipData(slot0.equipId) or EquipStruct.New(0, slot0.params_.prefabId)

	slot0.equipInfoView:RefreshData(slot0, slot0.equip_, nil, slot0.params_.heroId, slot1)
	SetActive(slot0.equipInfoGo_, true)
end

function slot0.SkillClick(slot0, slot1, slot2)
	if slot0.handler_.RefreshSkillInfo then
		slot0.handler_:RefreshSkillInfo(slot1, slot2)
	end
end

function slot0.HidePop(slot0)
	if slot0.handler_.HidePop then
		slot0.handler_:HidePop()
	end
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()
end

function slot0.Dispose(slot0)
	slot0.equipInfoView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
