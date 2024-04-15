slot0 = class("AchievementInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.rewardItems_ = {}

	for slot5 = 1, 3 do
		slot0.rewardItems_[slot5] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot5)])
	end

	slot0:AddListeners()

	slot0.controller_ = slot0.allBtnController_:GetController("all")
	slot0.greyController = slot0.greyController_:GetController("grey")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "category")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = uv0.achievementID_
		slot1 = AchievementCfg[slot0]

		AchievementAction.GetReceiveReward(slot0)
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if AchievementCfg[uv0.achievementID_].source[1] == nil then
			print("成就的跳转是空的", slot0)

			return
		end

		AchievementData:SetScrollRecord(true)
		JumpTools.JumpToPage2(slot1.source)
	end)
end

function slot0.SetData(slot0, slot1)
	slot2 = AchievementCfg[slot1]

	if slot1 ~= slot0.achievementID_ then
		slot0.nameText_.text = GetI18NText(slot2.name)
		slot0.titleText_.text = GetI18NText(slot2.desc)
	end

	if AchievementData:GetAchievementData(slot1).rewardState == 0 then
		slot0.controller_:SetSelectedState("go")
		slot0.greyController:SetSelectedState("false")

		slot8 = slot3.process
		slot9 = slot2.need
		slot0.progressText_.text = string.format("%s/%s", slot8, slot9)
		slot0.progressBar_.value = slot3.process / slot2.need

		for slot8, slot9 in pairs(slot2.reward) do
			slot10 = clone(ItemTemplateData)
			slot10.id = slot9[1]
			slot10.number = slot9[2]

			function slot10.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.rewardItems_[slot8]:SetData(slot10)
		end

		for slot8 = #slot4 + 1, 3 do
			slot0.rewardItems_[slot8]:SetData(nil)
		end
	elseif slot3.rewardState == 1 then
		slot0.controller_:SetSelectedState("receive")
		slot0.greyController:SetSelectedState("false")

		slot8 = slot2.need
		slot9 = slot2.need
		slot0.progressText_.text = string.format("%s/%s", slot8, slot9)
		slot0.progressBar_.value = 1

		for slot8, slot9 in pairs(slot2.reward) do
			slot10 = clone(ItemTemplateData)
			slot10.id = slot9[1]
			slot10.number = slot9[2]

			function slot10.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.rewardItems_[slot8]:SetData(slot10)
		end

		for slot8 = #slot4 + 1, 3 do
			slot0.rewardItems_[slot8]:SetData(nil)
		end
	else
		slot0.controller_:SetSelectedState("complete")
		slot0.greyController:SetSelectedState("true")

		slot8 = slot2.need
		slot9 = slot2.need
		slot0.progressText_.text = string.format("%s/%s", slot8, slot9)
		slot0.progressBar_.value = 1

		for slot8, slot9 in pairs(slot2.reward) do
			slot10 = clone(ItemTemplateData)
			slot10.id = slot9[1]
			slot10.number = slot9[2]
			slot10.grayFlag = true

			function slot10.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.rewardItems_[slot8]:SetData(slot10)
		end

		for slot8 = #slot4 + 1, 3 do
			slot0.rewardItems_[slot8]:SetData(nil)
		end

		slot0.textFinishTime_.text = manager.time:DescCTime(slot3.timestamp, "%Y/%m/%d")
	end

	slot0.typeController_:SetSelectedState(slot2.type_id)

	slot0.achievementID_ = slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		if slot5 then
			slot5:Dispose()
		end
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
