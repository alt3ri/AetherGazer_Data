slot0 = class("HeroTrammelsNetMissionItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_unlockBtn, function ()
		ArchiveAction.QueryUnlockRelationNet(uv0.net_id, uv0.complete)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.net_id = HeroRelationNetCfg.get_id_list_by_hero_id[slot4][slot2]
	slot0.complete = slot3
	slot7 = HeroRelationUpgradeCfg[slot1]
	slot0.m_conditionDes.text = ArchiveTools.GetRelationUpgradeConditionDes(slot7.condition_id)
	slot11 = slot7.attr[1]
	slot12 = PublicAttrCfg[slot11[1]].name
	slot13 = ""
	slot13 = (PublicAttrCfg[slot11[1]].percent ~= 1 or string.format("%s+%.2f%%", slot12, slot11[2] / 10)) and string.format("%s+%d", slot12, slot11[2])
	slot0.m_attrAdd.text = slot13
	slot0.m_lockEffectDes.text = GetTipsF("HERO_RELATION_UPGRADE_UNLOCK", slot13)

	if HeroData:GetHeroData(slot4).relation:GetIsUnlock(slot2, slot3) then
		slot0.stateController:SetSelectedIndex(2)
	elseif ArchiveTools.CheckRelationUpgradeCondition(slot8, slot5) then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
