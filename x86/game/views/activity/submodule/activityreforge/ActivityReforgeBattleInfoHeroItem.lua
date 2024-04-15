slot0 = class("ActivityReforgeBattleInfoHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroHeadItem_ = ActivityReforgeHeroHeadItem.New(slot0.heroHeadGo_)
end

function slot0.SetData(slot0, slot1, slot2)
	if ActivityReforgeData:GetFinishWaveHeroInfo(slot1, slot2).leftHp <= 0 then
		SetActive(slot0.diePanelGo_, true)

		slot0.curHpImage_.fillAmount = 0
	else
		SetActive(slot0.diePanelGo_, false)

		slot0.curHpImage_.fillAmount = slot3.leftHp / slot3.maxHp
	end

	slot0.heroHeadItem_:SetData(slot2)
end

function slot0.Dispose(slot0)
	slot0.heroHeadItem_:Dispose()

	slot0.heroHeadItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
