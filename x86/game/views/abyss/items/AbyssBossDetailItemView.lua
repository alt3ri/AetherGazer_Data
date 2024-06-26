slot0 = class("AbyssBossDetailItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.skillList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.monsterCollectId_ = AbyssUICfg[slot0.id_].enemy_id

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = MonsterCfg[slot0.monsterCollectId_]
	slot0.nameText_.text = GetMonsterName({
		slot0.monsterCollectId_
	})
	slot0.raceText_.text = GetTips("RACE_TYPE_" .. slot1.race)
	slot0.riskText_.text = NumberTools.IntToRomam(slot1.type + 1)
	slot0.portraitImage_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot0.monsterCollectId_)

	slot0:UpdateData()
	slot0:RefreshSkill()
end

function slot0.UpdateData(slot0)
	slot0.skillList_ = GetMonsterSkillDesList({
		slot0.monsterCollectId_
	})
end

function slot0.RefreshSkill(slot0)
	for slot4 = 1, 6 do
		if slot0.skillList_[slot4] then
			slot0:UpdateItem(slot4, slot0.skillList_[slot4])
		elseif slot0.itemList_[slot4] then
			slot0.itemList_[slot4]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.UpdateItem(slot0, slot1, slot2)
	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = AffixSelectBossInfoItem.New(Object.Instantiate(slot0.itemGo_, slot0.contentTrs_))
	end

	slot0.itemList_[slot1]:RefreshUI(slot2)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
