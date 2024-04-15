slot0 = class("StrongholdAtlasItem", ReduxView)

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
	slot0.rareController = ControllerUtil.GetController(slot0.transform_, "rare")
	slot0.typeController = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = ActivityStrongholdArtifactCfg[slot1]

	if StrongholdData:GetAtlasUseCount(slot2, slot1) == 0 then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)

		slot0.m_name.text = slot3.name
		slot0.m_des.text = slot3.desc
		slot0.m_icon.sprite = getSpriteWithoutAtlas(slot3.icon)

		slot0.rareController:SetSelectedIndex(slot3.rare - 1)

		slot0.m_useCount.text = string.format(GetTips("ACTIVITY_STRONGHOLD_ATLAS_USE_COUNT"), slot4)
	end

	slot0.typeController:SetSelectedIndex(slot3.type)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
