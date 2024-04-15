slot1 = class("GameContext", import("library.router.VueRouter"))

function slot1.Ctor(slot0, ...)
	uv0.super.Ctor(slot0, ...)

	slot0.waitLoadUrlList_ = {}
end

function slot1.Go(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0.super.Open(slot0, slot1, {
		params = slot2,
		isReplace = slot3,
		isAsync = slot4,
		isBack = slot5,
		extraContext = extraContext
	})
end

function slot1.OnLoadAndUnloadAssert(slot0)
	if slot0.preLoadFunc_ then
		slot0.preLoadFunc_(slot0.routes_, slot0.oldRoutes_, slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_), slot0.curArgs_.isAsync)
	end

	uv0.super.OnLoadAndUnloadAssert(slot0)
end

function slot1.OnPlayExitAnimationAndCommonAnimation(slot0)
	slot0:PlayExitAnimation(true)
end

function slot1.OnPlayExitAnimation(slot0)
	slot0:PlayExitAnimation(false)
end

function slot1.PlayExitAnimation(slot0, slot1)
	slot3 = {}

	for slot7 = #slot0.oldRoutes_, slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_) + 1, -1 do
		if slot0.recordMap_[slot0.oldRoutes_[slot7]] then
			slot9, slot10 = slot8:GetPlayBackwardsAnimator()

			if slot10 then
				slot10()
			end

			for slot14, slot15 in ipairs(slot9) do
				table.insert(slot3, slot15)

				if slot15[3] == true then
					slot15[1]:Play(slot15[2], 0, 1)
				else
					slot15[1]:Play(slot15[2], 0, 0)
				end
			end
		end
	end

	slot4 = false
	slot5 = false

	if #slot3 > 0 then
		slot6 = nil

		FrameTimer.New(function ()
			for slot3, slot4 in ipairs(uv0) do
				if slot4[1] == nil then
					uv1 = true

					uv2:FinishExitAnimation(uv3, uv1)

					return
				end

				if slot4[3] == true then
					if slot4[1]:GetCurrentAnimatorStateInfo(0).normalizedTime > 0 then
						return
					end
				elseif slot5.normalizedTime < 1 then
					return
				end

				uv1 = true

				uv2:FinishExitAnimation(uv3, uv1, uv4)
				uv5:Stop()
			end
		end, 1, -1):Start()
	else
		slot5 = true
	end

	manager.ui:UIEventEnabledByUI(false, true)

	if slot1 then
		slot0.preExitAction_(function ()
			uv0 = true

			uv1:FinishExitAnimation(uv0, uv2, uv3)
		end, slot0.curArgs_.isAsync, slot0.curArgs_.isRootUrl)
	else
		slot0:FinishExitAnimation(true, slot5, slot1)
	end
end

function slot1.FinishExitAnimation(slot0, slot1, slot2, slot3)
	if slot1 and slot2 then
		manager.ui:UIEventEnabledByUI(true, false)

		if slot3 then
			uv0.super.OnPlayExitAnimationAndCommonAnimation(slot0)
		else
			uv0.super.OnPlayExitAnimation(slot0)
		end
	end
end

function slot1.OnPlayEnterAnimation(slot0)
	manager.ui:UIEventEnabledByUI(false, true)
	slot0.afterStartAction_(function ()
		uv0.super.OnPlayEnterAnimation(uv1)
		manager.ui:UIEventEnabledByUI(true, false)
	end, slot0.curArgs_.isAsync, slot0.curArgs_.isRootUrl)
end

function slot1.OnEnterNewRoutes(slot0)
	if ViewAnimationManager.isReturnFromBattle == true or slot0.curArgs_.isBack then
		ViewAnimationManager.SetIsReturnFromBattle(slot0.routes_[#slot0.routes_], true)
	end

	uv0.super.OnEnterNewRoutes(slot0)
end

function slot1.OnOpenOver(slot0)
	uv0.super.OnOpenOver(slot0)

	if #slot0.cmdEnqueue_ <= 0 then
		GlobalCall.call("AfterGo")
	end
end

function slot1.ExitRoute(slot0, slot1)
	if slot0.recordMap_[slot1] == nil then
		return
	end

	OperationRecorder.RecordStayView(slot2.class.__cname, slot2:GetStayTime())
	uv0.super.ExitRoute(slot0, slot1)
end

function slot1.NeedBackNextUrl(slot0, slot1, slot2)
	if ViewConst.NEED_CHECK_ACTIVITY[slot1[1]] then
		return ActivityTools.GetActivityStatus(slot2.params[slot3]) ~= 1
	else
		return false
	end
end

function slot1.IsReplaceUrl(slot0, slot1)
	if #slot0.history_ > 0 and ViewTools.GetIsSkipRecord(slot0:GetRoutesFromUrl(slot0.history_[#slot0.history_].url)) then
		return true
	end

	return false
end

function slot1.SetActions(slot0, slot1, slot2)
	slot0.preExitAction_ = slot1 or defaultAction
	slot0.afterStartAction_ = slot2 or defaultAction
end

function slot2(slot0)
	if slot0 then
		slot0()
	end
end

function slot1.PlayPreExitTransition(slot0, slot1, slot2, slot3)
	slot0.preExitAction_(slot1, slot2, slot3)
end

function slot1.PlayAfterStartTransition(slot0, slot1, slot2)
	slot0.afterStartAction_(slot1, slot2)
end

function slot1.RegistPreLoadFunc(slot0, slot1)
	slot0.preLoadFunc_ = slot1
end

function slot1.ClearHistory(slot0)
	slot0:SetSystemLayer("home")

	slot0.history_ = {
		{
			url = "/home",
			args = {}
		}
	}
end

function slot1.GetLastHistoryAndParams(slot0)
	return slot0.history_[#slot0.history_].url, slot0.history_[#slot0.history_].args.params
end

function slot1.ClearHistoryByName(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.history_) do
		if slot7.url and string.find(slot7.url, slot1) then
			slot2 = slot6
		end
	end

	if slot2 > 0 then
		table.remove(slot0.history_, slot2)
	end
end

function slot1.GetUrl(slot0)
	return slot0.url_
end

function slot1.GetAllOpenRoute(slot0)
	if slot0.routes_ == nil then
		return {}
	end

	for slot5, slot6 in ipairs(slot0.routes_) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot1.GetAllOpenPage(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.routes_) do
		table.insert(slot1, slot0.recordMap_[slot6])
	end

	return slot1
end

function slot1.GetLastOpenPage(slot0)
	if slot0.routes_ == nil then
		return ""
	end

	return slot0.routes_[#slot0.routes_] or ""
end

function slot1.IsOpenRoute(slot0, slot1)
	if slot0.routes_ == nil then
		return nil
	end

	for slot5, slot6 in ipairs(slot0.routes_) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return nil
end

function slot1.SetUrlAndParams(slot0, slot1, slot2)
	if slot0.curLayer_ == nil then
		table.insert(slot0.waitLoadUrlList_, {
			url = slot1,
			params = slot2
		})
	else
		slot0:UpdateUrlHistory(slot1, {
			params = slot2
		})
	end
end

function slot1.GetOpenPageHandler(slot0, slot1)
	if slot0:IsOpenRoute(slot1) and slot2 > 0 then
		return slot0.recordMap_[slot0.routes_[slot2]]
	end
end

function slot1.OverrideUrl(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil
	slot5 = (whereami ~= slot4 or slot0.history_) and (slot0.cacheHistory_[slot4] or {})
	slot6 = slot0:GetIndexFromHistory(slot5, slot2)

	if slot0:GetIndexFromHistory(slot5, slot1) > 0 then
		slot5[slot7] = {
			url = slot2,
			args = {
				params = slot3
			}
		}
	end

	if slot6 <= 0 or slot7 <= 0 then
		return
	elseif slot7 < slot6 then
		table.remove(slot5, slot6)
	elseif slot6 < slot7 then
		table.remove(slot5, slot7)
	end
end

function slot1.IsBack(slot0, slot1)
	return slot0:GetIndexFromHistory(slot0.history_, slot1)
end

function slot1.SetSystemLayer(slot0, slot1)
	if whereami ~= slot1 then
		slot0:SaveCacheHistory(slot1)
	end

	for slot6, slot7 in ipairs(clone(slot0.waitLoadUrlList_)) do
		slot0:SetUrlAndParams(slot7.url, slot7.params)
	end

	slot0.waitLoadUrlList_ = {}
	whereami = slot1
end

return slot1
