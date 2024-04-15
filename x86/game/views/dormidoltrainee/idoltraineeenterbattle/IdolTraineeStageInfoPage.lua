slot0 = class("IdolTraineeStageInfoPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.ememyItem = {}

	slot0:BindCfgUI(slot0.changeCharaGo_, slot0.ememyItem)
	slot0:AddUIListener()

	slot0.raceUIList_ = LuaList.New(handler(slot0, slot0.IndexRaceItem), slot0.advanceRace_, EnterBattleRaceListItem)
	slot0.styleUIList_ = LuaList.New(handler(slot0, slot0.IndexStyleItem), slot0.advanceStyle_, EnterBattleStyleListItem)
	slot0.stateController = slot0.controller:GetController("state")
	slot0.raceEmptyController = slot0.controller:GetController("raceEmpty")
	slot0.styleEmptyController = slot0.controller:GetController("styleEmpty")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.headbtn, nil, function ()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = uv0.curUserID_,
			friendType = uv0.friendType
		})
	end)
end

function slot0.IndexRaceItem(slot0, slot1, slot2)
	slot2:SetData(slot0.raceData_[slot1])
end

function slot0.IndexStyleItem(slot0, slot1, slot2)
	slot2:SetData(slot0.styleData_[slot1])
end

function slot0.IndexEnemyItem(slot0, slot1, slot2)
	slot2:SetData(slot0.enemyData[slot1])
end

function slot0.ShowPage(slot0, slot1)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.pvpBattle_ = slot0.params_.pvpBattle
	slot0.stageID_ = slot0.params_.stageID
	slot1 = nil

	if slot0.pvpBattle_ then
		slot0.stageID_ = IdolTraineeData:GetCurPVPStage()
		slot1 = IdolTraineePvpBattleCfg[slot0.stageID_]

		slot0.stateController:SetSelectedState("pvp")
	else
		slot0.stateController:SetSelectedState("pve")

		slot0.friendType = IdolTraineeConst.friendType.npc
		slot0.ememyItem.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(IdolTraineePveBattleCfg[slot0.stageID_].npc_id)
	end

	if slot1 then
		slot5 = slot1.stage_picture
		slot0.scene_.sprite = getSpriteWithoutAtlas(SpritePathCfg.IdolStageIcon.path .. slot5)
		slot0.bgmName_.text = IdolStageMusicCfg[slot1.bgm].music_name
		slot0.descText_.text = slot1.stage_desc
		slot0.raceData_ = slot1.race_id_list
		slot0.styleData_ = {}

		for slot5, slot6 in ipairs(slot1.peculiarity_rate) do
			if slot6 > 100 then
				table.insert(slot0.styleData_, slot5)
			end
		end

		slot0.raceUIList_:StartScroll(#slot0.raceData_)
		slot0.styleUIList_:StartScroll(#slot0.styleData_)
		slot0.raceEmptyController:SetSelectedState(#slot0.raceData_ == 0 and "true" or "false")
		slot0.styleEmptyController:SetSelectedState(#slot0.styleData_ == 0 and "true" or "false")
	end
end

function slot0.Dispose(slot0)
	if slot0.raceUIList_ then
		slot0.raceUIList_:Dispose()

		slot0.raceUIList_ = nil
	end

	if slot0.styleUIList_ then
		slot0.styleUIList_:Dispose()

		slot0.styleUIList_ = nil
	end

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
