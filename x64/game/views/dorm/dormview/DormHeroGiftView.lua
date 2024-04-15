slot0 = class("DormHeroGiftView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormGiftFurnitureUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.giftScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FurnitureItem)
	slot0.fullController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.btnState = slot0.btn_okControllerexcollection_:GetController("default0")
end

function slot0.OnEnter(slot0)
	slot0.archiveID = slot0.params_.archiveID
	slot0.heroInfo = DormData:GetHeroInfoList()[slot0.archiveID]

	slot0:RegisterEvents()
	slot0:RefreshHeroGiftList()
	slot0:ResetView()

	if not slot0.heroInfo then
		Debug.LogError("未找到对应角色档案信息")
	end

	if slot0.params_.heroEID then
		slot0.heroEID = slot0.params_.heroEID
	end
end

function slot0.OnExit(slot0)
	slot0.heroEID = nil
	slot0.selFurID = nil
	slot0.itemIndex = nil

	slot0:RemoveAllEventListener()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.dataList_[slot1], slot0.selFurID, DormEnum.FurItemType.Gift, slot0.archiveID, slot1)
	slot2:OnPointerDown(function (slot0, slot1)
		if uv0.selFurID == slot0 then
			return
		end

		uv0.selFurID = slot0
		uv0.itemIndex = slot1

		if uv0.heroInfo:GetCanGiftNum(uv0.selFurID) <= 0 then
			uv0.fullController:SetSelectedState("false")
			uv0.btnState:SetSelectedState("off")

			uv0.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		else
			uv0.furNumMax = math.max(slot2, 1)
			uv0.progressSlr_.maxValue = uv0.furNumMax

			uv0.fullController:SetSelectedState("true")
			uv0.btnState:SetSelectedState("on")
			uv0:SetfurNum(1)
		end

		uv0.giftScroll:Refresh()
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function ()
		uv0:RefreshHeroGiftList()
		uv0:ResetView()
	end)
	slot0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function ()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.giftBtn_, nil, function ()
		if uv0.selFurID and uv0.progressSlr_.value > 0 then
			DormAction:GiftFurToHero(uv0.archiveID, {
				[uv0.selFurID] = uv0.progressSlr_.value
			}, uv0.heroEID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddToggleListener(slot0.progressSlr_, function ()
		if uv0.progressSlr_.value < 1 then
			uv0.progressSlr_.value = 1
		end

		if uv0.selFurID then
			uv0:SetfurNum(uv0.progressSlr_.value)
		end
	end)
	slot0:AddPressingByTimeListener(slot0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.selFurID and uv0.progressSlr_.value > 1 then
			uv0:SetfurNum(uv0.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.selFurID and uv0.progressSlr_.value < uv0.furNumMax then
			uv0:SetfurNum(uv0.progressSlr_.value + 1)

			return true
		end

		return false
	end)
end

function slot0.SetfurNum(slot0, slot1)
	slot0.numText_.text = slot1
	slot0.progressSlr_.value = slot1
	slot0.reduceNumBtn_.interactable = slot1 > 1
	slot0.addNumBtn_.interactable = slot1 < slot0.progressSlr_.maxValue
end

function slot0.RefreshHeroGiftList(slot0)
	slot0.dataList_ = {}

	for slot5, slot6 in pairs(DormData:GetFurnitureInfoList()) do
		if BackHomeFurniture[slot5].is_give == 1 and slot6.give_num < slot6.num then
			table.insert(slot0.dataList_, slot5)
		end
	end

	CommonTools.UniversalSortEx(slot0.dataList_, {
		map = function (slot0)
			if DormData:GetHeroInfo(uv0.archiveID):GetCanGiftNum(slot0) == 0 then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function (slot0)
			return slot0
		end
	})

	if not slot0.selFurID and #slot0.dataList_ > 0 then
		slot0.selFurID = slot0.dataList_[1]
	end

	slot0.giftScroll:StartScroll(#slot0.dataList_)

	if slot0.itemIndex then
		slot0.giftScroll:ScrollToIndex(slot0.itemIndex, true, false)
	end

	if #slot0.dataList_ == 0 then
		slot0.listText.text = ""

		slot0.fullController:SetSelectedState("false")
		slot0.btnState:SetSelectedState("off")
	end
end

function slot0.ResetView(slot0)
	if slot0.selFurID then
		slot1 = false

		for slot5, slot6 in ipairs(slot0.dataList_) do
			if slot6 == slot0.selFurID then
				slot1 = true

				break
			end
		end

		if not slot1 then
			slot0.fullController:SetSelectedState("false")
			slot0.btnState:SetSelectedState("off")

			slot0.fullText.text = ""

			return
		end

		if slot0.heroInfo:GetCanGiftNum(slot0.selFurID) <= 0 then
			slot0.fullController:SetSelectedState("false")
			slot0.btnState:SetSelectedState("off")

			slot0.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		else
			slot0.progressSlr_.minValue = 0
			slot0.furNumMax = slot2
			slot0.progressSlr_.maxValue = slot0.furNumMax

			slot0.fullController:SetSelectedState("true")
			slot0.btnState:SetSelectedState("on")
			slot0:SetfurNum(1)
		end
	else
		slot0.fullController:SetSelectedState("false")
		slot0.btnState:SetSelectedState("off")

		slot0.fullText.text = ""
	end
end

function slot0.Dispose(slot0)
	if slot0.giftScroll then
		slot0.giftScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
