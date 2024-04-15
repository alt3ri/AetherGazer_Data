slot0 = class("ActivityWorldBossSkillView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/WorldBoss/EDream_WorldBossPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.bossID
	slot0.bossID_ = slot1
	slot0.portraitImage_.sprite = getSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", slot1))
	slot0.nameText_.text = GetMonsterName({
		slot0.bossID_
	})
	slot0.tagText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[slot1].race)
	slot3 = GetMonsterSkillDesList({
		slot0.bossID_
	})
	slot4 = 1

	for slot8 = 1, 6 do
		if slot3[slot8] then
			if not slot0.skillList_[slot4] then
				slot0.skillList_[slot4] = BattleBossChallengeSkillItem.New(slot0.skillItem_, slot0.skillParent_)
			end

			slot0.skillList_[slot4]:RefreshUI(slot3[slot8])

			slot4 = slot4 + 1
		end
	end

	for slot8 = slot4, #slot0.skillList_ do
		slot0.skillList_[slot8]:Hide()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.skillList_) do
		slot5:Dispose()
	end

	slot0.skillList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
