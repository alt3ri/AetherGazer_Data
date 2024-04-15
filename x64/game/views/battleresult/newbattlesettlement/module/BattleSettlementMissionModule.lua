slot0 = class("BattleSettlementMissionModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot0:InstView(slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleResultNormalContent"), slot1)
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		slot0.targetController1_:GetController("clear"),
		slot0.targetController2_:GetController("clear"),
		slot0.targetController3_:GetController("clear")
	}
	slot0.rewardItemList = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RenderAwardItem), slot0.rewardList_, CommonItemView)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1, slot2, slot3)
	slot4 = slot3
	slot5 = {}

	for slot9 = 1, 3 do
		if slot4 ~= nil and slot4[slot9] ~= nil then
			slot10 = ThreeStarConditionCfg[slot4[slot9].id]
			slot11 = nil

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot1 then
				slot11 = BattleStageData:GetStageData()[slot2]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot1 then
				slot11 = BattleBossChallengeNormalData:GetStarList(slot2)
			end

			slot12 = false

			if slot11 and slot11.stars and slot11.stars[slot9] == 1 then
				slot12 = true
			end

			slot0[string.format("targetText%d_", slot9)].text = GetI18NText(BattleInstance.GetStarMissionText(slot4[slot9].id, slot4[slot9].xData, slot4[slot9].yData))

			if slot4[slot9].isComplete or slot12 then
				slot0.controller[slot9]:SetSelectedState("state1")

				slot0[string.format("targetText%d_", slot9)].color = Color.New(0.9102, 0.9351, 0.9408, 1)
			else
				slot0.controller[slot9]:SetSelectedState("state0")

				slot0[string.format("targetText%d_", slot9)].color = Color.New(0.6768, 0.6853, 0.6882, 1)
			end

			slot5[slot9] = slot13 and 1 or 0
		else
			slot0.controller[slot9]:SetSelectedState("no info")
		end
	end

	BattleInstance.RecordThreeStar(slot0.stageType, slot0.stageId, slot5)
end

function slot0.RenderRewards(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, slot7)
		end

		slot2 = sortReward(mergeReward(formatRewardCfgList(slot2)))
	end

	slot0.rewardItemList = slot2

	slot0.scrollHelper_:StartScroll(#slot2, 1)
end

function slot0.RenderAwardItem(slot0, slot1, slot2)
	if ItemCfg[slot0.rewardItemList[slot1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[slot3.id].type then
		slot3.race = EquipCfg[slot3.id] and EquipCfg[slot3.id].race or 0
	end

	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id
	slot4.number = slot3.num
	slot4.race = slot3.race

	function slot4.clickFun(slot0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
