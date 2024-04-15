slot0 = class("SequentialBattleFactoryTeamHero", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.heroIndex_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activityID_ = slot1
	slot0.stageIndex_ = slot2
	slot0.heroID_ = slot3
	slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, slot0.activityID_, slot0.stageIndex_, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[slot0.activityID_].stage_id[slot0.stageIndex_],
		activityID = slot0.activityID_
	})

	slot0:RefreshHero()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.teamButton_, nil, function ()
		SequentialBattleData:CacheChapterData(uv0.activityID_)
		uv0:Go("/sectionSelectHeroSequentialBattle", {
			section = SequentialBattleChapterCfg[uv0.activityID_].stage_id[uv0.stageIndex_],
			sectionType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
			activityID = uv0.activityID_,
			reserveParams = uv0.reserveParams_
		})
	end)
end

function slot0.RefreshHero(slot0, slot1)
	if slot0.heroID_ ~= 0 then
		slot0.icon_.sprite = HeroTools.GetHeadSprite(slot0.heroID_)

		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
