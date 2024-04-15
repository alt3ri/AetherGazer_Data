slot0 = class("WeaponServantStoryModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.OnRenderModule(slot0, slot1)
	slot0.storyText_.text = WeaponServantCfg[slot1.servantData.id].story
end

return slot0
