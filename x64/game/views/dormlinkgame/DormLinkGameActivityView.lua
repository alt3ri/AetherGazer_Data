slot0 = class("DormLinkGameActivityView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGStagePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.activityScroll = LuaList.New(handler(slot0, slot0.indexActivityItemList), slot0.uilistGo_, DormLinkGameActivityItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()
	slot0:RefreshView()

	slot0.canGetAward = true
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_LINK_REFRESH_LEVEL_AWARD, function (slot0)
		uv0.canGetAward = true

		uv0:RefreshView()
		DormLinkGameData:CheckUnReciveLevelReward()
	end)
end

function slot0.indexActivityItemList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.activityList[slot1])
	slot2:GetLevelAward(function (slot0)
		if uv0.canGetAward then
			uv0.canGetAward = false

			DormLinkGameAction:GetLevelAward(slot0)
		end
	end)
end

function slot0.RefreshView(slot0)
	slot0.activityList = {}

	for slot5, slot6 in ipairs(ActivityLinkGameRewardCfg.all) do
		table.insert(slot0.activityList, slot6)
	end

	CommonTools.UniversalSortEx(slot0.activityList, {
		ascend = true,
		map = function (slot0)
			if DormLinkGameData:CheckLevelRewardState(slot0) == DormLinkGameConst.RewardItemState.unComplete then
				return 2
			elseif slot1 == DormLinkGameConst.RewardItemState.complete then
				return 1
			elseif slot1 == DormLinkGameConst.RewardItemState.received then
				return 3
			end
		end
	}, {
		ascend = true,
		map = function (slot0)
			return slot0
		end
	})
	slot0.activityScroll:StartScroll(#slot0.activityList)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.activityScroll then
		slot0.activityScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
