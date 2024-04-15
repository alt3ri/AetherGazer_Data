slot0 = class("BattleSettlemenMultiResultModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot0:InstView(slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.InstView(slot0, slot1)
	return Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleMultipleResultContent"), slot1)
end

function slot0.BuildContext(slot0)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.RenderItem), slot0.rewardsListObj_, BattleSettlementMultiResultItem)
	slot0.scrollRect = slot0.rewardsListObj_:GetComponent(typeof(ScrollRectEx))
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0.stageData = slot1.stageData
	slot0.rewardList = slot1.rewardList
	slot0.multiple = slot1.rewardTimes

	slot0.scrollHelper:StartScroll(slot0.multiple or 0)
end

function slot0.RenderItem(slot0, slot1, slot2)
	slot2:TryInitScroll(slot0.scrollRect)
	slot2:RenderView(slot1, clone(slot0.rewardList[slot1]))
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()

	slot0.scrollRect = nil

	uv0.super.Dispose(slot0)
end

return slot0
