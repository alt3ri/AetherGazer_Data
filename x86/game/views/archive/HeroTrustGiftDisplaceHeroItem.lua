slot0 = class("HeroTrustGiftDisplaceHeroItem", ReduxView)

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

	slot0.favorabilityController = ControllerUtil.GetController(slot0.transform_, "favorability")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.roleImg_.sprite = getSpriteViaConfig("HeroItemshead", slot1)
	slot0.nameText_.text = HeroCfg[slot1].name

	if ArchiveData:GetTrustLevel(slot1) > 0 then
		slot0.favorabilityController:SetSelectedIndex(1)

		slot0.favorExText_.text = ArchiveTools.GetTrustLvDes(slot2)
	else
		slot0.favorabilityController:SetSelectedIndex(0)

		slot0.favorExText_.text = GetTipsF("HERO_TRUST_DISPLACE_LOVE", ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot1][1]).lv)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
