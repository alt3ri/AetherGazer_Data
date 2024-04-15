slot0 = class("BossStarExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Boss/BossStarExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshReward)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, BossStarExchangeItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.taskList_[slot1]

	slot2:SetData(slot0.cfg_.reward[slot3], slot0.curStarCnt_, slot3, slot1 == #slot0.taskList_)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItem(slot0)
	slot0.cfg_ = BattleBossChallengeNormalData:GetBossChallengeCfg()
	slot0.curStarCnt_ = StageTools.CalcBossChallengeStar()
	slot2 = {}

	for slot7 = 1, #slot0.cfg_.reward do
		table.insert(slot2, slot7)

		if slot0.cfg_.reward[slot7][1] <= slot0.curStarCnt_ and not table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), slot8) and 0 == 0 then
			slot3 = slot7
		end
	end

	slot0.taskList_ = slot2

	slot0.scrollHelper_:StartScroll(#slot0.taskList_, slot3)
end

function slot0.RefreshReward(slot0)
	slot0.scrollHelper_:Refresh()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshHandler_ = nil

	slot0.scrollHelper_:Dispose()

	slot0.itemList_ = nil
end

return slot0
