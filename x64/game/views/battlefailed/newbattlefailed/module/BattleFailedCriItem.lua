slot0 = class("BattleFailedCriItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.OnRenderItem(slot0, slot1)
	slot0.typeImg_.sprite = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
