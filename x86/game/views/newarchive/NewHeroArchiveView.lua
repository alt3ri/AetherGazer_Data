slot0 = class("NewHeroArchiveView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroArchive/ArchiveStoryMainUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.type_ = 1
	slot0.index_ = 0
	slot0.itemIndex_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.heroList_, NewHeroArchiveHeroItemView)
	slot0.allBtnController_ = ControllerUtil.GetController(slot0.allBtn_.transform, "state")

	slot0:InitFillterItem()
end

function slot0.InitFillterItem(slot0)
	slot1 = {}

	if not slot0.fillterBtnList_ then
		slot0.fillterBtnList_ = {}
	end

	for slot5, slot6 in pairs(RaceEffectCfg.all) do
		table.insert(slot1, RaceEffectCfg[slot6])
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.fillterBtnList_[slot5] then
			slot8 = NewHeroArchiveHeroFillterItemView.New(Object.Instantiate(slot0.fillterItem_), slot5)

			slot8.transform_:SetParent(slot0.btnList_, false)
			slot8:SetData(slot6, slot5)
			slot8:SetClickCallBack(handler(slot0, slot0.ClickFillterBtn))
			SetActive(slot8.gameObject_, true)
			table.insert(slot0.fillterBtnList_, slot8)
		end
	end
end

function slot0.ClickFillterBtn(slot0, slot1, slot2)
	if slot0.index_ == slot2 then
		return
	end

	slot0.index_ = slot2

	if slot0.type_ == 1 then
		slot0.archiveList_ = ArchiveData:GetContinuousHeartArchiveListByType(slot1)
	elseif slot0.type_ == 2 then
		slot0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveListByType(slot1)
	end

	slot0.itemIndex_ = 0

	slot0:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.archiveList_[slot1], slot0.type_)
	slot2:SetClickCallBack(function ()
		uv0.itemIndex_ = uv1
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		if uv0.index_ == 0 then
			return
		end

		uv0.index_ = 0
		uv0.itemIndex_ = 0

		if uv0.type_ == 1 then
			uv0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		else
			uv0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end

		uv0:RefreshUI()
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.itemIndex_ = 0

		if slot0 == 0 then
			uv0.type_ = 1
		else
			uv0.type_ = 2
		end

		uv0.index_ = 0

		if uv0.type_ == 1 then
			uv0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		else
			uv0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end

		uv0:RefreshUI()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.scrollPosX = slot0:DynamicDivision(slot0.uiList_:GetScrolledPosition().x)
	slot0.timer = Timer.New(function ()
		slot0 = uv0:DynamicDivision(uv0.uiList_:GetScrolledPosition().x)

		uv0.filmAni_:SetFloat("floatSpeed", (slot0 - uv0.scrollPosX) * 10)

		uv0.scrollPosX = slot0
	end, 0.1, -1, true)

	slot0.timer:Start()
	slot0:RefreshUI()
end

function slot0.DynamicDivision(slot0, slot1)
	slot2 = 10
	slot3 = 1

	if slot1 < 0 then
		slot3 = -1
		slot1 = -slot1
	end

	while slot1 > 1 do
		slot1 = slot1 / slot2
		slot2 = slot2 * 10
	end

	return slot1 * slot3
end

function slot0.RefreshUI(slot0)
	if not slot0.archiveList_ then
		if slot0.type_ == 1 then
			slot0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		elseif slot0.type_ == 2 then
			slot0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end
	end

	ArchiveData:SortHeartArchiveList(slot0.archiveList_)

	if slot0.index_ == 0 then
		slot0.allBtnController_:SetSelectedState("selected")
	else
		slot0.allBtnController_:SetSelectedState("unselected")
	end

	for slot4, slot5 in pairs(slot0.fillterBtnList_) do
		slot5:RefreshUI(slot0.type_, slot0.index_)
	end

	slot0.listTimer = Timer.New(function ()
		if uv0.heroList_.gameObject.activeInHierarchy == true then
			uv0.uiList_:StartScroll(#uv0.archiveList_)
			uv0.uiList_:ScrollToIndex(uv0.itemIndex_, true, false)
			uv0.listTimer:Stop()

			uv0.listTimer = nil
		end
	end, 0.1, -1, true)

	slot0.listTimer:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	if slot0.listTimer then
		slot0.listTimer:Stop()

		slot0.listTimer = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.fillterBtnList_ then
		for slot4, slot5 in pairs(slot0.fillterBtnList_) do
			slot5:Dispose()
		end
	end

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
