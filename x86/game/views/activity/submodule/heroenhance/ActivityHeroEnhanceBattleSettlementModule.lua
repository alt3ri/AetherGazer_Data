slot0 = class("ActivityHeroEnhanceBattleSettlementModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot0:InstView(slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load("Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceBattleResultContent"), slot1)
end

function slot0.BuildContext(slot0)
	slot0.rewardItemList = {}
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexAwardItem), slot0.rewardList_, CommonItemView)
	slot0.talentList_ = LuaList.New(handler(slot0, slot0.IndexTalentItem), slot0.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0.talentIdList_ = slot1.stageData:GetTalentIdList()

	slot0.talentList_:StartScroll(4)
	slot0:RenderRewards(slot1.rewardList)
end

function slot0.RenderRewards(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in pairs(slot1[1]) do
			table.insert(slot2, slot7)
		end

		slot2 = sortReward(mergeReward(formatRewardCfgList(slot2)))
	end

	slot0.rewardItemList = slot2

	slot0.rewardList_:StartScroll(#slot2, 1)
end

function slot0.IndexAwardItem(slot0, slot1, slot2)
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

function slot0.IndexTalentItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityId_, slot0.talentIdList_[slot1])
	slot2:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.talentList_:Dispose()
	slot0.rewardList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
