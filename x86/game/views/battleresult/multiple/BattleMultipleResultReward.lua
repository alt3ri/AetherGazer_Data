slot0 = class("BattleMultipleResultReward", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObejct_ = slot1
	slot0.transform_ = slot0.gameObejct_.transform

	slot0:BindCfgUI(slot0.gameObejct_)

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshRenderer), slot0.uiList_, CommonItemView)
end

function slot0.Dispose(slot0)
	if slot0.rewardUIList_ then
		slot0.rewardUIList_:Dispose()

		slot0.rewardUIList_ = nil
	end

	uv0.super.Dispose(slot0)

	slot0.gameObejct_ = nil
end

function slot0.SetRewardList(slot0, slot1, slot2)
	if slot0.index_ ~= slot1 then
		slot0.index_ = slot1
		slot0.rewardList_ = slot2

		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot0.indexText_.text = slot0.index_
	slot1 = {}

	for slot5, slot6 in pairs(slot0.rewardList_) do
		table.insert(slot1, slot6)
	end

	slot1 = sortReward(mergeReward(formatRewardCfgList(slot1)))
	slot0.rewardList_ = slot1

	slot0.rewardUIList_:StartScroll(#slot1, 1)
end

function slot0.RefreshRenderer(slot0, slot1, slot2)
	slot3 = slot0.rewardList_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id
	slot4.number = slot3.num

	if ItemCfg[slot3.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[slot3.id].type then
		slot4.race = EquipCfg[slot3.id] and EquipCfg[slot3.id].race or 0
	end

	function slot4.clickFun(slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

return slot0
