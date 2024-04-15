slot0 = class("SequentialBattleFactoryTeamItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroItemList_ = {}

	for slot5 = 1, 3 do
		slot0.heroItemList_[slot5] = SequentialBattleFactoryTeamHero.New(slot0[string.format("heroGo%s_", slot5)], slot5)
	end

	slot0.buffItemList_ = {}
	slot0.bossController_ = ControllerUtil.GetController(slot0.transform_, "boss")
	slot0.buffController_ = ControllerUtil.GetController(slot0.transform_, "affix")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.stageIndex_ = slot2
	slot0.stageID_ = SequentialBattleChapterCfg[slot0.activityID_].stage_id[slot0.stageIndex_]

	SequentialBattleTools.CheckHeroTeam(slot1, slot2)

	slot8 = slot0.activityID_

	for slot8, slot9 in ipairs(slot0.heroItemList_) do
		slot9:SetData(slot1, slot2, ReserveTools.GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, slot0.activityID_, slot0.stageIndex_, {
			stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
			stageID = slot0.stageID_,
			activityID = slot8
		}))[slot8])
	end

	slot0.titleText_.text = GetTips(string.format("TEAM_%s", slot2))

	if SequentialBattleChapterCfg[slot1].boss_list[slot2] ~= 0 then
		slot0.bossController_:SetSelectedState("true")

		for slot10, slot11 in pairs(slot5.boss_list[slot2]) do
			slot6 = (nil ~= nil or tostring(slot11)) and tostring(slot11) .. tostring(slot11)
		end

		slot0.portraitImage_.sprite = getSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/icon/%s", slot6))
	else
		slot0.bossController_:SetSelectedState("false")
	end

	slot0:RefreshBuffItem()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil

	for slot4, slot5 in ipairs(slot0.buffItemList_) do
		slot5:Dispose()
	end

	slot0.buffItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
		slot0 = 0

		if SequentialBattleChapterCfg[uv0.activityID_].boss_list[uv0.stageIndex_] ~= 0 then
			for slot5, slot6 in ipairs(slot1) do
				if slot6 ~= 0 then
					slot0 = slot0 + 1
				end

				if slot5 == uv0.stageIndex_ then
					break
				end
			end
		else
			slot0 = 1
		end

		JumpTools.OpenPageByJump("sequentialBattleBossInfo", {
			activityID = uv0.activityID_,
			bossIndex = slot0
		})
	end)
	slot0:AddBtnListener(slot0.buffBtn_, nil, function ()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			activityID = uv0.activityID_,
			stageID = SequentialBattleChapterCfg[uv0.activityID_].stage_id[uv0.stageIndex_]
		})
	end)
end

function slot0.RefreshBuffItem(slot0)
	if #SequentialBattleTools.GetEnabledBuff(slot0.activityID_, slot0.stageIndex_) <= 0 then
		slot0.buffController_:SetSelectedState("off")
	else
		slot0.buffController_:SetSelectedState("on")

		for slot5, slot6 in ipairs(slot1) do
			slot0.buffItemList_[slot5] = slot0.buffItemList_[slot5] or SequentialBattleFactoryTeamBuff.New(slot0.buffItem_, slot0.buffParent_)

			slot0.buffItemList_[slot5]:SetData(SequentialBattleBuffCfg[slot6].affix_id)
		end

		for slot5 = #slot1 + 1, #slot0.buffItemList_ do
			slot0.buffItemList_[slot5]:Show(false)
		end
	end
end

return slot0
