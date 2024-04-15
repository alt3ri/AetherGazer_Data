slot0 = class("AdminCatExplorePopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExplpreInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.hourList = {}

	for slot4 = 4, 12 do
		slot0.hourList[slot4] = slot0["hour" .. slot4 .. "_"]
	end

	slot0.rewardList = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.rewardList_, CommonItemView)
	slot0.adminCatList = LuaList.New(handler(slot0, slot0.SetAdminCatItem), slot0.adminCatList_, AdminCatExploreItem)
end

function slot0.SetRewardItem(slot0, slot1, slot2)
	CommonTools.SetCommonData(slot2, {
		id = ExploreAreaCfg[slot0.regionId].reward[slot1][1],
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.SetAdminCatItem(slot0, slot1, slot2)
	slot2:SetData(slot0.catList[slot1], slot1 == slot0.selectAdminCat, handler(slot0, slot0.AdminCatItemRegisterFunction), slot1)

	slot0.adminCatItemList[slot1] = slot2
end

function slot0.AdminCatItemRegisterFunction(slot0, slot1)
	if slot0.catList[slot1] == nil or slot0.catList[slot1].canUse == false then
		return
	end

	for slot5 = 1, #slot0.catList do
		if slot0.adminCatItemList[slot5]:GetStateController():GetSelectedState() ~= "lock" then
			slot6:SetSelectedState(slot5 == slot1 and "sel" or "normal")

			slot0.selectAdminCat = slot1
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.exploreBtn_, nil, function ()
		slot0 = AdminCatExploreData:GetDataByPara("exploringCount")
		slot1 = AdminCatExploreData:GetDataByPara("level")

		if not GuideData:IsFinish(56) then
			uv0:Back()

			return
		end

		if ExploreLevelCfg[slot1].amount <= slot0 then
			ShowTips("EXPLORE_BEGIN_CONDITION_3")

			return
		end

		if uv0.catList[uv0.selectAdminCat].canUse == false then
			ShowTips("EXPLORE_MIMIR_NO_EXIST")

			return
		end

		AdminCatExploreAction.AdminCatExplore(uv0.catList[uv0.selectAdminCat].id, uv0.selectHour, uv0.regionId)
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)

	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0:Back()
	end)

	for slot4, slot5 in pairs(slot0.hourList) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:SetHourState(uv1)
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2
end

function slot0.SetHourState(slot0, slot1)
	if slot0.maxExploreHour < slot1 then
		return
	end

	for slot5 = 4, slot0.maxExploreHour do
		ControllerUtil.GetController(slot0.hourList[slot5].transform, "name"):SetSelectedState(slot5 == slot1 and "sel" or "normal")

		slot0.selectHour = slot1
	end
end

function slot0.UpdateView(slot0)
	slot1 = ExploreAreaCfg[slot0.regionId]
	slot0.adminCatItemList = {}
	slot0.regionMapImage_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/" .. slot1.icon)
	slot0.regionNameTxt_.text = GetI18NText(slot1.area_name)
	slot0.regionDescTxt_.text = GetI18NText(slot1.description)
	slot0.catList = AdminCatExploreData:SortAdminCatList(slot0.regionId)

	slot0.adminCatList:StartScroll(#slot0.catList > 6 and #slot0.catList or 6)
	slot0.rewardList:StartScroll(#ExploreAreaCfg[slot0.regionId].reward)
	AdminCatExploreData:CalculateMaxExploreHour()
end

function slot0.OnExploreUpdate(slot0)
	ShowTips("EXPLORE_BEGIN")
	slot0:Back()
end

function slot0.SetLockHour(slot0)
	for slot4 = 4, 12 do
		if slot0.maxExploreHour < slot4 then
			ControllerUtil.GetController(slot0.hourList[slot4].transform, "name"):SetSelectedState("lock")
		else
			slot5:SetSelectedState(slot4 == slot0.maxExploreHour and "sel" or "normal")
		end
	end
end

function slot0.OnEnter(slot0)
	slot0.selectAdminCat = 1
	slot0.regionId = slot0.params_.regionId

	slot0:UpdateView()

	slot0.maxExploreHour = AdminCatExploreData:GetDataByPara("maxExploreHour")
	slot0.selectHour = slot0.maxExploreHour

	slot0:SetLockHour()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.adminCatItemList) do
		slot5:OnExit()
	end

	slot0.adminCatItemList = {}
end

function slot0.Dispose(slot0)
	if slot0.rewardList then
		slot0.rewardList:Dispose()

		slot0.rewardList = nil
	end

	if slot0.adminCatList then
		slot0.adminCatList:Dispose()

		slot0.adminCatList = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.hourList = {}
end

return slot0
