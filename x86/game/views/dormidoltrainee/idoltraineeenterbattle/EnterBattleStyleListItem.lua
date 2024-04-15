slot0 = class("EnterBattleStyleListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.style_.text = GetTips("IDOL_DANCE_TYPE_TIPS_" .. slot1)
	slot0.color_.color = IdolTraineeConst.styleColor[slot1]
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
