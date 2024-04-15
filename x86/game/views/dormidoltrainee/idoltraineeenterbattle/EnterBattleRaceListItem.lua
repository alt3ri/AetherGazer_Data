slot0 = class("EnterBattleRaceListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.iconImg_.sprite = HeroTools.GetRaceIcon(slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
