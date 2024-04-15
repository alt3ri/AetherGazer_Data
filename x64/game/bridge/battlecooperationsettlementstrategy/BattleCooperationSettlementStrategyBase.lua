slot0 = class("BattleCooperationSettlementStrategyBase")

function slot0.GotoSettlement(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}

	if slot1:GetThreeStar() and type(slot7) == "table" then
		for slot11 = 1, #slot7 do
			slot12 = slot7[slot11]

			if slot3 and slot3[slot11] then
				table.insert(slot6, {
					id = slot12[1],
					total = slot3[slot11].need_progress,
					current = slot3[slot11].now_progress,
					xData = slot12[2],
					yData = slot12[3],
					isComplete = slot3[slot11].is_achieve == 1 and true or false
				})
			end
		end
	end

	if isSuccess(slot2) then
		slot8, slot9 = slot1:GetHeroTeam()

		for slot16 = 1, #slot8 do
			if slot1:GetSystemHeroTeam()[slot16] == nil and slot8[slot16] ~= 0 and (slot9[slot16] == nil or slot9[slot16] == 0) then
				HeroData:HeroClearTimesModify(slot8[slot16], GameSetting.mastery_gain.value[1])

				if HeroTools.GetHeroOntologyID(slot8[slot16]) then
					ArchiveData:AddExp(slot17, GameSetting.hero_love_exp_gain.value[1] * slot1:GetMultiple())
				end
			end
		end

		HeroAction.UpdateHeartRedPoint()
		HeroAction.UpdateStoryRedPoint()
		HeroAction.UpdateSuperStoryRedPoint()
	end

	slot0:OnGotoSettlement({
		num = slot2,
		starList = slot3,
		battleResult = slot4,
		stageData = slot1,
		starMissionData = slot6,
		isHalfWay_ = slot5
	})
end

function slot0.OnGotoSettlement(slot0, slot1)
end

function slot0.GotoCooperationResult(slot0, slot1, slot2, slot3, slot4)
	if isSuccess(slot1) then
		slot5 = slot0:GetResultReward()

		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end

		return
	end

	slot0:GotoBattleFaild(slot1, slot2)
end

function slot0.GotoBattleFaild(slot0, slot1, slot2)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleCooperationFailed", {
			stageData = uv0
		})
		EndBattleLogic(uv1)
	end
end

function slot0.GetResultReward(slot0)
	slot1 = {}
	slot5 = BattleFieldData
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.GetBattleResultData(slot7).dropList) do
		for slot11, slot12 in ipairs(slot7.rewardItems) do
			print(string.format("服务端发下第%s次物品数据id:", slot7.battleTimes), slot12.id, "num:", slot12.num)
			table.insert(slot2[slot7.battleTimes], {
				slot12.id,
				slot12.num
			})
			table.insert(slot1, {
				slot12.id,
				slot12.num
			})
		end
	end

	return slot1, {
		[slot7.battleTimes] = {}
	}
end

return slot0
