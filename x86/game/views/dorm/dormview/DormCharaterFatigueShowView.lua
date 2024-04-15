slot0 = class("DormCharaterFatigueShowView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.go = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI(slot0.go)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshView(slot0, slot1)
	slot2 = DormData:GetHeroTemplateInfo(slot1)
	slot0.curFatigue.text = slot2:GetFatigue()
	slot0.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.recoverFatigue.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), slot2:GetRecoverFatigueNum())
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
