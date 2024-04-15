slot0 = class("RaceCollectRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskItems_ = {}
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.raceTaskIds_[slot1], slot0.raceId_)
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.raceId_ = slot2
	slot0.raceCfg_ = RaceEffectCfg[slot0.raceId_]
	slot0.raceTaskIds_ = CollectHeroRaceCfg.get_id_list_by_hero_race[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel.text = slot0.raceCfg_.name
	slot4 = "Atlas/CampItemAtlas"
	slot5 = slot0.raceCfg_.icon
	slot0.raceIcon_.sprite = getSprite(slot4, slot5)

	for slot4, slot5 in pairs(slot0.raceTaskIds_) do
		if slot0.taskItems_[slot4] == nil then
			slot0.taskItems_[slot4] = RaceCollectRewardConditionItemView.New(slot0.itemGo_, slot0.itemParent_)
		end

		slot0.taskItems_[slot4]:SetData(slot4, slot5, slot0.raceId_)
	end
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
	slot0.data_ = nil

	for slot4, slot5 in pairs(slot0.taskItems_) do
		slot5:Dispose()
	end

	slot0.taskItems_ = {}

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
