slot0 = class("ActivityAttributeArenaItem", ReduxView)

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

	slot0.teamList = LuaList.New(handler(slot0, slot0.IndexTeamItem), slot0.m_teamList, ActivityAttributeArenaHeroItem)
	slot0.rankTeamList = LuaList.New(handler(slot0, slot0.IndexRankTeamItem), slot0.m_rankList, ActivityAttributeArenaHeroItem)
	slot0.scoreController = ControllerUtil.GetController(slot0.transform_, "score")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rankController = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_clickBtn, function ()
		if uv0.score > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_ATTRIBUTE_ARENE_RESET"),
				OkCallback = function ()
					ActivityAttributeArenaAction.QueryResetScore(uv0.activity_id, uv0.attribute_arena_id)
				end
			})
		else
			uv0:Go("/sectionSelectHero", {
				section = ActivityAttributeArenaCfg[uv0.attribute_arena_id].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA,
				activityID = uv0.activity_id,
				arena_index = uv0.index,
				attribute_arena_id = uv0.attribute_arena_id,
				reserveParams = uv0.reserveParams_
			})
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_rankBtn, function ()
		JumpTools.OpenPageByJump("/activityAttributeArenaRank", {
			rank_activity_id = uv0.rank_activity_id,
			index = uv0.index
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activity_id = slot2
	slot0.rank_activity_id = slot3
	slot0.index = slot1.index
	slot0.attribute_arena_id = slot1.id
	slot0.score = slot1.score

	slot0:GetHeroTeam()
	slot0:RefreshUI()
end

function slot0.GetHeroTeam(slot0)
	slot7 = slot0.activity_id
	slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA, slot0.attribute_arena_id, nil, {
		stageType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA,
		stageID = ActivityAttributeArenaCfg[slot0.attribute_arena_id].stage_id,
		attribute_arena_id = slot0.attribute_arena_id,
		activityID = slot7
	})
	slot0.heroList_, slot0.trialList_ = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA):GetArenaHeroList(slot0.attribute_arena_id)
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.heroList_) do
		if slot8 == 0 then
			break
		end

		slot3 = slot3 + 1
	end

	slot0.heroCount_ = slot3
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityAttributeArenaCfg[slot0.attribute_arena_id]
	slot0.m_monsterIcon.sprite = getSpriteWithoutAtlas("TextureConfig/ArenaUI/Boss/" .. slot1.stage_id)
	slot0.m_attributeIcon.sprite = HeroTools.GetSkillAttributeIcon(slot1.attribute)

	if slot0.score == 0 then
		slot0.scoreController:SetSelectedIndex(0)
	else
		slot0.scoreController:SetSelectedIndex(1)

		slot0.m_score.text = slot0.score

		slot0.teamList:StartScroll(slot0.heroCount_)
	end

	if RankData:GetActivityRank(slot0.rank_activity_id, slot0.index) and #slot2.rankList > 0 then
		slot0.rankController:SetSelectedIndex(1)

		slot3 = slot2.rankList[1]
		slot0.m_rankIcon.sprite = ItemTools.getItemSprite(slot3.portrait)
		slot0.m_rankFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot3.frame)
		slot0.m_rankScore.text = slot3.score
		slot0.m_rankLab.text = slot3.rank
		slot0.rankHeroList = slot3:GetSingleSelectHeroList()

		slot0.rankTeamList:StartScroll(#slot0.rankHeroList)
	else
		slot0.rankController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	slot0.teamList:Dispose()
	slot0.rankTeamList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexTeamItem(slot0, slot1, slot2)
	if slot0.trialList_[slot1] ~= 0 then
		slot2:SetData(HeroStandardSystemCfg[slot0.trialList_[slot1]].skin_id)
	else
		slot2:SetData(HeroTools.HeroUsingSkinInfo(slot0.heroList_[slot1]).id)
	end
end

function slot0.IndexRankTeamItem(slot0, slot1, slot2)
	if slot0.rankHeroList[slot1].skin_id == 0 then
		slot4 = slot3.hero_id
	end

	slot2:SetData(slot4)
end

return slot0
