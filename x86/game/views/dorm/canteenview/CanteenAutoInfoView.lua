slot0 = class("CanteenAutoInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dining/BackHomeCanteenBusinessDetailsUI"
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
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvent()
	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	slot0.selHero = nil

	slot0:RemoveAllEventListener()

	if slot0.foodList then
		for slot4, slot5 in pairs(slot0.foodList) do
			slot5:Dispose()
		end

		slot0.foodList = nil
	end

	if slot0.buffList then
		for slot4, slot5 in pairs(slot0.buffList) do
			slot5:Dispose()
		end

		slot0.buffList = nil
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SIGN_FOOD_INFO_CHANGE, function ()
		uv0:RefreshSignFoodInfo()
	end)
	slot0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function ()
		uv0:RefreshJobInfo()
	end)
end

function slot0.RefreshView(slot0)
	slot0:RefreshBuffInfo()
	slot0:RefreshSignFoodInfo()
	slot0:RefreshJobInfo()
end

function slot0.RefreshBuffInfo(slot0)
	slot0.skillList = {}

	for slot5, slot6 in ipairs(CanteenConst.AutoInfo) do
		if slot6 == CanteenConst.HeroSkillType.FoodCostQucik or slot6 == CanteenConst.HeroSkillType.FoodCostRise then
			for slot10, slot11 in pairs(DormEnum.FurnitureTypeNum) do
				if DormSkillData:GetSkillEffect(slot6, nil, , slot11) ~= 0 then
					table.insert(slot0.skillList, {
						skillType = slot6,
						foodType = slot11
					})
				end
			end
		elseif DormSkillData:GetSkillEffect(slot6) > 0 then
			table.insert(slot0.skillList, {
				skillType = slot6
			})
		end
	end

	if not slot0.buffList then
		slot0.buffList = {}

		if #slot0.skillList > 0 then
			for slot6 = 1, slot2 do
				slot0.buffList[slot6] = CanteenGainItem.New(slot0.buffitemGo_1, slot0.contentTrs_)
			end
		end
	end

	if slot0.buffList then
		for slot5, slot6 in pairs(slot0.buffList) do
			slot6:RefreshUI(slot0.skillList[slot5])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.buffContentTrs)
end

function slot0.RefreshSignFoodInfo(slot0)
	slot0.signFoodList = {}
	slot0.signFoodList = CanteenFoodData:GetChooseFoodList()

	if not slot0.foodList then
		slot0.foodList = {}

		if #slot0.signFoodList > 0 then
			for slot5 = 1, slot1 do
				slot0.foodList[slot5] = CanteenSignFoodInfoItem.New(slot0.incomeitemGo_1, slot0.incomepanelTrs_)
			end
		end
	end

	if slot0.foodList then
		for slot4, slot5 in pairs(slot0.foodList) do
			slot5:RefreshUI(slot0.signFoodList[slot4])
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs)
end

function slot0.RefreshJobInfo(slot0)
	slot0.jobList = {}

	for slot4, slot5 in ipairs(DormEnum.RestaurantJobToClientMap) do
		table.insert(slot0.jobList, slot4)
	end

	if not slot0.heroList then
		slot0.heroList = {}

		if #slot0.jobList > 0 then
			for slot5 = 1, slot1 do
				slot0.heroList[slot5] = CanteenJobInfoItem.New(slot0.heroitemGo_1, slot0.positionpanelTrs_)
			end
		end
	end

	if slot0.heroList then
		for slot4, slot5 in pairs(slot0.heroList) do
			slot5:RefreshUI(slot0.jobList[slot4])
		end
	end
end

function slot0.indexBuffList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillList[slot1])
end

function slot0.indexSignFoodList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.signFoodList[slot1])
end

function slot0.indexJobList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillList[slot1])
end

function slot0.Dispose(slot0)
	if slot0.heroScroll then
		slot0.heroScroll:Dispose()

		slot0.heroScroll = nil
	end

	if slot0.buffList then
		for slot4, slot5 in pairs(slot0.buffList) do
			slot5:Dispose()
		end
	end

	if slot0.heroList then
		for slot4, slot5 in pairs(slot0.heroList) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
