slot0 = class("HeroTransitionSimpleInfoView", ReduxView)

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

	slot0.emptyController_ = slot0.controller_:GetController("empty")
	slot0.transitionItemList_ = {}
end

function slot0.AddUIListener(slot0)
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.heroID_ = slot1.id
end

function slot0.UpdateView(slot0)
	slot0.transitionList_ = slot0:RebuildTransitionSkills()

	slot0.emptyController_:SetSelectedState(#slot0.transitionList_ == 0 and "true" or "false")

	for slot4, slot5 in ipairs(slot0.transitionItemList_) do
		SetActive(slot5.gameObject_, false)
	end

	slot1 = 1

	for slot5, slot6 in ipairs(slot0.transitionList_) do
		if not slot0.transitionItemList_[slot1] then
			slot8 = HeroTransitionItem.New(Object.Instantiate(slot0.jumpItemGo_, slot0.jumpItemListTrs_, false))

			slot8:SetData(slot6)
			table.insert(slot0.transitionItemList_, slot8)
		else
			slot0.transitionItemList_[slot1]:SetData(slot6)
		end

		SetActive(slot0.transitionItemList_[slot1].gameObject_, true)

		slot1 = slot1 + 1
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1

	slot0:RegistEventListener(HERO_TRANSITION_CHANGE, handler(slot0, slot0.OnHeroModify))
end

function slot0.OnExit(slot0)
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroID_ then
		slot0.heroInfo_ = slot0.heroViewProxy_:GetHeroData(slot0.heroID_)

		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.transitionItemList_) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

function slot0.RebuildTransitionSkills(slot0)
	slot3 = HeroTools.GetHeroEquipSkillAddLevel(slot0.heroViewProxy_:GetHeroData(slot0.heroID_))
	slot4 = {}

	for slot8, slot9 in ipairs(slot0.heroViewProxy_:GetHeroTransitionInfoList(slot0.heroID_)) do
		if not slot0:GetSlotLockStatus(slot9.slot_id) then
			for slot13, slot14 in ipairs(slot9.skill_list) do
				slot4[slot15] = (slot4[slot14.skill_id] or 0) + slot14.skill_level
			end
		end
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		table.insert(slot5, {
			skillId = slot9,
			level = slot10 + slot3
		})
	end

	table.sort(slot5, function (slot0, slot1)
		if slot0.skillId == slot1.skillId then
			return false
		end

		return slot0.skillId < slot1.skillId
	end)

	return slot5
end

function slot0.GetSlotLockStatus(slot0, slot1)
	slot3 = 0

	if slot0.heroViewProxy_:GetEquipDataList(slot0.heroID_)[slot1] and slot2[slot1].prefab_id and slot2[slot1].prefab_id ~= 0 then
		slot3 = slot2[slot1]:GetLevel()
	end

	return slot3 < GameSetting.exclusive_open_need.value[1]
end

return slot0
