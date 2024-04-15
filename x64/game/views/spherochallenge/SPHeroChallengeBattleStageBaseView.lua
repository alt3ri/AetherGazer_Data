slot0 = class("SPHeroChallengeBattleStageBaseView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.GetUIName(slot0)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
