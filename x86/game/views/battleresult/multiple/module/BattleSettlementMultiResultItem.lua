slot0 = class("BattleSettlementMultiResultItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.TryInitScroll(slot0, slot1)
	slot0.parentScrollRect = slot1

	slot0:BuildEventDispatch()
end

function slot0.BuildEventDispatch(slot0)
	slot0.eventTrigger = slot0.rewardsListObj_.transform:GetComponent(typeof(EventTriggerListener))

	if not isNil(slot0.eventTrigger) then
		function slot0.eventTrigger.onBeginDrag(slot0, slot1)
			if not isNil(uv0.parentScrollRect) then
				uv0.parentScrollRect:OnBeginDrag(slot1)
			end
		end

		function slot0.eventTrigger.onEndDrag(slot0, slot1)
			if not isNil(uv0.parentScrollRect) then
				uv0.parentScrollRect:OnEndDrag(slot1)
			end
		end

		function slot0.eventTrigger.onDrag(slot0, slot1)
			if not isNil(uv0.parentScrollRect) then
				uv0.parentScrollRect:OnDrag(slot1)
			end
		end
	end
end

function slot0.ClearRef(slot0)
	if not isNil(slot0.eventTrigger) then
		slot0.eventTrigger:RemoveAllListeners()
	end

	slot0.eventTrigger = nil
	slot0.parentScrollRect = nil
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.RenderItem), slot0.rewardsListObj_, CommonItemView)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1, slot2)
	if slot0.index_ ~= slot1 then
		slot0.index_ = slot1
		slot0.rewardList_ = slot2 or {}

		slot0:Render()
	end
end

function slot0.Render(slot0)
	slot0.indexTxt_.text = slot0.index_
	slot1 = {}

	for slot5, slot6 in pairs(slot0.rewardList_) do
		table.insert(slot1, slot6)
	end

	slot1 = sortReward(mergeReward(formatRewardCfgList(slot1)))
	slot0.rewardList_ = slot1

	slot0.scrollHelper:StartScroll(#slot1, 1)
end

function slot0.RenderItem(slot0, slot1, slot2)
	slot3 = slot0.rewardList_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id
	slot4.number = slot3.num

	if ItemCfg[slot3.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[slot3.id].type then
		slot4.race = EquipCfg[slot3.id] and EquipCfg[slot3.id].race or 0
	end

	function slot4.clickFun(slot0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()

	slot0.scrollHelper = nil

	slot0:ClearRef()
	uv0.super.Dispose(slot0)
end

return slot0
