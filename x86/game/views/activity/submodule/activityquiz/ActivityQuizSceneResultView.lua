slot0 = class("ActivityQuizSceneResultView", ReduxView)
slot1 = import("game.quiz.QuizFunction")

function slot0.UIName(slot0)
	return ActivityQuizTools.GetResultUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.snapView_ = HeroDisplaySnapView.New(slot0.goSnapPanel_)
	slot0.shareView_ = QuizSceneShareView.New(slot0.goSharePanel_)

	slot0.shareView_:ExitViewCallBack(function ()
		uv0:SetShareItem(true)
	end)

	slot0.rankScrollHelper_ = LuaList.New(handler(slot0, slot0.RankIndexItem), slot0.rankListGo_, ActivityQuizRankItem)
end

function slot0.RankIndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.rankList_[slot1], slot0.rankIndexList_[slot1])
	slot2:SetMine(slot0.rankList_[slot1] == slot0.userID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		uv0:SetShareItem(false)
		uv0.snapView_:Snap(function ()
			uv0.shareView_:OnSnape(true)
		end)
	end)
	slot0:AddBtnListener(slot0.quitBtn_, nil, function ()
		QuitQuizScene()
	end)
	slot0:AddBtnListener(slot0.oneMoreBtn_, nil, function ()
		ActivityQuizAction.StartMarch()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0.shareView_:OnEnter()

	slot0.userID_ = tostring(PlayerData:GetPlayerInfo().userID)

	slot0:RefreshRank()
	slot0:RefreshHero()
end

function slot0.RefreshRank(slot0)
	slot0.rankList_ = uv0:GetPlayerList()

	slot0:SortRank()

	slot0.numIndex_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), slot0.rankIndexList_[table.indexof(slot0.rankList_, slot0.userID_)])
	slot0.rankScore_.text = uv0:GetRankData(slot0.userID_).score
end

function slot0.SortRank(slot0)
	table.sort(slot0.rankList_, function (slot0, slot1)
		return uv0:GetRankData(slot1).score < uv0:GetRankData(slot0).score
	end)

	slot1 = 1
	slot0.rankIndexList_ = {}

	for slot6, slot7 in ipairs(slot0.rankList_) do
		if uv0:GetRankData(slot7).score < uv0:GetRankData(slot0.rankList_[1]).score then
			slot2 = slot8.score
			slot1 = slot6
		end

		table.insert(slot0.rankIndexList_, slot1)
	end

	slot0.rankScrollHelper_:StartScroll(#slot0.rankList_)
end

function slot0.RefreshHero(slot0)
	slot1 = {}
	slot2 = {}

	for slot6 = 1, 3 do
		if slot0.rankList_[slot6] then
			table.insert(slot1, slot0.rankList_[slot6])
			table.insert(slot2, slot0.rankIndexList_[slot6])
		end
	end

	uv0:ShowModels(slot1, slot2)
end

function slot0.SetShareItem(slot0, slot1)
	if slot1 then
		slot0:SetDefaultBar()
		SetActive(slot0.shareBtn_.gameObject, true)
		SetActive(slot0.quitBtn_.gameObject, true)
		SetActive(slot0.oneMoreBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(slot0.shareBtn_.gameObject, false)
		SetActive(slot0.quitBtn_.gameObject, false)
		SetActive(slot0.oneMoreBtn_.gameObject, false)
	end
end

function slot0.SetDefaultBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(slot0.activityID_))
	manager.windowBar:RegistBackCallBack(function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_QUIZ_QUIT"),
			OkCallback = function ()
				ActivityQuizAction.ExitRoom()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.OnActivityQuizStartMarch(slot0)
	ActivityQuizTools.SetCurActivityID(slot0.activityID_)
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = slot0.activityID_
	})
end

function slot0.OnTop(slot0)
	slot0:SetShareItem(true)
end

function slot0.OnExit(slot0)
	slot0.snapView_:OnExit()
	slot0.shareView_:OnExit()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.snapView_:Dispose()

	slot0.snapView_ = nil

	slot0.shareView_:Dispose()

	slot0.shareView_ = nil

	slot0.rankScrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
