slot0 = class("BossInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList_ = {}
	slot0.skillList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.id_ = slot0.params_.bossID

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	slot1 = MonsterCfg[slot0.id_]
	slot0.nameText_.text = GetMonsterName({
		slot0.id_
	})
	slot0.raceText_.text = GetTips("RACE_TYPE_" .. slot1.race)
	slot0.icon_.sprite = getSpriteWithoutAtlas(slot0.params_.spritePath)
	slot0.riskText_.text = NumberTools.IntToRomam(slot1.type + 1)

	slot0:UpdateData()
	slot0:RefreshSkill()
end

function slot0.UpdateData(slot0)
	slot0.skillList_ = GetMonsterSkillDesList({
		slot0.id_
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

	slot0.scrollviewSr_.normalizedPosition = Vector2(0, 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.UpdateItem(slot0, slot1, slot2)
	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = BossInfoItemView.New(Object.Instantiate(slot0.itemGo_, slot0.contentTrs_))
	end

	slot0.itemList_[slot1]:RefreshUI(slot2)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
