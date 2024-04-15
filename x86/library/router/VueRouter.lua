slot0 = class("VueRouter")
slot1 = import(".fsm.FiniteStateMechine")
slot2 = import(".fsm.FiniteStateMechineState")
slot3 = import(".linkMethod.LinkMethod")
slot4 = {
	{
		to = "working",
		name = "work",
		from = "wait"
	},
	{
		to = "wait",
		name = "wait",
		from = "working"
	}
}
slot0.JUMP_TYPE = {
	GO = "go",
	BACK = "back"
}

function slot0.Ctor(slot0, slot1, slot2)
	slot0.cmdEnqueue_ = {}
	slot0.routesCfg_ = {}

	for slot6, slot7 in pairs(slot1) do
		slot0.routesCfg_[slot7.name] = slot7
	end

	slot0.routes_ = {}
	slot0.oldRoutes_ = {}
	slot0.curLayer_ = "login"
	slot0.history_ = {}
	slot0.cacheHistory_ = {}
	slot0.saveHistoryLaylerList_ = slot2 or {}
	slot0.recordMap_ = {}
	slot0.fsm_ = uv0.New()

	for slot6, slot7 in pairs(uv1) do
		slot0.fsm_:AddState(uv2.New(slot7))
	end

	slot0.fsm_:SetInitState("wait")

	slot0.linkMethod_ = uv3.New()

	slot0.linkMethod_:AddMethodList({
		handler(slot0, slot0.OnLoadAndUnloadAssert),
		handler(slot0, slot0.OnPlayExitAnimationAndCommonAnimation),
		handler(slot0, slot0.OnExitOldRoutes),
		handler(slot0, slot0.OnUpdateCoincideRoutes),
		handler(slot0, slot0.OnEnterNewRoutes),
		handler(slot0, slot0.OnPlayEnterAnimation),
		handler(slot0, slot0.OnOpenOver)
	})

	slot0.backLinkMethod_ = uv3.New()

	slot0.backLinkMethod_:AddMethodList({
		handler(slot0, slot0.OnPlayExitAnimation),
		handler(slot0, slot0.OnExitOldRoutes),
		handler(slot0, slot0.OnUpdateCoincideRoutes),
		handler(slot0, slot0.OnEnterNewRoutes),
		handler(slot0, slot0.OnBackOver)
	})
end

function slot0.Open(slot0, slot1, slot2)
	if not slot0.fsm_:CanTransition("work") then
		table.insert(slot0.cmdEnqueue_, {
			type = uv0.JUMP_TYPE.GO,
			url = slot1,
			args = slot2
		})

		return
	end

	slot0.fsm_:Trigger("work")

	slot3, slot0.routes_, slot0.url_ = slot0:ParseUrl(slot1)
	slot6, slot7 = nil

	if slot0.curArgs_ then
		slot6 = slot0.curArgs_.params
		slot7 = slot0.curArgs_.context
	end

	if slot3 then
		slot6 = {}
		slot7 = {}
	end

	for slot11, slot12 in pairs(slot2.params or {}) do
		slot6[slot11] = slot12
	end

	for slot11, slot12 in pairs(slot2.extraContext or {}) do
		slot7[slot11] = slot12
	end

	slot0.curArgs_ = {
		params = slot6,
		isBack = slot2.isBack,
		isReplace = slot2.isReplace,
		isAsync = slot2.isAsync or false,
		isRootUrl = slot3,
		coincideRouteIndex = slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_),
		extraContext = slot7
	}

	if not slot0.curLinkMethod_ or slot0.curLinkMethod_:IsFree() then
		slot0.curLinkMethod_ = slot0.linkMethod_

		slot0.curLinkMethod_:StartNext()
	end
end

function slot0.Back(slot0, slot1, slot2)
	if not slot0.curLinkMethod_:IsFree() then
		table.insert(slot0.cmdEnqueue_, {
			type = uv0.JUMP_TYPE.BACK,
			cnt = slot1,
			params = slot2
		})

		return
	end

	if slot0:GetBackStepCnt(slot1) < #slot0.routes_ then
		slot0.oldRoutes_ = slot0.routes_
		slot4 = {}

		for slot8 = slot3, slot3 - slot1 + 1, -1 do
			slot9 = slot0.history_[#slot0.history_].url
			slot0.history_[#slot0.history_].url = string.sub(slot9, 0, strrchr(slot9, slot0.routes_[slot8]) - 2)
		end

		for slot8 = 1, slot3 - slot1 do
			table.insert(slot4, slot0.routes_[slot8])
		end

		slot0.routes_ = slot4

		if slot0.curLinkMethod_:IsFree() then
			slot0.fsm_:Trigger("work")

			slot0.curLinkMethod_ = slot0.backLinkMethod_

			slot0.backLinkMethod_:StartNext()
		end
	else
		if #slot0.history_ <= 1 then
			return
		end

		slot0.history_[#slot0.history_] = nil
		slot4 = slot0.history_[#slot0.history_]

		if slot2 then
			for slot8, slot9 in pairs(slot2) do
				slot4.args.params[slot8] = slot9
			end
		end

		while slot0:NeedBackNextUrl(slot0:GetRoutesFromUrl(slot4.url), slot4.args) do
			slot0.history_[#slot0.history_] = nil
			slot5 = slot0:GetRoutesFromUrl(slot0.history_[#slot0.history_].url)
		end

		slot4.args.isBack = true

		slot0:Open(slot4.url, slot4.args)
	end
end

function slot0.GetBackStepCnt(slot0, slot1)
	if type(slot1) ~= "number" then
		if slot0.routes_[#slot0.routes_] and slot0.recordMap_[slot3] then
			slot1 = slot0.recordMap_[slot3]:UIBackCount()
		else
			slot1 = 1
		end
	else
		slot3 = 0

		for slot7 = 1, slot1 do
			if slot0.routes_[slot2 - slot3] and slot0.recordMap_[slot8] then
				slot3 = slot3 + slot0.recordMap_[slot8]:UIBackCount()
			else
				break
			end
		end

		slot1 = slot3
	end

	return slot1
end

function slot0.NeedBackNextUrl(slot0, slot1, slot2)
	return false
end

function slot0.OnLoadAndUnloadAssert(slot0)
	slot0.curLinkMethod_:DoNext()
end

function slot0.OnPlayEnterAnimation(slot0)
	slot0.curLinkMethod_:DoNext()
end

function slot0.OnPlayExitAnimationAndCommonAnimation(slot0)
	slot0.curLinkMethod_:DoNext()
end

function slot0.OnPlayExitAnimation(slot0)
	slot0.curLinkMethod_:DoNext()
end

function slot0.OnExitOldRoutes(slot0)
	for slot5 = #slot0.oldRoutes_, slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_) + 1, -1 do
		slot0:ExitRoute(slot0.oldRoutes_[slot5])

		slot0.oldRoutes_[slot5] = nil
	end

	slot0.curLinkMethod_:DoNext()
end

function slot0.UpdateUrlHistory(slot0, slot1, slot2)
	if slot0:GetIndexFromHistory(slot0.history_, slot1, true) > 0 then
		for slot8 = #slot0.history_, slot4, -1 do
			slot0.history_[slot8] = nil
		end

		slot0.history_[slot4] = {
			url = slot1,
			args = slot2
		}
	elseif slot0:IsReplaceUrl(slot1) then
		slot0.history_[#slot0.history_] = {
			url = slot1,
			args = slot2
		}
	else
		table.insert(slot0.history_, {
			url = slot1,
			args = slot2
		})
	end
end

function slot0.IsReplaceUrl(slot0, slot1)
	return false
end

function slot0.GetIndexFromHistory(slot0, slot1, slot2, slot3)
	if slot0.routesCfg_[slot0:GetRoutesFromUrl(slot2)[1]].precedenceMerge == true then
		for slot8 = 1, #slot1 do
			if slot0:GetCoincideRoutesIndex(slot0:GetRoutesFromUrl(slot1[slot8].url), slot4) > 0 then
				return slot8
			end
		end

		return 0
	end

	for slot8 = #slot1, 1, -1 do
		slot9 = slot0:GetRoutesFromUrl(slot1[slot8].url)

		if slot3 and slot0.routesCfg_[slot9[1]].ignoreMerge and slot9[1] ~= slot4[1] then
			return 0
		end

		if slot0:GetCoincideRoutesIndex(slot9, slot4) > 0 then
			return slot8
		end
	end

	return 0
end

function slot0.GetRoutesFromUrl(slot0, slot1)
	return string.split(string.sub(slot1, 2, #slot1), "/")
end

function slot0.GetRouteCfgFromRouteName(slot0, slot1)
	if not slot1 then
		return nil
	end

	return slot0.routesCfg_[slot1]
end

function slot0.OnEnterNewRoutes(slot0)
	slot2 = {}
	slot0.newEnterRecords_ = {}

	for slot6 = slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_) + 1, #slot0.routes_ do
		if not slot0.routesCfg_[slot0.routes_[slot6]] then
			break
		end

		slot9, slot10 = ReduxFactory.GetInstance():GetReduxView(slot7, slot8)
		slot0.curArgs_.params.isBack = slot0.curArgs_.isBack

		if slot10 then
			slot9:SyncInit(slot7, slot11)
			LuaHidTools.EnsureHasInputPage(slot9)
		else
			slot9.params_ = slot11
		end

		slot9:UpdateLastOpenTime()
		slot9:CameraEnter(slot0.curArgs_.isRootUrl)
		slot9:OnEnter({
			preRouteName = slot0.routes_[slot6 - 1],
			curRouteName = slot7,
			isBack = slot0.curArgs_.isBack,
			routeLayer = slot0.curLayer_,
			extraContext = {
				slot0.curArgs_.extraContext
			}
		})
		slot9:AdaptScreen()
		LuaHidTools.EnterInputPage(slot9)

		if slot6 ~= #slot0.routes_ then
			table.insert(slot2, slot9)
		end

		if slot0.routes_[slot6] then
			slot0.recordMap_[slot7] = slot9
		end

		table.insert(slot0.newEnterRecords_, slot9)
	end

	slot0.oldRoutes_ = slot0.routes_

	if slot0.recordMap_[slot0.routes_[#slot0.routes_]] then
		slot3:OnTop()
		slot3:CheckWeakGuide()
	end

	for slot7 = 1, #slot2 do
		slot2[slot7]:OnUpdate()
	end

	slot0.curLinkMethod_:DoNext()
end

function slot0.OnUpdateCoincideRoutes(slot0)
	for slot5 = 1, slot0:GetCoincideRoutesIndex(slot0.oldRoutes_, slot0.routes_) do
		if slot0.recordMap_[slot0.oldRoutes_[slot5]] then
			if slot0.curArgs_.params then
				slot6:SetParams(slot0.curArgs_.params)
			end

			slot6:OnUpdate()
		end
	end

	if slot0.recordMap_[slot0.oldRoutes_[slot1]] then
		slot2:HideWeakGuide()
		slot2:OnBehind()
	end

	slot0.curLinkMethod_:DoNext()
end

function slot0.OnOpenOver(slot0)
	if slot0.curArgs_.isReplace then
		slot0.curArgs_.isReplace = false
		slot0.history_[#slot0.history_ > 0 and slot1 or 1] = {
			url = slot0.url_,
			args = slot0.curArgs_
		}
	elseif slot0.curArgs_.isRootUrl and slot0.curArgs_.coincideRouteIndex == 0 then
		slot0:UpdateUrlHistory(slot0.url_, slot0.curArgs_)
	else
		slot0.history_[slot1] = {
			url = slot0.url_,
			args = slot0.curArgs_
		}
	end

	slot0.fsm_:Trigger("wait")
	slot0.curLinkMethod_:DoNext()

	for slot5, slot6 in ipairs(slot0.newEnterRecords_) do
		slot6:OnEnterOver()
	end

	slot0:DoNextCommand()
end

function slot0.OnBackOver(slot0)
	slot0.fsm_:Trigger("wait")
	slot0.curLinkMethod_:DoNext()
	slot0:DoNextCommand()
end

function slot0.DoNextCommand(slot0)
	if #slot0.cmdEnqueue_ > 0 then
		slot0.cmdEnqueue_[#slot0.cmdEnqueue_] = nil

		if slot0.cmdEnqueue_[#slot0.cmdEnqueue_].type == uv0.JUMP_TYPE.GO then
			slot0:Open(slot1.url, slot1.args)
		else
			slot0:Back(slot1.backCnt, slot1.params)
		end
	end
end

function slot0.ExitRoute(slot0, slot1)
	if slot0.recordMap_[slot1] == nil then
		return
	end

	slot2:HideWeakGuide()
	slot2:OnExit()
	LuaHidTools.ExitInputPage(slot2)
	ReduxFactory.GetInstance():CacheReduxView(slot2)

	slot0.recordMap_[slot1] = nil
end

function slot0.ParseUrl(slot0, slot1)
	slot2 = ""
	slot3 = {}

	if string.char(string.byte(slot1)) == "/" then
		slot1 = string.sub(slot1, 2, #slot1)
	end

	slot7 = {}
	slot8 = ""

	if not slot5 then
		slot3, slot8 = slot0:UmergeRoutes(slot0.routes_, string.split(slot1, "/"))
	else
		slot3, slot8 = slot0:AppendRoutes(slot0.routes_, slot6)
	end

	return slot5, slot3, slot8
end

function slot0.UmergeRoutes(slot0, slot1, slot2)
	slot3 = {}
	slot4 = ""
	slot5 = #slot1

	for slot9, slot10 in ipairs(slot1) do
		if slot10 == slot2[1] then
			slot5 = slot9 - 1

			break
		end
	end

	for slot9 = 1, slot5 do
		table.insert(slot3, slot1[slot9])

		slot4 = string.format("%s/%s", slot4, slot1[slot9])
	end

	for slot9 = 1, #slot2 do
		slot10 = slot2[slot9]

		table.insert(slot3, slot10)

		slot4 = string.format("%s/%s", slot4, slot10)
	end

	return slot3, slot4
end

function slot0.AppendRoutes(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in ipairs(slot2) do
		if slot9 == slot1[slot8] then
			table.insert(slot3, slot9)

			slot4 = string.format("%s/%s", "", slot9)
		else
			break
		end
	end

	for slot8 = #slot3 + 1, #slot2 do
		table.insert(slot3, slot2[slot8])

		slot4 = string.format("%s/%s", slot4, slot2[slot8])
	end

	return slot3, slot4
end

function slot0.GetCoincideRoutesIndex(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in ipairs(slot2) do
		if not slot1[slot7] or slot8 ~= slot1[slot7] then
			return slot7 - 1
		end

		slot3 = slot7
	end

	return slot3
end

function slot0.RevertRoutes(slot0)
	slot0.oldRoutes_ = {}

	if #slot0.history_ <= 0 then
		return
	end

	slot1 = slot0.history_[#slot0.history_]

	slot0:Open(slot1.url, slot1.args)
end

function slot0.DestroyCurRoutes(slot0)
	for slot4 = #slot0.routes_, 1, -1 do
		slot0:ExitRoute(slot0.routes_[slot4])
	end

	slot0.routes_ = {}
end

function slot0.GetCurHistory(slot0)
	return slot0.history_
end

function slot0.SaveCacheHistory(slot0, slot1)
	if slot0.curLayer_ and table.keyof(slot0.saveHistoryLaylerList_, slot0.curLayer_) then
		slot0.cacheHistory_[slot0.curLayer_] = clone(slot0.history_)
	end

	slot0.curLayer_ = slot1

	if slot1 then
		slot0.history_ = clone(slot0.cacheHistory_[slot1]) or {}
	else
		slot0.history_ = {}
	end
end

return slot0
